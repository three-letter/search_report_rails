class ResultBrowseLog < ActiveRecord::Base
  attr_accessible :browser_type, :domain_id, :page, :page_size, :position, :result_position, :search_keyword, :visit_id, :created_at

	belongs_to :domain

	scope :position_logs, lambda { |pos| where(:position => pos) }	
	
	scope :date_logs, lambda { |date| where(["created_at between ? and ?", date.beginning_of_day, date.end_of_day]) }

	class << self
		
		def statistics_position_by_date(date)
			Domain.all.each do |d|
				position_groups = d.result_browse_logs.select("result_position, COUNT(id) as count").group(:result_position)
				position_groups.each do |position_group|
					position_statistics = PositionStatistics.find_or_new_by_domain_id_and_position_and_created_at(d.id, position_group.result_position.to_i, date.beginning_of_day)
					position_statistics.count = position_statistics.count + position_group.count.to_i
					position_statistics.save
				end
			end
		end

		def statistics_keyword_position_by_date(date)
			
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
