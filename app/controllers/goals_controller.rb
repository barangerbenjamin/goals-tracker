class GoalsController < ApplicationController

  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  def index
    @goals = current_user.goals
  end

  def show
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.create(goal_params)
    UserGoal.create(user: current_user, goal: @goal)

    if @goal.save
      redirect_to @goal
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal
    else
      render :edit
    end
  end

  def destroy
    @goal.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:name, :description, :due_date)
  end
end
