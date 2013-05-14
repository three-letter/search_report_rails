class ResultBrowseLog < ActiveRecord::Base
  attr_accessible :browser_type, :domain_id, :page, :page_size, :position, :result_position, :search_keyword, :visit_id, :created_at

	belongs_to :domain

	def self.setup(date=(Date.today - 10).to_time)
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
