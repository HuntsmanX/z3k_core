require 'spec_helper'

describe Forms::Response do
	let!(:response)               { FactoryGirl.create :response }
	let!(:response_with_sections) { FactoryGirl.create :response_with_sections }

	it "has a valid factory" do
		expect(response).to be_valid
	end

	it "has a valid section" do
		expect(response_with_sections).to be_valid
	end
end
