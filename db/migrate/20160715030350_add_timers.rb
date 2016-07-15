class AddTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.integer :interval
      t.integer :team_id
      t.timestamps
    end
  end
end
