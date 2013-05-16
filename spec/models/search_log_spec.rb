require 'spec_helper'

describe SearchLog do
	
	before(:each) do
		@domain = create(:domain) 
		@search_log = SearchLog.create({:domain_id => @domain.id, :keyword => "test in rspec", :created_at => Time.now})
	end

	it "should add 50 records if setup default" do
		expect {
			SearchLog.setup
		}.to change{SearchLog.count}.by(50)
	end
	
	it "should add 50 records if setup by define date" do
		expect {
			SearchLog.setup(Time.now)
		}.to change{SearchLog.count}.by(50)
	end

	context "statistics by search log" do
		
		it "should change search_count after statistics search_keyword without date" do
			expect {
				SearchLog.statistics_search_keyword_by_date(@search_log.created_at.to_date)
			}	.to change{SearchKeywordStatistics.find_or_new_by_domain_id_and_search_keyword(@domain.id,@search_log.keyword).search_count}.by(1)
		end

		it "should change count after statistics search with date" do
			expect {
				SearchLog.statistics_search_by_date(@search_log.created_at.to_date)	
			}.to change{SearchStatistics.count}.by(1)
			SearchStatistics.find_or_new_by_domain_id_and_created_at(@domain_id,@search_log.created_at.beginning_of_day).count == 1
		end

	context "save log to txt everyday" do
		it "should generate a new file if save success" do
			SearchLog.save_to_txt(Date.today)
			File.exist?(File.expand_path("../../..", __FILE__) + "/public/db/search_log_#{Date.today.strftime('%Y-%m-%d')}.txt").should be_true
		end
	end

	end

end
