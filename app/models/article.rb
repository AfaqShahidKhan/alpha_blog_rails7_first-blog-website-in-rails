class Article < ApplicationRecord
validates :title, presence: true, length: {minimum:6, maximum:116}
validates :description, presence: true, length: {minimum:6, maximum:116}


end
