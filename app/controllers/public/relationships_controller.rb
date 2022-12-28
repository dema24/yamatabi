class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:id])
		@users = user.followings.page(params[:page]).per(10)
  end

  def followers
    user = User.find(params[:id])
		@users = user.followers.page(params[:page]).per(10)
  end

  def follow
    @users = current_user.followings
    @posts = Post.where(user_id: @users).order(created_at: :desc).page(params[:page]).per(9)
    @tag_list = Tag.joins(:post_tags).group(:tag_id).order('count(post_id) desc').page(params[:page]).per(10)
  end
end
