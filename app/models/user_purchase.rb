class UserPurchase
  
  include ActiveModel::Model
  attr_accessor :hoge, :item_id, :user_id, :postal_code, :area_id, :city, :house_number, :building, :tel, :purchase_record_idq

  with_options presence: true do
    validates :postal_code,  format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city,         format: {with:/\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: "この項目は必須です"}
    validates :house_number
    validates :tel,          format: {with: /\A\d{11}\z/, message: "半角数字ハイフン無しです"}
  end

  def save
    purchase_record = PurchaseRecord.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, area_id: area_id, city: city, house_number: house_number, building: building, tel: tel, purchase_record_id: purchase_record.id)
  end
    
end