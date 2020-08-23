class OrdersController < ApplicationController

include CommonActions
before_action :catch_truck_number, only: [:authority]
before_action :authenticate_user!, except: [:search]
before_action :set_params, only: [:done, :confirm]
before_action :find_params, only: [:edit, :display, :update, :destroy]
before_action :authorized_user, only: [:authority, :switch, :list]
before_action :done_params, only: [:done]
before_action :count_order
before_action :power_finder, only: [:index, :authority]


  def search
    if params[:keyword_cntr].present?
      search_cntr
    else
      flash[:notice] = "コンテナ番号と予約番号を入力して検索してください"
    end
  end

  def search_cntr
    cntrs = Order.where(cntr_number: params[:keyword_cntr])
    check_code = Order.find_by(pass_code: params[:keyword_pass_code])
    if cntrs.blank? && check_code.blank?
      flash[:notice] = "コンテナ番号も予約番号(半角数字及び平仮名の組み合わせ)も、両方存在してません"
    elsif check_code.blank? && cntrs.present?
      flash[:notice] = "予約番号(半角数字及び平仮名の組み合わせ)が間違えてます（コンテナ番号は存在してます）"
    elsif cntrs.blank? && check_code.present?
      flash[:notice] = "コンテナ番号が間違えています（予約番号はOKです）"
    else
      cntrs = Order.where(pass_code: params[:keyword_pass_code])
      @cntr = cntrs.find_by(cntr_number: params[:keyword_cntr])
      if @cntr.present?
        @order = Order.find(@cntr.id)
        flash.now[:notice] = "コンテナ番号が見つかりました。青い線の下に記載してある検索結果を確認し、トラック番号訂正もしくはトラック番号新規登録を行ってください"
        @truck = Truck.find_by(order_id: @order.id)
      else
        flash.now[:notice] = "コンテナ番号と予約番号がマッチしませんでした。配車担当者さまにコンテナ番号と予約番号を確認してください"
      end
    end
  end

  def authority
    respond_to do |format|
      @slots = Slot.all
      @orders = Order.all.includes(:user)
      format.html do
        @test_members = User.order(created_at: "DESC").reject{|user| user.authority != 4 }
        @test_members = Kaminari.paginate_array(@test_members).page(params[:page]).per(10)
        @new_members = User.order(created_at: "DESC").reject{|user| user.authority.present? }
        @new_members = Kaminari.paginate_array(@new_members).page(params[:page]).per(10)
        @special_members = User.order(created_at: "DESC").reject{|user| user.authority != 2 }
        @special_members = Kaminari.paginate_array(@special_members).page(params[:page]).per(10)
        @black_members = User.order(created_at: "DESC").reject{|user| user.authority != 9 }
        @black_members = Kaminari.paginate_array(@black_members).page(params[:page]).per(10)
        @dr_members = User.order(created_at: "DESC").reject{|user| user.authority != 3 }
        @dr_members = Kaminari.paginate_array(@dr_members).page(params[:page]).per(10)
      end
      format.csv do
        catch_truck_number
        send_data render_to_string, filename: "reservation.csv", type: :csv
      end

    end
  end




  
  def index
    @power = Power.find(current_user.power_id)
    @order = Order.new
  end

  
  def confirm
    render :action => 'confirm'
  end
  
  def edit
  end

  def display
  end

  def switch
    User.where.not(authority: 1).update_all(power_id: params[:power_id])
    redirect_back(fallback_location: root_path)
  end
  
  def update
    if @order.allowance > 0
    @order.allowance -= 1
    @order.update(cntr_params)
    @order.save
    truck = Truck.find_by(order_id: @order.id)
      if truck.present?
      truck.cntr_number = @order.cntr_number
      truck.save
      flash[:notice] = "変更しました（トラック番号の登録がありました。データを反映させましたんで再度トラックナンバー登録からコンテナ番号と予約番号を呼び出し、”スクリーンショットを忘れた方”をクリックし、プリントアウトかスクショしてください"
      end
    else
    redirect_back(fallback_location: root_path)
    flash[:notice] = "２回変更しているので、これ以上変更不可です"
    end
  end
  
  def destroy
    if current_user.id == @order.user_id || current_user.authority == 1
    full_status_recovery = @order.slot_id
    OrderMailer.send_when_cancel(@order.id).deliver_now
    @order.destroy
    Slot.find_by(id: full_status_recovery).update(full_status: 1)
    redirect_back(fallback_location: root_path)
    flash[:notice] = "削除しました"
    else
    redirect_back(fallback_location: root_path)
    flash[:notice] = "予約した方のみ削除可能です"
    end
  end
  
  def done
    limits = Order.where(slot_id: @order.slot_id, date: @order.date).count
      if params[:back]
      @power = Power.find(current_user.power_id)
      render :action => 'index'
      elsif limits < @order.slot.max_num.to_i
      @order.pass_code = @order.random_string
      @check_same_cntr = @order.cntr_number_check(@order.cntr_number, @order.date)
        if @check_same_cntr.present?
          redirect_to root_path
          flash[:notice] = @check_same_cntr
        else
        @order.save
        render :action => 'done'
        end
      else
      redirect_to root_path
      flash[:notice] = "予約枠を超えています。時間帯を変えて入れなおしてください"
      end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:fu, :pki, :cntr_number, :date, :purpose, :ps_card,
      :slot_id, :booking, :ordered_begin_time, :ordered_end_time, :ordered_company,
      :ordered_name, :ordered_tel, :allowance, :pass_code, :ordered_email)
  end

  def cntr_params
    params.require(:order).permit(:cntr_number)
  end
  
  def set_params
    @order = Order.new(order_params)
  end

  def find_params
    @order = Order.find(params[:id])
  end

  
  def authorized_user
    redirect_to action: :index unless current_user.authority == 1
  end


  def done_params
    @order.user_id = current_user.id
    @order.ordered_begin_time = @order.slot.begin_time
    @order.ordered_end_time = @order.slot.end_time
    @order.ordered_company = @order.user.company
    @order.date = @order.slot.date.to_s.delete('-')
    @order.allowance = 2
    if @order.ordered_tel.blank?
    set_value = @order.user.phone
    else
    set_value = @order.ordered_tel
    end
    @order.ordered_tel = @order.value_ordered_tel(set_value)
    @order.ordered_name = @order.user.driver if @order.ordered_name.blank?
  end




  def count_order
    duplicate_nums = Order.group(:slot_id).having('count(*) >= 1').pluck(:slot_id)
    if duplicate_nums.present?
      duplicate_nums.each do |num|
        order_vol = Order.where(slot_id: num).count
        slot_id = Slot.find_by(id: num)
        if order_vol >= slot_id.max_num.to_i
        slot_id.update(full_status: 2)
        else
        slot_id.update(full_status: 1)
        end
      end
    end
  end

end