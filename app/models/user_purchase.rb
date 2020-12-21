class UserPurchase
  
  include ActiveModel::Model
  attr_accessor :postal_code, :prefectures, :city, :house_number, :building, :tel, :token

  with_options presence: true do
    validates :postal_code,  format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city,         format: {with:/\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/}
    validates :house_number
    validates :tel,          format: {with: /\A\d{11}\z/}
  end

    
end