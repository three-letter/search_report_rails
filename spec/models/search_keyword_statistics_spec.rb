require 'spec_helper'

describe SearchKeywordStatistics do

	before(:each) do
		@domain = create(:domain) 
		@search_keyword_statistics = SearchKeywordStatistics.create({:domain_id => @domain.id, :search_keyword => "search keyword"})
	end
	
	it "should return true if the record exist" do
		SearchKeywordStatistics.exist?(@domain.id, @search_keyword_statistics.search_keyword).should be_true
	end

	it "should return false if the record not exist" do
		SearchKeywordStatistics.exist?(@domain.id, "not exist keyword").should_not be_true
	end

end
