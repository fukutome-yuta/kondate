require 'test_helper'

class ShoppingListsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shopping_lists_show_url
    assert_response :success
  end

end
