class Public::PostCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  def create
    post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = post.id
    @comment.save
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def ensure_correct_user
    @comment = PostComment.find(params[:id])
    unless @comment.user == current_user
      redirect_to request.referer
    end
  end
end
