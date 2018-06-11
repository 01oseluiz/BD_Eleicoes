require 'test_helper'

class ZoneCandidatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @zone_candidate = zone_candidates(:one)
  end

  test "should get index" do
    get zone_candidates_url
    assert_response :success
  end

  test "should get new" do
    get new_zone_candidate_url
    assert_response :success
  end

  test "should create zone_candidate" do
    assert_difference('ZoneCandidate.count') do
      post zone_candidates_url, params: { zone_candidate: { idCandidate: @zone_candidate.idCandidate, idRound: @zone_candidate.idRound, idZone: @zone_candidate.idZone, voteIsManual: @zone_candidate.voteIsManual, voteTime: @zone_candidate.voteTime } }
    end

    assert_redirected_to zone_candidate_url(ZoneCandidate.last)
  end

  test "should show zone_candidate" do
    get zone_candidate_url(@zone_candidate)
    assert_response :success
  end

  test "should get edit" do
    get edit_zone_candidate_url(@zone_candidate)
    assert_response :success
  end

  test "should update zone_candidate" do
    patch zone_candidate_url(@zone_candidate), params: { zone_candidate: { idCandidate: @zone_candidate.idCandidate, idRound: @zone_candidate.idRound, idZone: @zone_candidate.idZone, voteIsManual: @zone_candidate.voteIsManual, voteTime: @zone_candidate.voteTime } }
    assert_redirected_to zone_candidate_url(@zone_candidate)
  end

  test "should destroy zone_candidate" do
    assert_difference('ZoneCandidate.count', -1) do
      delete zone_candidate_url(@zone_candidate)
    end

    assert_redirected_to zone_candidates_url
  end
end
