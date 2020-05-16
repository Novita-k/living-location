class PostsController < ApplicationController
before_action :set_posts, only: [:index]
before_action :set_post, only: [:edit, :show]
before_action :move_to_index, except: [:index, :show, :search]

  def index
    @all = Post.includes(:user).order("created_at DESC")
    @hash = Gmaps4rails.build_markers(@all) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string(partial: "posts/infowindow", locals: { place: place })
      marker.json({:id => place.id})
    end
  end

  def new
    @post = Post.new
    @post.images.new
  end

  def renew #写真に位置情報がなかった場合addressを入力してもらうページ。
    @post = Post.new
    @post.images.new
  end

  def create
    require 'exifr/jpeg'
    @post = Post.new(post_params)
    hash = EXIFR::JPEG::new(params[:post][:images_attributes]["0"]["image"].tempfile) #paramsからimageのメタタグ情報を取得。
    @post.date_time = hash.date_time #date_timeのインスタンスを作成。
    results = Geocoder.search(@post[:address]) #逆geocoder可能なaddressが入力されているか保存前にresultsを作ってチェック。
    unless @post.images[0].present?
      flash.now[:alert] = "写真無しの投稿は出来ません"
      @post.images.new
      render :new and return
    else #画像ファイルがjpg/jpegファイルかつ、gps情報が存在するかチェック。
      # binding.pry
      if @post.images[0].image.filename.downcase.end_with?(".jpeg", ".jpg") && hash.gps.present?
        #位置情報のインスタンスを作成。
        @post.latitude = hash.gps.latitude
        @post.longitude = hash.gps.longitude
      elsif @post.address.present? && results.first.present? #addressが入力されているか、入力された物でgps情報を取得できるかチェック。
        @post.save
        redirect_to root_path and return
      else
        flash.now[:alert] = "画像に位置情報が有りません。実在する地名を住所欄に追加して下さい"
        render "renew" and return
      end
    end
    if @post.valid?
    @post.save
    redirect_to root_path
    else
      @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
      render :new
    end
  end

  def edit
    
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
  end

  def show
    @comment = Comment.new
    @comment.images.new
    @comments = @post.comments.includes(:user)
    @like = Like.new

    @hash = Gmaps4rails.build_markers(@post) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string(partial: "posts/infowindow", locals: { place: place })
      marker.json({:id => place.id})
    end
  end

  def search
    @posts = Post.search(params[:keyword]).order("created_at DESC").page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text,:latitude, :longitude, :address, :date_time, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_posts
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
