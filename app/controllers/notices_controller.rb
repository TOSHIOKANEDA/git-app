class NoticesController < ApplicationController

  include CommonActions
  before_action :authorized_user, only: [:create, :destroy, :index]
  before_action :authenticate_user!
  before_action :power_finder, only: [:index]


  def index
    @notice = Notice.new
    @notices = Notice.all.order(created_at: "DESC")
  end

  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      redirect_back(fallback_location: notices_path)
    else
      redirect_back(fallback_location: notices_path)
      flash[:notice] = "作成できませんでした"
    end
  end

  def destroy
    @notice = Notice.find(params[:id])
    if current_user.authority == 1
    @notice.destroy
    redirect_back(fallback_location: root_path)
    else
    redirect_back(fallback_location: root_path)
    flash[:notice] = "削除可能できませんでした"
    end
  end
  
  private

  def notice_params
    params.require(:notice).permit(:text).merge(user_id: current_user.id)
  end

end
