class CreatePositionStatistics < ActiveRecord::Migration
  def change
    create_table :position_statistics do |t|
      t.integer :position, :default => 0
      t.integer :count, :default => 0
      t.integer :domain_id, :default => 0

      t.timestamps
    end
  end
end
