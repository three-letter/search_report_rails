require 'spec_helper'

describe ResultBrowseLog do

	before(:each) do 
		@domain = create(:domain)
		@result_browse_log = ResultBrowseLog.create({:domain_id => @domain.id, :result_position => 1, :created_at => Time.now, :search_keyword => "test in rspec"})
	end

	it "should add 50 records if setup by default" do
		expect {
			ResultBrowseLog.setup	
		}.to change{ResultBrowseLog.count}.by(50)
	end

	it "should add 50 records if setup by define date" do
		expect {
			ResultBrowseLog.setup(Time.now)
		}.to change{ResultBrowseLog.count}.by(50)
	end

	context "statistics result_browse_log" do
		it "should change the browse count after statistics position" do
			expect {
				ResultBrowseLog.statistics_position_by_date(Date.today)	
			}.to change{PositionStatistics.find_or_new_by_domain_id_and_position_and_created_at(@domain.id, @result_browse_log.result_position, @result_browse_log.created_at.beginning_of_day).count}.by(1)
		end
		it "should add new record after statistics position" do
			expect {
				ResultBrowseLog.statistics_position_by_date(Date.today)	
			}.to change{PositionStatistics.count}.by(21)
		end

		
		it "should change the browse count after statistics keyword_position" do
			expect {
				ResultBrowseLog.statistics_keyword_position_by_date(Date.today)	
			}.to change{KeywordPositionStatistics.find_or_new_by_domain_id_and_keyword_and_position_and_date(@domain.id, @result_browse_log.search_keyword, @result_browse_log.result_position, @result_browse_log.created_at.beginning_of_day).count}.by(1)
		end
		it "should add new record after statistics keyword_position" do
			expect {
				ResultBrowseLog.statistics_keyword_position_by_date(Date.today)	
			}.to change{KeywordPositionStatistics.count}.by(21)
		end

		
		context "save log to txt everyday" do
			it "should generate a new file if save success" do
				ResultBrowseLog.save_to_txt(Date.today)
				File.exist?(File.expand_path("../../..", __FILE__) + "/public/db/result_browse_log_#{Date.today.strftime('%Y-%m-%d')}.txt").should be_true
			end
		end


	end


end
