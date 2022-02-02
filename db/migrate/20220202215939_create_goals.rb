class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.string :name
      t.text :description
      t.date :due_date

      t.timestamps
    end
  end
end
