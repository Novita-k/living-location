class PostsController < ApplicationController
before_action :set_post, only: [:edit, :show]
before_action :move_to_index, except: [:index, :show, :search]

  def index
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
    redirect_to root_path
    else
      @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
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
    @hash = Gmaps4rails.build_markers(@place) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow place.name
    end
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  private
  def post_params
    params.require(:post).permit(:title, :image, :text).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
