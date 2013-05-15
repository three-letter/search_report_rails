class ResultBrowseLog < ActiveRecord::Base
  attr_accessible :browser_type, :domain_id, :page, :page_size, :position, :result_position, :search_keyword, :visit_id, :created_at

	belongs_to :domain

	scope :position_logs, lambda { |pos| where(:position => pos) }	
	
	scope :date_logs, lambda { |date| where(["created_at between ? and ?", date.beginning_of_day, date.end_of_day]) }

	class << self
		
		def statistics_position_by_date(date)
			Domain.all.each do |d|
				position_groups = d.result_browse_logs.date_logs(date).select("result_position, COUNT(id) as count").group(:result_position)
				position_groups.each do |position_group|
					pos = position_group.result_position.to_i > 20 ? 21 : position_group.result_position.to_i
					position_statistics = PositionStatistics.find_or_new_by_domain_id_and_position_and_created_at(d.id, pos, date.beginning_of_day)
					position_statistics.count = position_statistics.count + position_group.count.to_i
					position_statistics.save
				end
			end
		end

		def statistics_keyword_position_by_date(date)
			Domain.all.each do |d|
				keyword_groups = d.result_browse_logs.date_logs(date).select("search_keyword, COUNT(id) as count").group(:search_keyword)
				keyword_groups.each do |keyword_group|
					1.upto(20) do |pos|
						keyword_positions = d.result_browse_logs.date_logs(date).where(:search_keyword => keyword_group.search_keyword, :result_position => pos)
						keyword_position_statistics = KeywordPositionStatistics.find_or_new_by_domain_id_and_keyword_and_position_and_date(d.id, keyword_group.search_keyword, pos, date.to_time)
						keyword_position_statistics.count = keyword_position_statistics.count + keyword_positions.size
						keyword_position_statistics.save
					end
					keyword_positions = d.result_browse_logs.date_logs(date).where(["search_keyword = ? and result_position > 20", keyword_group.search_keyword])
					keyword_position_statistics = KeywordPositionStatistics.find_or_new_by_domain_id_and_keyword_and_position_and_date(d.id, keyword_group.search_keyword, 21, date.to_time)
					keyword_position_statistics.count = keyword_position_statistics.count + keyword_positions.size
					keyword_position_statistics.save
				end
			end
		end
		
		def setup(date=(Date.today - 10).to_time)
			50.times do 
				params = {
					:visit_id	=> "visit_#{rand(5)}",
					:page => rand(1..3),
					:position => rand(1..10),
					:page_size => rand(5..10),
					:search_keyword  => ["google","baidu","qq","microsoft"].shuffle[0],
					:browser_type => ["IE","Firefox","Chrome","Safari"].shuffle[0],
					:domain_id => Domain.all.map { |d| d.id }.shuffle[0],
					:created_at => date
				}
				params[:result_position] = (params[:page] - 1) * params[:page_size] + params[:position]
				ResultBrowseLog.create(params)
			end

		end
	end

end
