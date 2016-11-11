require 'spec_helper'

describe Forms::Response::Option do
  let!(:response_option) { FactoryGirl.create :response_option }

  it "has a valid factory" do
    expect(response_option).to be_valid
  end
end
