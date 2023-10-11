class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 6, maximum: 255 }
  validates :description, presence: true, length: { minimum: 6, maximum: 255 }
end
