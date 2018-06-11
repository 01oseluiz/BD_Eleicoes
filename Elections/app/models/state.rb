class State < ApplicationRecord
  has_many :cities, foreign_key: :idState, dependent: :destroy
  has_many :cargo_states, primary_key: :idState, foreign_key: :idState, dependent: :destroy
  belongs_to :region, foreign_key: :idRegion
end
