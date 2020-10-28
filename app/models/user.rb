class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :comments

  has_many :user_spaces
  has_many :spaces, through: :user_spaces
  has_many :messages


  # ゲストユーザー userの検索・作成
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = "tamori"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
