class SearchKeywordStatistics < ActiveRecord::Base
  attr_accessible :domain_id, :search_count, :search_keyword

	belongs_to :domain

	class << self
		
		def find_or_new_by_domain_id_and_search_keyword(did, keyword)
			search_keyword_statistic = find_by_domain_id_and_search_keyword(did,keyword)
			search_keyword_statistic = create({:domain_id => did, :search_keyword => keyword}) if search_keyword_statistic.blank?
			search_keyword_statistic
	  end

	end

end
