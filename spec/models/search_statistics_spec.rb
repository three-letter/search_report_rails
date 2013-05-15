require 'spec_helper'

describe SearchStatistics do
	
	before(:each) do 
		@domain = create(:domain)
		@search_statistics = SearchStatistics.create({:domain_id => @domain.id, :created_at => Date.today.to_time})
	end
	
	it "should return the search_statistics if exist by domain_id and created_at" do
		SearchStatistics.find_or_new_by_domain_id_and_created_at(@domain.id,@search_statistics.created_at).id == @search_statistics.id
	end

	it "should add new record if not exist by domain_id and created_at" do
		SearchStatistics.find_or_new_by_domain_id_and_created_at(@domain.id, (Date.today + 100).to_time).id.should be_true
	end
end
