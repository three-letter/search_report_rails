class CreateResultBrowseLogs < ActiveRecord::Migration
  def change
    create_table :result_browse_logs do |t|
      t.string :visit_id
      t.integer :page
      t.integer :position
      t.integer :page_size
      t.integer :result_position
      t.string :search_keyword
      t.string :browser_type
      t.integer :domain_id

      t.timestamps
    end
  end
end
