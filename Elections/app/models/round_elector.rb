class RoundElector < ApplicationRecord
  belongs_to :round, primary_key: :idRound, foreign_key: :idRound
  belongs_to :elector, primary_key: :idElector, foreign_key: :idElector
end
