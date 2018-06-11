class Candidate < ApplicationRecord
  has_many :zone_candidates, foreign_key: :idCandidate, dependent: :destroy
  has_many :round_candidates, primary_key: :idCandidate, foreign_key: :idCandidate, dependent: :destroy
  belongs_to :person, foreign_key: :idPerson
  belongs_to :party, foreign_key: :idParty
  belongs_to :cargo, foreign_key: :idCargo
  belongs_to :city, foreign_key: :idCity

  def nome
    self.person.nome
  end

end
