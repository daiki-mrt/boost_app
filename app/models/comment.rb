class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :text, presence: true
end
