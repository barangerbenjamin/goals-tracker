class GoalsController < ApplicationController

  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  def index
    @goals = Goal.not_completed(current_user).reject { |goal| Date.today.in? goal.actioned }
    @actioned_goals = Goal.not_completed(current_user).select { |goal| Date.today.in? goal.actioned }
  end

  def show
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)

    if params[:goal][:tag_ids].present? && @goal.save
      GoalTag.create(goal: @goal, tag: Tag.find(params[:goal][:tag_ids]))
      UserGoal.create(user: current_user, goal: @goal)
      redirect_to @goal
    else
      @goal.errors.add(:tag_ids, 'Select a tag') unless params[:goal][:tag_ids].present?
      render :new
    end
  end

  def edit
  end

  def update
    @goal.actioned << Date.today unless params[:no_action] || Date.today.in?(@goal.actioned)
    if @goal.update(goal_params)
      render status: 200
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
    params.require(:goal).permit(:name, :description, :due_date, :complete, :actioned)
  end
end
