require 'spec_helper'

describe KeywordPositionStatistics do
	
	before(:each) do
		@domain = create(:domain)
		@keyword_position_statistics = KeywordPositionStatistics.create({:domain_id => @domain.id, :search_keyword => "test in rspec", :position => 1, :created_at => Time.now})
	end

	it "should return the keyword_position_statistics if exist by domain_id, keyword, position" do
		KeywordPositionStatistics.find_or_new_by_domain_id_and_keyword_and_position_and_date(@domain.id, @keyword_position_statistics.search_keyword, @keyword_position_statistics.position, @keyword_position_statistics.created_at).id == @keyword_position_statistics.id
	end

	it "should add new record if not exist by domain_id, keyword, position" do
		expect {
			KeywordPositionStatistics.find_or_new_by_domain_id_and_keyword_and_position_and_date(@domain.id, @keyword_position_statistics.search_keyword, @keyword_position_statistics.position, (Date.today + 10).to_time)
		}.to change{KeywordPositionStatistics.count}.by(1)
	end
end
