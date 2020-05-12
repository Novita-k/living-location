class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    # binding.pry
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      @post = Post.find(params[:post_id])
      render template: 'posts/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text, images_attributes: [:image]).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
