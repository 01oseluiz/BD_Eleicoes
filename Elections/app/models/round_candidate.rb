class RoundCandidate < ApplicationRecord
  belongs_to :round, primary_key: :idRound, foreign_key: :idRound
  belongs_to :candidate, primary_key: :idCandidate, foreign_key: :idCandidate
end
