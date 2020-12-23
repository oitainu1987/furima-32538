class UserPurchase
  
  include ActiveModel::Model
  attr_accessor :hoge, :item_id, :user_id, :postal_code, :area_id, :city, :house_number, :building, :tel, :purchase_record_id, :token

  with_options presence: true do
    validates :postal_code,  format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :city
    validates :house_number
    validates :tel,          format: {with: /\A\d{11}\z/}
    validates :token
  end
  
  validates :area_id, numericality: { other_than: 1 }
  
  def save
    purchase_record = PurchaseRecord.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, area_id: area_id, city: city, house_number: house_number, building: building, tel: tel, purchase_record_id: purchase_record.id)
  end
    
end