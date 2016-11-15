require 'spec_helper'

describe Forms::Test do
  let!(:test)               { FactoryGirl.create :test }
  let!(:test_with_sections) { FactoryGirl.create :test_with_sections }

  it "has a valid factory" do
    expect(test).to be_valid
  end

  it "has a valid section" do
    expect(test_with_sections).to be_valid
  end
end
