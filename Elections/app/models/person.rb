class Person < ApplicationRecord
  has_many :candidates, foreign_key: :idPerson, dependent: :destroy
  has_many :electors, foreign_key: :idPerson, dependent: :destroy
  has_many :parties, foreign_key: :idPerson, dependent: :destroy
  belongs_to :address, foreign_key: :idAddress
  belongs_to :education, foreign_key: :idEducation

  def nome
    "#{self.personFirstName} #{self.personLastName}"
  end
end
