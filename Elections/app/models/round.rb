class Round < ApplicationRecord
  has_many :zone_candidates, foreign_key: :idRound, dependent: :destroy
  has_many :round_candidates, primary_key: :idRound, foreign_key: :idRound, dependent: :destroy
  has_many :round_electors, primary_key: :idRound, foreign_key: :idRound, dependent: :destroy
end
