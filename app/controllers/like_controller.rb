class LikeController < ApplicationController
  def create
    binding.pry
    @post = Post.find(params[:post_id])
    unless @post.like?(current_user)
      @post.add_like(current_user)
      respond_to do |format|
        format.html { redirect_to request.referer || root_url}
        format.js
      end
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    if @post.like?(current_user)
      @post.del_like(current_user)
      respond_to do |format|
        format.html { redirect_to request.referer || root_url}
        format.js
      end
    end
  end
end
