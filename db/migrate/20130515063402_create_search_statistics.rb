class CreateSearchStatistics < ActiveRecord::Migration
  def change
    create_table :search_statistics do |t|
      t.integer :count, :default => 0
      t.integer :domain_id, :default => 0

      t.timestamps
    end
  end
end
