require 'spec_helper'

describe Domain do

	before(:each) do
		@domain = create(:domain)
	end

	it "should be return true if the domain exist" do
		Domain.exist?(@domain.name).should be_true
	end
	
	it "should be return false if the domain not exist" do
		Domain.exist?(Time.now.to_i.to_s).should be_false
	end

end
