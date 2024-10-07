class LinkClick < ApplicationRecord
  # query db for basic analytics
  validates :url, presence: true

  def self.total_clicks
    LinkClick.all.count
  end

  def self.most_clicked
    if LinkClick.count.zero?
      return "No url has been clicked yet"
    end
    most_clicked_url = LinkClick.group(:url).order("COUNT(id) DESC").limit(1).count(:id).first
    most_clicked_url[0]
  end

  def self.active_links
    LinkClick.group(:url).count.keys.size
  end

  def self.top_clicked_links(top_k)
    if LinkClick.count.zero?
      return []
    end
    LinkClick.group(:url).order("COUNT(id) DESC").limit(top_k).count(:id)
  end
end
