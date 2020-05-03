class PostsController < ApplicationController
before_action :set_posts, only: [:index,:new, :renew, :create, :update, :show] #gmapscriptのエラー防止の為全てに設置
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

  def renew
    @post = Post.new
  end

  def create
    require 'exifr/jpeg'
    @post = Post.new(post_params)
    results = Geocoder.search(@post[:address])
    unless @post.image.present?
      flash.now[:alert] = "写真無しの投稿は出来ません"
      render :new and return
    else
      if @post.image.filename.downcase.end_with?(".jpeg", ".jpg") && EXIFR::JPEG.new(@post.image.file.file).gps.present?
        @post.latitude = EXIFR::JPEG::new(@post.image.file.file).gps.latitude
        @post.longitude = EXIFR::JPEG::new(@post.image.file.file).gps.longitude
      elsif @post.address.present? && results.first.present?
        @post.save
        redirect_to root_path and return
      else
        flash.now[:alert] = "位置情報が有りません。実在する地名、又は位置情報を追加して下さい"
        render "renew" and return
      end
    end
    if @post.save
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
    @posts = Post.search(params[:keyword])
  end

  private
  def post_params
    params.require(:post).permit(:title, :image, :text,:latitude, :longitude, :address, :date_time, images_attributes: [:image]).merge(user_id: current_user.id)
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
