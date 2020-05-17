class Podcast < ApplicationRecord
  validates :url, presence: true
end
