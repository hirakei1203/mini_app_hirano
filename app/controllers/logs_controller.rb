class LogsController < ApplicationController
  before_action :ranking
  
  def index
    @q = Log.ransack(params[:q])
    @logs = @q.result(distinct: true).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
  end

  def create
    Log.create(logs_params)
    redirect_to action: :index
  end

  def show
    @log = Log.find(params[:id])
    @comments = @log.comments.includes(:user)
  end

  def edit
    @log = Log.find(params[:id])
  end

  def update
    # binding.pry
    log = Log.find(params[:id])
    if log.user_id == current_user.id
      log.update(logs_params2)
    end
    redirect_to action: :index
  end

  def destroy
    log = Log.find(params[:id])
    if log.user_id == current_user.id
      log.destroy
    end
    redirect_to action: :index
  end

  def ranking
    user_ids = Comment.group(:user_id).order('count_user_id DESC').limit(3).count(:user_id).keys
    @ranking = user_ids.map { |user_id| User.find(user_id) }
  end

  private
  def logs_params
    params.permit(:logs, :problem, :date, :title).merge(user_id: current_user.id)
   end
   #なぜかnewページのparamsがハッシュで飛んでいない

  def logs_params2
   params.require(:log).permit(:logs, :problem, :date, :title).merge(user_id: current_user.id)
  end

end
