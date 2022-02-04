class Goal < ApplicationRecord
  has_many :user_goals
  has_many :users, through: :user_goals

  scope :not_completed, ->(user) { Goal.joins(:user_goals).merge(UserGoal.where_belongs_to(user)).where(complete: false) }
end
