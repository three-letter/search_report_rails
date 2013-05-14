class SearchKeywordStatistics < ActiveRecord::Base
  attr_accessible :domain_id, :search_count, :search_keyword

	belongs_to :domain

	class << self
		
		def exist?(did,keyword)
			!find_by_domain_id_and_search_keyword(did,keyword).blank?
		end

	end

end
