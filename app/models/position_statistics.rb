class PositionStatistics < ActiveRecord::Base
  attr_accessible :count, :domain_id, :position, :created_at

	def self.find_or_new_by_domain_id_and_position_and_created_at(did, pos, date)
		position_statistics = find_by_domain_id_and_position_and_created_at(did, pos, date)
		position_statistics = create({:domain_id => did, :position => pos, :created_at => date}) if position_statistics.blank?
		position_statistics
	end
end
