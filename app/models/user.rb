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

  # <フォローする側の目線>
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  # activeを通して、followerを参照する
  has_many :followings, through: :active_relationships, source: :follower
 
  # <フォローされる側の目線>
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # passiveを通して、followingを参照する
  has_many :followers, through: :passive_relationships, source: :following

  # (userが)フォローしようとしている相手が既にフォロー済みかどうか確認する
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # ゲストユーザー userの検索・作成
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = "tamori"
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
end
