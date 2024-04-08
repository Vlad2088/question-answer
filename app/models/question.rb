class Question < ApplicationRecord
  belongs_to :user

  has_many :answer, dependent: :destroy
  
  validates :title, :body, presence: true
end
