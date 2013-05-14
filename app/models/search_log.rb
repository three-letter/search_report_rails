class SearchLog < ActiveRecord::Base
  attr_accessible :browser_type, :domain_id, :keyword, :search_result_count, :visit_id, :created_at

	belongs_to :domain

	scope :domain_log, lambda { |d| where(:domain_id => d) }

	scope :date_log, lambda { |date| where(["created_at between ? and ?", date.beginning_of_day, date.end_of_day ]) }


	class << self
		
		def statistics_search_keyword_by_date date
			Domain.all.each do |d|
				keyword_group = SearchLog.select("keyword, COUNT(keyword) as keyword_count").domain_log(d.id).date_log(date).group(:keyword)
				keyword_group.each do |kg|
					search_keyword_statistics = SearchKeywordStatistics.new({:domain_id => d.id, :search_keyword => kg.keyword })
					search_keyword_statistics = SearchKeywordStatistics.find_by_domain_id_and_search_keyword(d.id, k) if SearchKeywordStatistics.exist?(d.id, kg.keyword)
					search_keyword_statistics.search_count = search_keyword_statistics.search_count + kg.keyword_count
					search_keyword_statistics.save
				end
			end
		end

		def setup(date=(Date.today - 10).to_time)
			50.times do 
				params = {
					:visit_id	=> "visit_#{rand(5)}",
					:keyword  => ["google","baidu","qq","microsoft"].shuffle[0],
					:search_result_count => rand(5..40),
					:browser_type => ["IE","Firefox","Chrome","Safari"].shuffle[0],
					:domain_id => Domain.all.map { |d| d.id }.shuffle[0],
					:created_at => date
				}
				binding.pry
				SearchLog.create(params)
			end
		end

	end
	
end
