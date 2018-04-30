class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  has_many :questionnaires
  has_many :compatibility_scores, class_name: 'CompatibilityScore'
  belongs_to :group, optional: true

  def get_single_answer(question_name)
    question = self.questionnaires.first.questions.find_by(name: question_name)
    return question.answers.first.text
  end

  def get_all_answers(question_name)
    question = self.questionnaires.first.questions.find_by(name: question_name)
    return question.answers
  end
end
