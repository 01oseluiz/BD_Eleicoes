class Party < ApplicationRecord
  has_many :candidates, foreign_key: :idParty, dependent: :destroy
  belongs_to :person, foreign_key: :idPerson
end
