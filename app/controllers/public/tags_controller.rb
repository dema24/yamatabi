class Public::TagsController < ApplicationController

  def tag
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.page(params[:page]).per(9).order(created_at: :desc)
    @tag_list = Tag.all
  end

end
