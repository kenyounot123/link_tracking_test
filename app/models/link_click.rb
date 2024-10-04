class LinkClick < ApplicationRecord
  # query db for basic analytics
  validates :url, presence: true
end
