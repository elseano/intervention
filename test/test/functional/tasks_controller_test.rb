require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  test "renders ok for new" do
    get "new"
    assert_response :ok
  end

  test "renders ok for edit" do
    get "edit", :id => Task.make
    assert_response :ok
  end


end
