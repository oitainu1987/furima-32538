class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX
  
  NAME_REGEX = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/
  validates_format_of :first_name, with: NAME_REGEX, presence: true
  validates_format_of :family_name, with: NAME_REGEX, presence: true

  KANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates_format_of :first_name_kana, with: KANA_REGEX, presence: true
  validates_format_of :family_name_kana, with: KANA_REGEX, presence: true

  validates :birth_day, presence: true
  
end
