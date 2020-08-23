class UsersController < ApplicationController
include CommonActions
before_action :authenticate_user!, only: [:destroy, :update, :show]
before_action :set_params, only: [:edit, :show, :update, :destroy]
before_action :authorized_user, only: [:download_users, :destroy]
before_action :power_finder, only: [:edit, :update]

    
def show
  @orders = @user.orders.paginate(:page => params[:page], :per_page => 20)
end

def download_users
  respond_to do |format|
    @users = User.all
    format.csv do
      send_data render_to_string, filename: "userlist.csv", type: :csv
    end
  end
end

def destroy
  if @user.destroy
  redirect_to "/orders/authority"
  flash[:notice] = "削除しました"
  else
  flash[:notice] = "削除できねーっす"
  end
end

  
def edit  
end

def manual
end

def update
  if params[:certificate].present?
    @user.update(power_id: 2) if @actives.blank?
    @user.update(user_params)
    redirect_to "/orders/authority"
    flash[:notice] = "更新できました。(登録番号は：#{@user.certificate})"
  elsif params[:certificate].blank?
    @user.update(power_id: 2) if @actives.blank?
    @user.update(user_params_no_certificate)
    redirect_to "/orders/authority"
    flash[:notice] = "更新できました。"
  else
    redirect_to "/orders/authority"
    flash[:notice] = "更新できませんでした"
  end
end


private
def user_params
  params.permit(:certificate, :authority, :email, :power_id)
end

def user_params_no_certificate
  params.permit(:authority, :email, :power_id, :company, :driver, :phone)
end  

def set_params
  @user = User.find(params[:id])
end

def authorized_user
  if current_user
  redirect_to new_user_session_path unless current_user.authority == 1
  else
  redirect_to new_user_session_path
  end
end

    
end
