class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)
    if @comment.save
      redirect_to :back
    end
  end

  def update
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :name, :email)
  end
end
