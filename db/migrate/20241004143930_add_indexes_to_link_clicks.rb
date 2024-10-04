class AddIndexesToLinkClicks < ActiveRecord::Migration[8.0]
  def change
    add_index :link_clicks, :url
    add_index :link_clicks, :created_at
  end
end
