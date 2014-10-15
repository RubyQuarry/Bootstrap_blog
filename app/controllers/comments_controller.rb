class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)


    respond_to do |format|
      @comment.save
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :name, :email, :feeling)
  end
end
