UserGoal.destroy_all
User.destroy_all
Goal.destroy_all

users = [
  {
    password: '123123',
    email: 'alex@supergoals.com'
  },
  {
    password: '123123',
    email: 'ben@supergoals.com'
  }
]

user_1_goals = [
  {
    name: '20 push ups',
    description: '',
    due_date: Date.today + 2.day
  },
  {
    name: '10k run',
    description: 'marathon prep',
    due_date: Date.today + 10.day
  },
  {
    name: 'One new spanish vocab',
    description: 'Learn 30 new spanish words a month!',
    due_date: Date.today + 30.day
  },
  {
    name: 'Visit New Zealand',
    description: 'I need to see those fluffy Kiwis',
    due_date: Date.today + 180.day
  }
]

user_2_goals = [
  {
    name: 'Read a book',
    description: 'Read more',
    due_date: Date.today + 2.day
  },
]

shared_goals = [
  {
    name: 'Code Troopl project',
    description: 'Create a goal tracking app!',
    due_date: Date.new(2022, 02, 06)
  }
]

user_2_goals.each { |goal| Goal.create(goal) }

users.each.with_index do |user, index|
  user = User.create(user)
  if index.zero?
    goals = user_1_goals.map { |goal| Goal.create(goal) }
  else
    goals = user_2_goals.map { |goal| Goal.create(goal) }
  end
  goals.each { |goal| UserGoal.create(user: user, goal: goal) }
end

shared_goals.each do |shared|
  goal = Goal.create(shared)
  UserGoal.create(user: User.first, goal: goal)
  UserGoal.create(user: User.last, goal: goal)
end

