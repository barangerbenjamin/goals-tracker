module ApplicationHelper
  require 'humanize'

  def number_to_human_readable(index)
    (index + 1).humanize
  end

  def goal_progress(goal)
    return 0 if goal.progress.count.zero?

    if total_days(goal).zero?
      1
    else
      goal.progress.count / total_days(goal).to_f
    end
  end

  def total_days(goal)
    (goal.due_date.to_date - goal.created_at.to_date).to_i
  end
end
