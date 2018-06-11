require "application_system_test_case"

class ElectorsTest < ApplicationSystemTestCase
  setup do
    @elector = electors(:one)
  end

  test "visiting the index" do
    visit electors_url
    assert_selector "h1", text: "Electors"
  end

  test "creating a Elector" do
    visit electors_url
    click_on "New Elector"

    fill_in "Idperson", with: @elector.idPerson
    fill_in "Idzone", with: @elector.idZone
    fill_in "Issuedate", with: @elector.issueDate
    click_on "Create Elector"

    assert_text "Elector was successfully created"
    click_on "Back"
  end

  test "updating a Elector" do
    visit electors_url
    click_on "Edit", match: :first

    fill_in "Idperson", with: @elector.idPerson
    fill_in "Idzone", with: @elector.idZone
    fill_in "Issuedate", with: @elector.issueDate
    click_on "Update Elector"

    assert_text "Elector was successfully updated"
    click_on "Back"
  end

  test "destroying a Elector" do
    visit electors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Elector was successfully destroyed"
  end
end
