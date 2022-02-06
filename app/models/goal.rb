class Goal < ApplicationRecord
  has_many :user_goals, dependent: :destroy
  has_many :users, through: :user_goals
  has_many :goal_tags, dependent: :destroy
  has_many :tags, through: :goal_tags

  scope :not_completed, ->(user) { joins(:user_goals).merge(UserGoal.where_belongs_to(user)).where(complete: false) }

  validates :name, :description, :due_date, presence: true
end
