require 'spec_helper'

describe Forms::Response do
	let!(:user_ua)                { FactoryGirl.create :user_ua }
	let!(:response)               { FactoryGirl.build :response }
	let!(:response_without_name)  { FactoryGirl.build :response, name: nil }
	let!(:response_section)       { FactoryGirl.create :response_section }

	it "should validate that response must have user" do
		response.valid?
		expect(response.errors[:user_id]).to include("can't be blank")
	end

	it "should validate that response must have name" do
		response_without_name.valid?
		expect(response_without_name.errors[:name]).to include("can't be blank")
	end

	it "should validate factory" do
		response.user_id = user_ua.id
		response.save
		expect(response).to be_valid
	end

	it "should have valid sections factory" do
		response.user_id = user_ua.id
		response.save
		response.sections << response_section
		expect(response).to be_valid
	end
end
