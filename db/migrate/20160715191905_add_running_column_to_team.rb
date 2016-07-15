class AddRunningColumnToTeam < ActiveRecord::Migration
  def change
    add_column :timers, :running, :boolean, default: true
  end
end
