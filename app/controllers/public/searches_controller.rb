class Public::SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    if @model == 'user'
      @records = User.where('name LIKE ?', '%' + @content + '%').page(params[:page]).per(10)
    else
      @records = Post.where('title LIKE ?', '%' + @content + '%').page(params[:page]).per(10)
    end
  end
end
