require "test_helper"

class LinkClickTest < ActiveSupport::TestCase
  test "invalid link click without url" do
    no_url_link_click = link_clicks(:no_url)
    assert_not no_url_link_click.valid?
  end

  test "#total_clicks should get the total clicks" do
    count = LinkClick.total_clicks
    assert_equal LinkClick.count, count
  end

  test "#most_clicked should get the url and the count of the most clicked url" do
    unique_urls = LinkClick.group(:url)
    counts_of_unique_urls = unique_urls.order("COUNT(id) DESC").limit(1).count(:id)
    assert_equal LinkClick.most_clicked, counts_of_unique_urls.first[0]
  end

  test "#active_links should give us unique number of urls" do
    num_of_all_links = LinkClick.group(:url).count
    assert_equal num_of_all_links, LinkClick.active_links
  end
end
