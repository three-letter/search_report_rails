class SearchLog < ActiveRecord::Base
  attr_accessible :browser_type, :domain_id, :keyword, :search_result_count, :visit_id, :created_at

	belongs_to :domain

	scope :date_log, lambda { |date| where(["created_at between ? and ?", date.beginning_of_day, date.end_of_day ]) }


	class << self
		
		def statistics_search_keyword_by_date(date)
			Domain.all.each do |d|
				keyword_groups = d.search_logs.select("keyword, COUNT(keyword) as keyword_count").date_log(date).group(:keyword)
				keyword_groups.each do |keyword_group|
					search_keyword_statistics = SearchKeywordStatistics.find_or_new_by_domain_id_and_search_keyword(d.id, keyword_group.keyword)
					search_keyword_statistics.search_count = search_keyword_statistics.search_count + keyword_group.keyword_count.to_i
					search_keyword_statistics.save
				end
			end
		end

		def statistics_search_by_date(date)
			Domain.all.each do |d|
				keyword_groups = d.search_logs.date_log(date)
				search_statistics = SearchStatistics.find_or_new_by_domain_id_and_created_at(d.id, date.to_time)
				search_statistics.count = keyword_groups.size
				search_statistics.save
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
				SearchLog.create(params)
			end
		end

	end
	
end
