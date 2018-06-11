json.extract! person, :id, :personFirstName, :personLastName, :personBirthDate, :personSex, :idAddress, :idEducation, :created_at, :updated_at
json.url person_url(person, format: :json)
