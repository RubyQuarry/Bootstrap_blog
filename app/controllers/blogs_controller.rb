class BlogsController < ApplicationController

  before_action :sort_blogs, only: [:index, :search]
  before_action :find_blog, only:  [:edit, :update, :show, :destroy]

  def index
    if admin_signed_in?
      @blogs = Blog.all.order('created_at DESC').paginate(page: params[:page], per_page: 4)
    end
  end

  def show
    @comment = Comment.new
    @comments = @blog.comments.favorites
  end

  def search
    if params[:keyword] # keyword query
      @blogs = @blogs.search(params[:keyword]).published
    elsif params[:month] && params[:year]   # archive query
      month = Date.new(params[:year].to_i, params[:month].to_i)
      @blogs = @blogs.monthly(month).published
    end

    render :index
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      flash[:success] = "Update Successful"
      redirect_to :action => 'show', :id => @blog
    else
      flash[:danger] = "Update did not work"
      redirect_to :back
    end
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = "Create Successful"
      redirect_to @blog
    else
      flash[:danger] = "Create did not work"
      redirect_to :back
    end
  end

  def destroy
    @blog.destroy
    if @blog.destroyed?
      flash[:success] = "deletion worked"
      redirect_to :back
    else
      flash[:danger] = "deletion FAILED"
      redirect_to :back
    end
  end

  private

  def sort_blogs
    @blogs = Blog.inorder.published.paginate(page: params[:page], per_page: 4)
  end

  def blog_params
    params.require(:blog).permit(:author, :content, :title, :keywords, :published)
  end

  def find_blog
    @blog = Blog.find(params[:id])
  end

end
