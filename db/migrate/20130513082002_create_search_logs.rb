class CreateSearchLogs < ActiveRecord::Migration
  def change
    create_table :search_logs do |t|
      t.string :visit_id
      t.string :keyword
      t.integer :search_result_count, :default => 0
      t.string :browser_type
      t.integer :domain_id, :default => 0

      t.timestamps
    end
  end
end
