class Questionnaire < ApplicationRecord
  has_many :users
  has_many :questions
end
