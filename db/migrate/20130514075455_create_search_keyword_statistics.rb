class CreateSearchKeywordStatistics < ActiveRecord::Migration
  def change
    create_table :search_keyword_statistics do |t|
      t.string :search_keyword
      t.integer :search_count
      t.integer :domain_id

      t.timestamps
    end
  end
end
