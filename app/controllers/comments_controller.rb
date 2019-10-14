class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/logs/#{comment.log.id}"
  end

  private
  def comment_params
    params.permit(:comment, :log_id).merge(user_id: current_user.id)
  end
end
