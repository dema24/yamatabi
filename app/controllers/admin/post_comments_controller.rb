class Admin::PostCommentsController < ApplicationController
skip_before_action :authenticate_user!, except: [:top]
  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end
end
