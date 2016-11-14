require 'spec_helper'

describe Forms::Response::Field do
  let!(:response_field_with_options) { FactoryGirl.create :response_field_with_options }

  it "has a valid factory" do
    expect(response_field_with_options).to be_valid
  end

  it "has a valid options" do
    expect(response_field_with_options).to be_valid
  end
end
