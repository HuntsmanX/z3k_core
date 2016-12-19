require 'spec_helper'

describe Forms::Response::Section do
  let!(:response_section)                    { FactoryGirl.create :response_section }
  let!(:response_section_with_questions)     { FactoryGirl.create :response_section_with_questions }
  let!(:response_section_without_time_limit) { FactoryGirl.build :response_section, time_limit: nil }

  it "has a valid response section" do
    expect(response_section).to be_valid
  end

  it "has a valid questions" do
    expect(response_section_with_questions).to be_valid
  end

  it "should validate that response section must have time limit" do
    response_section_without_time_limit.valid?
    expect(response_section_without_time_limit.errors[:time_limit]).to include("is not a number")
  end
end
