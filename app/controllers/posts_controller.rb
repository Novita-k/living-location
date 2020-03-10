class PostsController < ApplicationController
before_action :set_post, only: [:edit, :show]
before_action :move_to_index, except: [:index, :show]

  def index
    @Posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
  end

  def edit
    
  end

  def destory
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    
  end

  private
  def post_params
    params.require(:post).permit(:title, :image, :text).merge(user_id: current_user.id)
  end

  def before_action
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
