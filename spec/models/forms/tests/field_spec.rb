require 'spec_helper'

describe Forms::Test::Field do
  let!(:field_with_options) { FactoryGirl.create :field_with_options }

  it "has a valid factory" do
    expect(field_with_options).to be_valid
  end

  it "has a valid options" do
    expect(field_with_options).to be_valid
  end
end
