class ChangeRunningDefaultToFalse < ActiveRecord::Migration
  def change
    change_column :timers, :running, :boolean, default: false
  end
end
