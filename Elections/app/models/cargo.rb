class Cargo < ApplicationRecord
  has_many :candidates, foreign_key: :idCargo, dependent: :destroy
  has_many :cargo_states, primary_key: :idCargo, foreign_key: :idCargo, dependent: :destroy
end
