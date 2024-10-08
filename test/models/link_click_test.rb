require "test_helper"

class LinkClickTest < ActiveSupport::TestCase
  test "is invalid without a url" do
    no_url_link_click = link_clicks(:no_url)
    assert_not no_url_link_click.valid?
  end

  test "returns total clicks for all records" do
    count = LinkClick.total_clicks
    assert_equal LinkClick.count, count
  end

  test "returns the most clicked url" do
    unique_urls = LinkClick.group(:url)
    counts_of_unique_urls = unique_urls.order("COUNT(id) DESC").limit(1).count(:id)
    assert_equal LinkClick.most_clicked, counts_of_unique_urls.first[0]
  end

  test "returns the total number of unique links" do
    num_of_all_links = LinkClick.group(:url).count.keys.size
    assert_equal num_of_all_links, LinkClick.active_links
  end

  test "returns the top k most clicked links" do
    k = 5
    unique_urls = LinkClick.group(:url)
    counts_of_unique_urls = unique_urls.order("COUNT(id) DESC").limit(k).count(:id)
    assert_equal counts_of_unique_urls, LinkClick.top_clicked_links(5)
  end

  test "returns valid values for views when there are no records in the database" do
    LinkClick.destroy_all
    total_click = LinkClick.total_clicks
    assert_equal total_click, 0

    most_clicked_url = LinkClick.most_clicked
    assert_equal most_clicked_url, "No url has been clicked yet"

    top_5_clicked_links = LinkClick.top_clicked_links(5)
    assert_equal top_5_clicked_links, []
  end
end
