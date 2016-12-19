require 'spec_helper'

describe Forms::Test::Field do
  let!(:field_with_options)              { FactoryGirl.create :field_with_options }
  let!(:field_without_score_and_options) { FactoryGirl.build :field, score: nil }

  it "has a valid factory" do
    expect(field_with_options).to be_valid
  end

  it "has a valid options" do
    expect(field_with_options).to be_valid
  end

	it "has invalid score and must be present at least two options" do
    field_without_score_and_options.valid?
    expect(field_without_score_and_options.errors[:score]).to include("can't be blank")
    expect(field_without_score_and_options.errors[:score]).to include("is not a number")
    expect(field_without_score_and_options.errors[:at_least_two_options]).to include("must be present")
	end
end
