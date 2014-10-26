class CommentMailer < ActionMailer::Base
  default to: "ajn123@vt.edu",
          from: "ajn123@vt.edu"

  def comment_email(comment)
    @comment = comment
    mail(subject:comment.email + "\n" + comment.name + "\n" + comment.text).deliver
  end


end
