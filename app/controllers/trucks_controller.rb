class TrucksController < ApplicationController
  include CommonActions
  before_action :power_finder, only: [:index]
  before_action :truck_authorized_user, only: [:index, :destroy]
  before_action :find_order_params, only: [:new, :update, :create, :change, :my_truck_update, :my_truck_create]
  before_action :find_truck_params, only: [:update, :change, :my_truck_update, :my_truck_create]
  before_action :truck_selection, only: [:edit, :new, :change]
  before_action :authenticate_user!, only: [:my_truck_update, :my_truck_create]
  


  def new
    @truck = Truck.new
    flash.now[:notice] = "この画面は、新規トラックナンバー登録画面です。訂正画面ではありません。"
    if current_user
      @my_trucks = MyTruck.where(user_id: current_user.id)
    end
  end

  def edit
  end

  def destroy
    @truck = Truck.find_by(id: params[:id])
    @truck.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = "削除しました。"
  end

  def index
    @trucks = Truck.all
  end

  def show
    @truck = Truck.find_by(id: params[:id])
    @order = Order.find_by(cntr_number: @truck.cntr_number)
  end

  def change
    if current_user
      @my_trucks = MyTruck.where(user_id: current_user.id)
    end

    if @truck.present?
      if @truck.allowance == 0
        redirect_to orders_search_path
        flash[:alert] = "この予約は、１度トラックナンバーを訂正しているので、これ以上訂正はできません"
      else
      render :action => 'edit'
      flash[:notice] = "これ以上変更不可ですので、お間違いのないよう選択してください"
      end
    else
      redirect_to orders_search_path
      flash[:alert] = "まだトラックナンバーの登録がありません。再度トラックナンバー登録をクリックし、コンテナ番号を検索してください。"
    end
  end

  def update
    if @truck.allowance > 0
      @truck.allowance -= 1
      @truck.update(original_truck_params)
      @truck.save
      flash[:notice] = "訂正完了!この画面をスクリーンショットするか、プリントアウトして守衛さんへ見せてください"
    else  
      flash[:notice] = "1度変更しているので、これ以上変更不可です"
    end
  end

  def my_truck_update
    @registered_truck = MyTruck.find(params[:my_truck_id])
    if @truck.allowance > 0
    @truck.allowance -= 1
    @truck.update(
      kanji: @registered_truck.my_kanji, 
      up_num: @registered_truck.my_up_num, 
      hiragana: @registered_truck.my_hiragana, 
      btm_left_num: @registered_truck.my_btm_left_num, 
      btm_right_num: @registered_truck.my_btm_right_num
    )
    @truck.save
    render 'trucks/my_truck_update'
    flash[:notice] = "訂正完了!この画面をスクリーンショットするか、プリントアウトして守衛さんへ見せてください"
    else
    flash[:notice] = "1度変更しているので、これ以上変更不可です"
    end
  end

  def create
    @truck = Truck.new(truck_params)
    if @truck.save
      flash[:notice] = "登録完了!この画面をスクリーンショットするか、プリントアウトして守衛さんへ見せてください"
    else
      redirect_to orders_search_path
      flash[:alert] = "登録をしようとした予約は、すでにトラックナンバーの登録がなされています。訂正をしたい場合は、赤いボタンの”トラック番号訂正”をクリックしてください"
    end
  end

  def my_truck_create
    @registered_truck = MyTruck.find_by(id: params[:my_truck_id])
    @truck = Truck.new(
      kanji: @registered_truck.my_kanji, 
      up_num: @registered_truck.my_up_num, 
      hiragana: @registered_truck.my_hiragana, 
      btm_left_num: @registered_truck.my_btm_left_num, 
      btm_right_num: @registered_truck.my_btm_right_num,
      cntr_number: @order.cntr_number, 
      date: @order.date, 
      ordered_begin_time: @order.ordered_begin_time,
      ordered_end_time: @order.ordered_end_time,
      order_id: @order.id)
    if @truck.save
      render 'trucks/create'
      flash[:notice] = "登録完了!この画面をスクリーンショットするか、プリントアウトして守衛さんへ見せてください"
    else
      redirect_to orders_search_path
      flash[:alert] = "登録失敗しました"
    end

  end

  private
  
  def truck_params
    params.require(:truck).permit(:kanji, :up_num, :hiragana, :btm_left_num, :btm_right_num)
      .merge(cntr_number: @order.cntr_number, date: @order.date, ordered_begin_time: @order.ordered_begin_time, ordered_end_time: @order.ordered_end_time, order_id: @order.id)
  end

  def my_truck_params
    params.permit(:id)
  end



  def original_truck_params
    params.permit(:kanji, :up_num, :hiragana, :btm_left_num, :btm_right_num)
  end

  def find_order_params
    @order = Order.find(params[:id])
  end

  def find_truck_params
    @truck = Truck.find_by(order_id: params[:id])
  end

  def truck_authorized_user
    if user_signed_in?
      unless current_user.authority == 1
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

end
