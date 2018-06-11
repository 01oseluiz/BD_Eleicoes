class Region < ApplicationRecord
  has_many :states, foreign_key: :idRegion, dependent: :destroy
end
