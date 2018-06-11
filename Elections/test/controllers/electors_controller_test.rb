require 'test_helper'

class ElectorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @elector = electors(:one)
  end

  test "should get index" do
    get electors_url
    assert_response :success
  end

  test "should get new" do
    get new_elector_url
    assert_response :success
  end

  test "should create elector" do
    assert_difference('Elector.count') do
      post electors_url, params: { elector: { idPerson: @elector.idPerson, idZone: @elector.idZone, issueDate: @elector.issueDate } }
    end

    assert_redirected_to elector_url(Elector.last)
  end

  test "should show elector" do
    get elector_url(@elector)
    assert_response :success
  end

  test "should get edit" do
    get edit_elector_url(@elector)
    assert_response :success
  end

  test "should update elector" do
    patch elector_url(@elector), params: { elector: { idPerson: @elector.idPerson, idZone: @elector.idZone, issueDate: @elector.issueDate } }
    assert_redirected_to elector_url(@elector)
  end

  test "should destroy elector" do
    assert_difference('Elector.count', -1) do
      delete elector_url(@elector)
    end

    assert_redirected_to electors_url
  end
end
