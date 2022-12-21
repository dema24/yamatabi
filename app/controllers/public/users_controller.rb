class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :withdraw]
  before_action :ensure_normal_user, only: [:update, :withdraw]

  def index
    @users = User.where(is_deleted: false).page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    if @user.is_deleted?
      redirect_to root_path
    end
    @posts = @user.posts.page(params[:page]).per(10).order(created_at: :desc)
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

  def favorite
    @user = User.find(params[:id])
    favorite = Favorite.where(user_id: @user.id).order(created_at: :desc).pluck(:post_id)
    @favorite_post = Post.find(favorite)
    @favorite_posts = Kaminari.paginate_array(@favorite_post).page(params[:page]).per(10)

  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email, :is_deleted)
  end

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      flash[:notice] = 'ゲストユーザーの更新・削除はできません。'
      redirect_to root_path
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
