class LinkClick < ApplicationRecord
  # query db for basic analytics
  validates :url, presence: true

  def self.total_clicks
    LinkClick.all.count
  end

  def self.most_clicked
    most_clicked_url = LinkClick.group(:url).order("COUNT(id) DESC").limit(1).count(:id).first
    most_clicked_url[0]
  end

  def self.active_links
    LinkClick.group(:url).count
  end
end
