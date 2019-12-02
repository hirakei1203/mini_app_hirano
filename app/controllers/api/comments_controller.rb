class Api::CommentsController < ApplicationController
  def index
    log = Log.find(params[:log_id])
    last_comment_id = params[:id].to_i
    @comments = log.comments.includes(:user).where("id > #{last_comment_id}")
  end
end