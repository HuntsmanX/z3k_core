require 'spec_helper'

describe User do
  let!(:user) { FactoryGirl.create :user }

  it "has a valid factory" do
    expect(user).to be_valid
  end
end
