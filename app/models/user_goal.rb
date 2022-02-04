class UserGoal < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  scope :where_belongs_to, ->(user) { where(user: user) }
end
