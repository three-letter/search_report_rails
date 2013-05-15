require 'spec_helper'

describe PositionStatistics do

	before(:each) do
		@domain = create(:domain)
		@position_statistics = PositionStatistics.create({:domain_id => @domain.id, :position => 1, :created_at => Time.now})
	end

	it "should return the position_statistics if exist by domian_id and position and date" do
		PositionStatistics.find_or_new_by_domain_id_and_position_and_created_at(@domain.id, @position_statistics.position, @position_statistics.created_at).id == @position_statistics.id
	end

	it "should add new record if not exist by domian_id and position and date" do
		PositionStatistics.find_or_new_by_domain_id_and_position_and_created_at(@domain.id, @position_statistics.position, (Date.today + 10).to_time).id.should be_true
	end

end
