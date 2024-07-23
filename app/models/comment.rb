class Comment < ApplicationRecord
  belongs_to :post

  validates :post, presence: true
  validates :content, presence: true
end
