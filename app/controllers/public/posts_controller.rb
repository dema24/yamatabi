class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  def index
    @posts = Post.page(params[:page]).per(9).order(created_at: :desc)
    @tag_list = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').page(params[:page]).per(10)
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

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to  request.referer
    end
  end
end
