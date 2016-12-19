require 'spec_helper'

describe Forms::Test::Option do
  let!(:option) { FactoryGirl.create :option }

  it "has a valid option" do
    expect(option).to be_valid
  end
end
