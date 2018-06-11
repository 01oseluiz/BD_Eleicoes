class Address < ApplicationRecord
  has_many :people, foreign_key: :idAddress, dependent: :destroy
  has_many :zones, primary_key: :idAddress, foreign_key: :idAddress, dependent: :destroy
  belongs_to :city, foreign_key: :idCity
end
