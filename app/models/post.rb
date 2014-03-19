class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  validates :text, presence: true
end
