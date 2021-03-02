require "test_helper"

class ShortLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @short_link = short_links(:one)
  end

  test "should get index" do
    get short_links_url
    assert_response :success
  end

  test "should get new" do
    get new_short_link_url
    assert_response :success
  end

  test "should create short_link" do
    assert_difference('ShortLink.count') do
      post short_links_url, params: { short_link: { original_url: @short_link.original_url, slug: @short_link.slug, timestamps: @short_link.timestamps } }
    end

    assert_redirected_to short_link_url(ShortLink.last)
  end

  test "should show short_link" do
    get short_link_url(@short_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_short_link_url(@short_link)
    assert_response :success
  end

  test "should update short_link" do
    patch short_link_url(@short_link), params: { short_link: { original_url: @short_link.original_url, slug: @short_link.slug, timestamps: @short_link.timestamps } }
    assert_redirected_to short_link_url(@short_link)
  end

  test "should destroy short_link" do
    assert_difference('ShortLink.count', -1) do
      delete short_link_url(@short_link)
    end

    assert_redirected_to short_links_url
  end
end
