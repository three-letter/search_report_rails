class CreateResultBrowseLogs < ActiveRecord::Migration
  def change
    create_table :result_browse_logs do |t|
      t.string :visit_id
      t.integer :page, :default => 0
      t.integer :position, :default => 0
      t.integer :page_size, :default =>0
      t.integer :result_position, :default => 0
      t.string :search_keyword
      t.string :browser_type
      t.integer :domain_id, :default => 0

      t.timestamps
    end
  end
end
