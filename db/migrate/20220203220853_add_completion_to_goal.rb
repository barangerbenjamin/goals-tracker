class AddCompletionToGoal < ActiveRecord::Migration[6.1]
  def change
    add_column :goals, :complete, :boolean, default: false
    add_column :goals, :progress, :date, array: true, default: []
    add_column :goals, :actioned, :date, array: true, default: []
  end
end
