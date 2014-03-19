class Comment < ActiveRecord::Base
  belongs_to :post

  validates :text, presence: true
  validates :post, presence: true
end
