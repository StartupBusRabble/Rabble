class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  has_many :questionnaires
  has_many :compatibility_scores, class_name: 'CompatibilityScore'
  belongs_to :group, optional: true

end
