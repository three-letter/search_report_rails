class KeywordPositionStatistics < ActiveRecord::Base
  attr_accessible :count, :domain_id, :position, :search_keyword, :created_at

	def self.find_or_new_by_domain_id_and_keyword_and_position_and_date(did, keyword, pos, date)
		
	end

end
