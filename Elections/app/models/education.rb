class Education < ApplicationRecord
  has_many :people, foreign_key: :idEducation, dependent: :destroy
end
