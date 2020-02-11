class CreateGraphs < ActiveRecord::Migration[5.2]
  def change
    create_table :graphs do |t|
      t.integer :user_id, null: false
      t.date :date, null: false
      t.float :weight, null: false

      t.timestamps
    end
    add_index :graphs, [:user_id, :date], unique: true
  end
end
