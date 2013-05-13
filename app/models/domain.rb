class Domain < ActiveRecord::Base
  attr_accessible :name

	def self.exist? domain_name
		!find_by_name(domain_name).blank?
	end
end
