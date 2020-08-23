require 'csv'

CSV.generate(encoding: Encoding::SJIS) do |csv|
  column_names = %w(CNTR_NO RESERVE_DATE RESERVE_BGN_TIME RESERVE_END_TIME TRUCK COMPANY CONTACTOR TEL AI-KOTOBA CLASSIFICATION（1以外は輸出搬入なんで削除）  車番登録アンケート)
  csv << column_names
  @orders.each do |order|
    column_values = [
      order.cntr_number,
      order.date,
      order.ordered_begin_time,
      order.ordered_end_time,
      order.truck_number,
      order.ordered_company,
      order.ordered_name,
      order.ordered_tel,
      order.pass_code,
      order.purpose,
      order.ps_card
      ]
      csv << column_values
  end
end