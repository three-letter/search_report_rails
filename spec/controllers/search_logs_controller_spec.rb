require 'spec_helper'

describe SearchLogsController do
	
	before(:each) { @domain = create(:domain) }

	let(:valid_search_log) do
		{
			:visit_id => "visit_spec",
			:date => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
			:search_result_count => 15,
			:keyword => "google",
			:browser_type => "Firefox",
			:domain => @domain.name
		}
	end

	let(:invalid_format_search_log) do
		{
			:visit_id => "visit_spec_invalid",
			:date => "12",
			:search_result_count => 15,
			:keyword => "google",
			:browser_type => "Firefox",
			:domain => "invalid domain name"
		}
	end


  describe "POST 'create'" do
    it "should save record success and returns code 1 if create with valid params" do
			request.env["HTTP_ACCEPT"] = "application/json"
			expect{ post 'create', valid_search_log }.to change(SearchLog, :count).by(1)
			JSON.parse(response.body)["code"] == 1
    end

    it "should save record fail and returns code -2 if create with invalid format params" do
			request.env["HTTP_ACCEPT"] = "application/json"
			expect{ post 'create', invalid_format_search_log }.to change(SearchLog, :count).by(0)
			JSON.parse(response.body)["code"] == -2
  	end
	end

end
