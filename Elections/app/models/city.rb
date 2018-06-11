class City < ApplicationRecord
  has_many :candidates, foreign_key: :idCity, dependent: :destroy
  has_many :addresses, foreign_key: :idCity, dependent: :destroy
  belongs_to :state, foreign_key: :idState
end
