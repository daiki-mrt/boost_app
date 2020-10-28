class Message < ApplicationRecord
  belongs_to :user
  belongs_to :space

  validates :text, presence: true
end
