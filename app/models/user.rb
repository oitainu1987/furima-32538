class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: { case_sensitive: false }

    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }

    with_options format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ } do
      validates :first_name
      validates :family_name
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
      validates :first_name_kana
      validates :family_name_kana
    end
    validates :birth_day
  end

  has_many :items
end
