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
    description: 'strong body strong mind',
    due_date: Date.today + 2.day,
    tag: 'Sport'
  },
  {
    name: '10k run',
    description: 'marathon prep',
    due_date: Date.today + 10.day,
    tag: 'Sport'
  },
  {
    name: 'One new spanish vocab',
    description: 'Learn 30 new spanish words a month!',
    due_date: Date.today + 30.day,
    tag: 'Personal'
  },
  {
    name: 'Visit New Zealand',
    description: 'I need to see those fluffy Kiwis',
    due_date: Date.today + 180.day,
    tag: 'Travel'
  }
]

user_2_goals = [
  {
    name: 'Read a book',
    description: 'Read more',
    due_date: Date.today + 2.day,
    tag: 'Personal'
  },
]

shared_goals = [
  {
    name: 'Code Troopl project',
    description: 'Create a goal tracking app!',
    due_date: Date.new(2022, 02, 06),
    tag: 'Work'
  }
]

tags = [
  {
    name: 'Sport',
    color: '#00BBF9',
    url: 'https://share-cdn-prod.azureedge.net/wp-content/uploads/2016/06/Running-injuries.-6.1.16-740x493.jpg'
  },
  {
    name: 'Work',
    color: '#F1D302',
    url: 'https://api.time.com/wp-content/uploads/2021/02/laptop-home-office.jpg'
  },
  {
    name: 'Travel',
    color: '#FF7F11',
    url: 'https://www.barcelo.com/pinandtravel/wp-content/uploads/2020/12/travel-destinations-2021_places-to-go-on-vacation.jpg'
  },
  {
    name: 'Personal',
    color: '#EB4B98',
    url: 'https://www.helpguide.org/wp-content/uploads/woman-at-edge-of-dock-lotus-position.jpg'
    # url: 'https://assets.keap.com/image/upload/b_rgb:FFFFFF,c_limit,dpr_1,f_auto,h_395,q_95,w_569/v1539262503/How%20and%20Why%20to%20Encourage%20Personal%20Growth%20Within%20Your%20Business/GettyImages-477397372.jpg'
  }
]

# user_2_goals.each { |goal| Goal.create(goal) }

tags.each { |tag| Tag.create(tag) }

users.each.with_index do |user, index|
  user = User.create(user)
  if index.zero?
    goals = user_1_goals.map do |goal|
      new_tag = Tag.find_by_name(goal[:tag])
      goal.delete(:tag)
      new_goal = Goal.create(goal)
      GoalTag.create(goal: new_goal, tag: new_tag)
      new_goal
    end
  else
    goals = user_2_goals.map do |goal|
      new_tag = Tag.find_by_name(goal[:tag])
      goal.delete(:tag)
      new_goal = Goal.create(goal)
      GoalTag.create(goal: new_goal, tag: new_tag)
      new_goal
    end
  end
  goals.each do |goal|
    UserGoal.create(user: user, goal: goal)
  end
end

shared_goals.each do |shared|
  new_tag = Tag.find_by_name(shared[:tag])
  shared.delete(:tag)
  goal = Goal.create(shared)
  UserGoal.create(user: User.first, goal: goal)
  UserGoal.create(user: User.last, goal: goal)
  GoalTag.create(goal: goal, tag: new_tag)
end
