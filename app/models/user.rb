class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z{6,}/i.freeze
  validates :password, presence: true, format: {with: PASSWORD_REGEX, 
    message: "Include both letters and numbers"}
  validates :nickname, presence: true
  validates :first_name, :last_name, presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/, 
    message: "Full-width characters"}
  validates :first_reading_name, :last_reading_name, presence: true, format: {with: /\A[ァ-ヶー－]+\z/,
    message: "Full-width katakana characters"}
  validates :birth_date, presence: true

  has_many :items
  has_many :purchases
end
