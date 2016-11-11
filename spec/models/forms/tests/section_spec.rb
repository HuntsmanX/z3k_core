require 'spec_helper'

describe Forms::Test::Section do
  let!(:section)                { FactoryGirl.create :section }
  let!(:section_with_questions) { FactoryGirl.create :section_with_questions }

  it "has a valid factory" do
    expect(section).to be_valid
  end

  it "has a valid questions" do
    expect(section_with_questions).to be_valid
  end
end
