class Public::SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    if @model == 'user'
      @users = User.where('name LIKE ?', '%' + @content + '%')
      @records = @users.where(is_deleted: false).page(params[:page]).per(10)
    else
      @records = Post.where('title LIKE ?', '%' + @content + '%').page(params[:page]).per(8)
    end
  end
end
