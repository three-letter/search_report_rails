class SearchKeywordStatistics < ActiveRecord::Base
  attr_accessible :domain_id, :search_count, :search_keyword

	belongs_to :domain


	def self.statistics_log_by_date date
			
	end

end
