class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_goals
  has_many :goals, through: :user_goals

  def goals_by_category
    Tag.all.map do |tag|
      { tag.name.to_sym => tag.goals.select { |goal| self.id.in? goal.users.pluck(:user_id) } }
    end
  end
end
