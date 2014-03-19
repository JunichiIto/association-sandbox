class Post < ActiveRecord::Base
  has_many :comments

  validates :text, presence: true
end
