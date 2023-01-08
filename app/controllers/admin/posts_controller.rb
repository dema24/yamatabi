class Admin::PostsController < ApplicationController
  skip_before_action :authenticate_user!, except: [:top]
  before_action :authenticate_admin!, except: [:top]

  def index
    @posts = Post.page(params[:page]).per(8).order(created_at: :desc)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
