class Zone < ApplicationRecord
  self.primary_key = 'idZone'

  has_many :zone_candidates, foreign_key: :idZone, dependent: :destroy
  has_many :electors, foreign_key: :idZone, dependent: :destroy
  belongs_to :address, primary_key: :idAddress, foreign_key: :idAddress

  def nome
    "#{self.numZone} - #{self.address.addressName}"
  end
end