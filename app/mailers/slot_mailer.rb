class SlotMailer < ApplicationMailer
  def send_when_slot_destroy(slot)
    @orders = Order.where(slot_id: slot)
    @recivers = User.where(phone: "03-5755-8488")
    @emails = []
    @recivers.each do |r|
      @emails << r.email
    end
    mail from: Rails.application.credentials.gmail[:mail_address],
    to: @emails,
    subject: "Reservation lists summery as of #{Time.now}"
  end
end