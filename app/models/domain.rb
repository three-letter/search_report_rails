class Domain < ActiveRecord::Base
  attr_accessible :name

	has_many :search_logs
	has_many :result_browse_logs

	def self.find_or_new_by_name(domain_name)
		domain = find_by_name(domain_name)
		domain = create({:name => domain_name}) if domain.blank?
		domain
	end

end
