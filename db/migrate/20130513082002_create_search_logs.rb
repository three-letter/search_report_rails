class CreateSearchLogs < ActiveRecord::Migration
  def change
    create_table :search_logs do |t|
      t.string :visit_id
      t.string :keyword
      t.integer :search_result_count
      t.string :browser_type
      t.integer :domain_id

      t.timestamps
    end
  end
end
