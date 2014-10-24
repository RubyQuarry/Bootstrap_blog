class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)
    @comment.save
    respond_to do |format|
      format.html { render 'blogs/show' }
      format.js
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.increment!(:vote)

    respond_to do |format|
      format.html { render 'blogs/show' }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :name, :email, :feeling, :vote)
  end
end
