class KeywordPositionStatistics < ActiveRecord::Base
  attr_accessible :count, :domain_id, :position, :search_keyword, :created_at

	def self.find_or_new_by_domain_id_and_keyword_and_position_and_date(did, keyword, pos, date)
		keyword_position_statistics = find_by_domain_id_and_search_keyword_and_position_and_created_at(did, keyword, pos, date)
		keyword_position_statistics = create({:domain_id => did, :search_keyword => keyword, :position => pos, :created_at => date}) if keyword_position_statistics.blank?
		keyword_position_statistics
	end

end
