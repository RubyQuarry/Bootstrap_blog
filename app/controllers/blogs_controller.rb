class BlogsController < ApplicationController


  def index
    @blogs = Blog.all.paginate(page: params[:page], per_page: 3)

  end

  def show
  end
end
