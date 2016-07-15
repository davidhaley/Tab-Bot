class AddLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.datetime :notified_at
      t.integer :interval_id
    end
  end
end
