class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html {redirect_to "/logs/#{@comment.log.id}"} 
      format.json 
    end
  end

  private
  def comment_params
    params.permit(:comment, :log_id).merge(user_id: current_user.id)
  end
end
