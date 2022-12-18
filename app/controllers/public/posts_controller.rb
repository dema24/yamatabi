class Public::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(9)
    @tag_list = Tag.all
  end

  def follow
    @users = current_user.followings
    @users.each do |user|
      @posts = user.posts.page(params[:page]).per(9)
    end
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')

    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :main_image, sub_images: [])
  end
end
