class SearchLog < ActiveRecord::Base
  attr_accessible :browser_type, :domain_id, :keyword, :search_result_count, :visit_id, :created_at

	belongs_to :domain

	def self.setup(date=(Date.today - 10).to_time)
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
