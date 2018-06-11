class ZoneCandidate < ApplicationRecord
  belongs_to :candidate, foreign_key: :idCandidate
  belongs_to :zone, foreign_key: :idZone
  belongs_to :round, foreign_key: :idRound
end
