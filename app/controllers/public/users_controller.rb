class Public::UsersController < ApplicationController

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "会員情報を更新しました"
    else
      render "edit"
    end
  end

  def unsubscribe
  end

  def withdraw
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email, :is_deleted)
  end
  
end
