class Elector < ApplicationRecord
  has_many :round_electors, primary_key: :idElector, foreign_key: :idElector, dependent: :destroy
  belongs_to :person, foreign_key: :idPerson
  belongs_to :zone, foreign_key: :idZone
end
