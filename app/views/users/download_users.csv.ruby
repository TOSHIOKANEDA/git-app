require 'csv'

bom = "\uFEFF"
CSV.generate(bom) do |csv|
  column_names = %w(EMAIL 社名 電話番号 担当者名 運輸局番号)
  csv << column_names
  @users.each do |user|
    column_values = [
      user.email,
      user.company,
      user.phone,
      user.driver,
      user.certificate
      ]
      csv << column_values
  end
end