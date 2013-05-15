require 'spec_helper'

describe SearchKeywordStatistics do

	before(:each) do
		@domain = create(:domain) 
		@search_keyword_statistics = SearchKeywordStatistics.create({:domain_id => @domain.id, :search_keyword => "search keyword"})
	end
	
	it "should return the search_keyword_statistics if exist by domain_id and search_keyword" do
		SearchKeywordStatistics.find_or_new_by_domain_id_and_search_keyword(@domain.id, @search_keyword_statistics.search_keyword).id == @search_keyword_statistics.id
	end

	it "should add new record if not exist by domain_id and search_keyword" do
		SearchKeywordStatistics.find_or_new_by_domain_id_and_search_keyword(@domain.id, "not exist keyword").id.should be_true
	end

end
