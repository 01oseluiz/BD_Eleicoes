require "application_system_test_case"

class ZoneCandidatesTest < ApplicationSystemTestCase
  setup do
    @zone_candidate = zone_candidates(:one)
  end

  test "visiting the index" do
    visit zone_candidates_url
    assert_selector "h1", text: "Zone Candidates"
  end

  test "creating a Zone candidate" do
    visit zone_candidates_url
    click_on "New Zone Candidate"

    fill_in "Idcandidate", with: @zone_candidate.idCandidate
    fill_in "Idround", with: @zone_candidate.idRound
    fill_in "Idzone", with: @zone_candidate.idZone
    fill_in "Voteismanual", with: @zone_candidate.voteIsManual
    fill_in "Votetime", with: @zone_candidate.voteTime
    click_on "Create Zone candidate"

    assert_text "Zone candidate was successfully created"
    click_on "Back"
  end

  test "updating a Zone candidate" do
    visit zone_candidates_url
    click_on "Edit", match: :first

    fill_in "Idcandidate", with: @zone_candidate.idCandidate
    fill_in "Idround", with: @zone_candidate.idRound
    fill_in "Idzone", with: @zone_candidate.idZone
    fill_in "Voteismanual", with: @zone_candidate.voteIsManual
    fill_in "Votetime", with: @zone_candidate.voteTime
    click_on "Update Zone candidate"

    assert_text "Zone candidate was successfully updated"
    click_on "Back"
  end

  test "destroying a Zone candidate" do
    visit zone_candidates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Zone candidate was successfully destroyed"
  end
end
