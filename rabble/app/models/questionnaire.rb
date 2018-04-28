class Questionnaire < ApplicationRecord
  belongs_to :users
  has_many :questions
end
