module CommonActions
   extend ActiveSupport::Concern

  def power_finder
    @actives = User.where(power_id: 1).where.not(authority: 1).where.not(authority: nil)
  end

  def authorized_user
    redirect_to controller: :orders, action: :index unless current_user.authority == 1
  end

  def truck_selection
    @kanji = 
        ["川越", "柏", "春日部", "川崎", "熊谷", "群馬", "品川","世田谷",
        "高崎", "多摩", "千葉", "つくば", "土浦", "所沢", "とちぎ",
        "那須", "習志野", "成田", "練馬", "野田",
        "八王子", "福島", "富士山", "水戸", "横浜",
        "会津", "青森", "秋田", "足立", "石川", "伊豆", "和泉", "一宮", "いわき",
        "岩手", "宇都宮", "愛媛", "大分","大阪", "大宮", "岡崎", "岡山",
        "沖縄", "尾張小牧", "香川", "鹿児島", "金沢",
        "北九州", "岐阜", "京都", "熊本", "倉敷", "久留米", 
        "高知", "神戸", "佐賀", "堺", "相模", "佐世保", "札幌",
        "滋賀", "静岡", "島根", "下関", "庄内", "湘南", "鈴鹿",
        "諏訪", "仙台", "袖ヶ浦", "筑豊",
        "徳島", "鳥取", "富山", "豊田", "豊橋",
        "長岡", "長野", "名古屋", "なにわ", "奈良", 
        "新潟", "沼津", "八戸", "浜松", "飛騨",
        "姫路", "広島", "福井", "福岡", "福山", "松本", "三重",
        "三河", "宮城", "宮崎", "山形", "山口", "山梨", 
        "和歌山"]
    @hiragana = ["あ", "い", "う", "え", "お", "か", "き", "く", "け", "こ", "を"]
    
    @left_nums = ["・・","・1", "・2","・3","・4","・5","・6","・7","・8","・9"]
    ("10".."99").each do |n|
    @left_nums << n
    end

    @right_nums = ["・1", "・2","・3","・4","・5","・6","・7","・8","・9"]
    ("00".."99").each do |n|
    @right_nums << n
    end

  end

  def catch_truck_number
    @trucks = Truck.all
    @trucks.each do |truck|
      find_truck = Order.find_by(id: truck.order_id)
      find_truck.truck_number = "#{truck.kanji}#{truck.up_num}#{truck.hiragana}#{truck.btm_left_num}#{truck.btm_right_num}"
      find_truck.save
    end
  end

 
 end