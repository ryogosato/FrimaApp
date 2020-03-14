class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :items
  validates :nickname, presence: true
  validates :encrypted_password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :furigana_first, presence: true
  validates :furigana_last, presence: true
  validates :birthdate, presence: true
  devise :validatable, password_length: 6..128
  has_many :favorites
  has_many :fav_items, through: :favorites, source: :item
end

