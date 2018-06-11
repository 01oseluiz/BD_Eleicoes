class CargoState < ApplicationRecord
  belongs_to :cargo, primary_key: :idCargo, foreign_key: :idCargo
  belongs_to :state, primary_key: :idState, foreign_key: :idState
end
