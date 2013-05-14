require 'spec_helper'

describe SearchLog do

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
end
