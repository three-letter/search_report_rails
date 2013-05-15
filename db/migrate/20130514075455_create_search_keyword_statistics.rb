class CreateSearchKeywordStatistics < ActiveRecord::Migration
  def change
    create_table :search_keyword_statistics do |t|
      t.string :search_keyword
      t.integer :search_count, :default => 0
      t.integer :domain_id, :default => 0

    end
  end
end
