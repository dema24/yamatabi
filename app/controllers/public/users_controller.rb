class Public::UsersController < ApplicationController

  def index
    @users = User.where(is_deleted: false).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: "会員情報を更新しました"
    else
      render "edit"
    end
  end

  def unsubscribe
  end

  def withdraw
    current_user.update(is_deleted: true, name: "退会したアカウント", introduction: "")
    current_user.profile_image.purge
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email, :is_deleted)
  end

end
