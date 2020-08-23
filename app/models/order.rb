class Order < ApplicationRecord
  has_one :truck, dependent: :destroy
  belongs_to :power, optional: true
  belongs_to :user
  belongs_to :slot, optional: true

  validates :user_id, uniqueness: false
  validates :cntr_number, presence: true,
            format: { with:  /\A^[A-Z]{3}[UJZ]{1}[0-9]{7}$\z/, message: "は「ABCD1234567」のように記入し、前半４文字を半角英字で後半７文字
            を半角数字を入れてください。(記入例：TGCU0000000)" }

  validates :fu,
  acceptance: { message: '搬出要件を満たしている分のみ、予約を受け付けております。ご確認いただきましてから、予約してください。' }

  validates :pki, 
  acceptance: { message: '一括搬入が出ていない分は、本船遅延の可能性を考慮しまして、予約を受け付けておりません。より多くの方に予約頂くためですので、何卒ご了承ください。' }

  validates :ordered_email, allow_blank: true,
  format: { with:  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "は「your-email@email.com」のように記入してください(記入例：abcdefg@email.com)" }
   
  def value_ordered_tel(value)
    value.tr('０-９', '0-9')
  end


  def random_string(length = 5)
    a = ('1'..'9').to_a + "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわん".split(//)
    random_string = Array.new(length){a[rand(a.size)]}.join
  end

  def cntr_number_check(cntr,d)
    check_same_cntrs = Order.where(cntr_number: cntr).where(date: d)
    if check_same_cntrs.present?
      @cntr_number_check = "同一日内で、同じコンテナの予約はできません。"
    end
  end


end