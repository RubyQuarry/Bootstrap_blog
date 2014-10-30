class CommentsController < ApplicationController

  before_action :find_comment, only: [:destroy, :update]

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)
    if @comment.save
      CommentMailer.comment_email(@comment)
    end
    respond_to do |format|
      format.html { render 'blogs/show' }
      format.js
    end
  end

  def update
    @comment.increment!(:vote)

    respond_to do |format|
      format.html { render 'blogs/show' }
      format.js
    end
  end

  def destroy
    @comment.destroy

    redirect_to :back
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :name, :email, :feeling, :vote)
  end
end
