class Domain < ActiveRecord::Base
  attr_accessible :name

	has_many :search_logs
	has_many :result_browse_logs
	
	has_many :search_statisticss
	has_many :search_keyword_statisticss
	has_many :position_statisticss
	has_many :keyword_position_statisticss

	def self.find_or_new_by_name(domain_name)
		domain = find_by_name(domain_name)
		domain = create({:name => domain_name}) if domain.blank?
		domain
	end

end
