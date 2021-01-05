class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z{6,}/i.freeze

  with_options presence: true do
    validates :password, format: { with: PASSWORD_REGEX, message: 'Include both letters and numbers' }
    validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'Full-width characters' }
    validates :first_reading_name, :last_reading_name, format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters' }
    validates :nickname, :birth_date
  end

  has_many :items
  has_many :purchases
end
