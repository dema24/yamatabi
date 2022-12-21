class Admin::PostsController < ApplicationController
  skip_before_action :authenticate_user!, except: [:top]
  before_action :authenticate_admin!, except: [:top]

  def index
    @posts = Post.page(params[:page]).per(9).order(created_at: :desc)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
