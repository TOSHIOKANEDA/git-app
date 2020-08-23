class MyTrucksController < ApplicationController
  include CommonActions
  before_action :truck_selection, only: [:index]
  

  def index
    @my_trucks = MyTruck.where(user_id: current_user.id)
  end

  def new
  end

  def destroy
    @my_truck = MyTruck.find(params[:id])
    if @my_truck.destroy
      redirect_back(fallback_location: root_path)
      flash[:notice] = "保存したトラックを削除しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "削除に失敗しました"
    end
  end

  def create
    @my_truck = MyTruck.new(my_truck_params)
    if @my_truck.save
      redirect_back(fallback_location: index_my_trucks_path)
      flash[:notice] = "作成できました"
    else
      redirect_back(fallback_location: index_my_trucks_path)
      flash[:notice] = "作成できませんでした"
    end
  end

  private

  def my_truck_params
    params.permit(:my_kanji, :my_up_num, :my_hiragana, :my_btm_left_num, :my_btm_right_num, :my_truck_name).merge(user_id: current_user.id)
  end
end
