class Public::TagsController < ApplicationController

  def tag
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.page(params[:page]).per(9).order(created_at: :desc)
    @tag_list = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').page(params[:page]).per(10)
  end

end
