class SearchStatistics < ActiveRecord::Base
  attr_accessible :count, :domain_id, :created_at

	def self.find_or_new_by_domain_id_and_created_at(did, date)
		search_statistics = find_by_domain_id_and_created_at(did, date)
		search_statistics = create({:domain_id => did, :created_at => date}) if search_statistics.blank?
		search_statistics
	end

end
