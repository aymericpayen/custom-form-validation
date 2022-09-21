class Questionnaire < ApplicationRecord
  validates :reference, presence: true
  validates :reference, length: {minimum: 2}
  validates :reference, uniqueness: true
  validates :content, presence: true
  validates_with QuestionnaireValidator
end
