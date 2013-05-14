class Domain < ActiveRecord::Base
  attr_accessible :name

	has_many :search_logs
	has_many :result_browse_logs

	def self.exist? domain_name
		!find_by_name(domain_name).blank?
	end
end
