require 'spec_helper'

describe ResultBrowseLogsController do
	
	before(:each) { @domain = create(:domain) }

	let(:valid_result_browse_log) do
		{
			:visit_id => "valid_visit_id",
			:page => 1,
			:position => 2,
			:page_size => 10,
			:keyword => "qq",
			:browser_type => "IE",
			:domain => @domain.name,
			:date => Time.now.strftime("%Y-%m-%d %H:%M:%S")
		}
	end

	let(:invalid_format_result_browse_log) do
		{
			:visit_id => "invalid_visit_id",
			:page => 1,
			:position => 2,
			:page_size => 10,
			:keyword => "qq",
			:browser_type => "IE",
			:domain => @domain.name,
			:date => "12"
		}
	end

  describe "POST 'create'" do
    it "should add record success and return code 1 if save with valid params" do
     request.env["HTTP_ACCEPT"] = "application/json"
		 expect { post 'create', valid_result_browse_log }.to change(ResultBrowseLog, :count).by(1)
			JSON.parse(response.body)["code"] == 1
    end
    it "should add record fail and return code -2 if save with invalid format params" do
     request.env["HTTP_ACCEPT"] = "application/json"
     expect { post 'create', invalid_format_result_browse_log }.not_to change(ResultBrowseLog, :count).by(1)
			JSON.parse(response.body)["code"] == -2
    end
  end

end
