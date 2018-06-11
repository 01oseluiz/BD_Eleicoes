require "application_system_test_case"

class PeopleTest < ApplicationSystemTestCase
  setup do
    @person = people(:one)
  end

  test "visiting the index" do
    visit people_url
    assert_selector "h1", text: "People"
  end

  test "creating a Person" do
    visit people_url
    click_on "New Person"

    fill_in "Idaddress", with: @person.idAddress
    fill_in "Ideducation", with: @person.idEducation
    fill_in "Personbirthdate", with: @person.personBirthDate
    fill_in "Personfirstname", with: @person.personFirstName
    fill_in "Personlastname", with: @person.personLastName
    fill_in "Personsex", with: @person.personSex
    click_on "Create Person"

    assert_text "Person was successfully created"
    click_on "Back"
  end

  test "updating a Person" do
    visit people_url
    click_on "Edit", match: :first

    fill_in "Idaddress", with: @person.idAddress
    fill_in "Ideducation", with: @person.idEducation
    fill_in "Personbirthdate", with: @person.personBirthDate
    fill_in "Personfirstname", with: @person.personFirstName
    fill_in "Personlastname", with: @person.personLastName
    fill_in "Personsex", with: @person.personSex
    click_on "Update Person"

    assert_text "Person was successfully updated"
    click_on "Back"
  end

  test "destroying a Person" do
    visit people_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Person was successfully destroyed"
  end
end
