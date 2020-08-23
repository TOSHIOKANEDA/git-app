class SlotsController < ApplicationController
  include CommonActions
  before_action :catch_truck_number, only: [:destroy]
  before_action :set_params, only: [:edit, :show, :update, :destroy]
  before_action :power_finder
  
  def edit
  end

  def show
    given = Order.where(slot_id: params[:id])
    if given.present?
      @orders = given
    else
      flash[:notice] = "予約入ってません"
      redirect_to orders_authority_path
    end
  end
  
  def update
    @slot.update(slot_params)
    redirect_to orders_authority_path
  end

  def new
  end

  def destroy
    SlotMailer.send_when_slot_destroy(@slot.id).deliver_now
    @slot.destroy
    redirect_back(fallback_location: root_path)
  end

  def create
    @slot = Slot.new(slot_params)
    if @slot.date > Date.today && @slot.max_num.present? && @slot.begin_time != @slot.end_time
    @slot.save
    redirect_to orders_authority_path   
    else
    flash[:notice] = "過去の日付は指定できません" if @slot.date < Date.yesterday
    flash[:notice] = "上限台数を設定してください" if @slot.max_num.blank?
    flash[:notice] = "開始と終了時間は別に指定してください" if @slot.begin_time == @slot.end_time
    redirect_to orders_authority_path   
    end
  end

  private
  
  def slot_params
    params.permit(:begin_time, :end_time, :max_num, :slot_size,
      :date, :vip, :slot_status, :full_status, :slot_purpose)
  end

  def set_params
    @slot = Slot.find(params[:id])
  end
  
end
