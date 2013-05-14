require 'spec_helper'

describe ResultBrowseLog do

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
end
