class Admin::UsersController < ApplicationController
  skip_before_action :authenticate_user!, except: [:top]
  before_action :authenticate_admin!, except: [:top]
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction, :email, :is_deleted)
  end
end
