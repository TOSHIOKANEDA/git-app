class OrderMailer < ApplicationMailer

  def send_when_cancel(order) #メソッドに対して引数を設定
    @order = Order.find(order) #ユーザー情報
    if @order.ordered_email.present?
      @reciver = @order.ordered_email
    else
      @reciver = @order.user.email
    end
    #mailの宛先は、orderにメールアドレスをcolumnを作成した後再度設定。
    mail from: Rails.application.credentials.gmail[:mail_address],
    to: @reciver, subject: '[大井５号]ご予約キャンセルとなった分があります'
  end
end