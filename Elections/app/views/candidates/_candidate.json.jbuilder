json.extract! candidate, :id, :idPerson, :idParty, :idCargo, :idCity, :candidatePhoto, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)
