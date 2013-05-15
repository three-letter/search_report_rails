require 'spec_helper'

describe Domain do

	before(:each) do
		@domain = create(:domain)
	end

	it "should be return the domain if exist by name" do
		Domain.find_or_new_by_name(@domain.name).id == @domain.id
	end
	
	it "should be save new record if not exist by name" do
		Domain.find_or_new_by_name(Time.now.to_i.to_s).id.should be_true
	end

end
