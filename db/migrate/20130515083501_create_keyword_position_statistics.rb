class CreateKeywordPositionStatistics < ActiveRecord::Migration
  def change
    create_table :keyword_position_statistics do |t|
      t.string :search_keyword
      t.integer :position, :default => 0
      t.integer :count, :default => 0
      t.integer :domain_id, :default => 0

      t.timestamps
    end
  end
end
