class Slot < ApplicationRecord
    has_many :orders, dependent: :destroy

    enum slot_purpose: {
    "大井５号予約搬出":1, "城南島新大井バンプール空バン返却":2, "城南島新大井バンプール空バンPICK":3
    }

    enum slot_size: {"指定なし":1, "20GP":2, "40HQ":3, "40GP":4}

end
