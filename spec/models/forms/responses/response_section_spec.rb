require 'spec_helper'

describe Forms::Response::Section do
  let!(:response_section)                { FactoryGirl.create :response_section }
  let!(:response_section_with_questions) { FactoryGirl.create :response_section_with_questions }

  it "has a valid factory" do
    expect(response_section).to be_valid
  end

  it "has a valid questions" do
    expect(response_section_with_questions).to be_valid
  end
end
