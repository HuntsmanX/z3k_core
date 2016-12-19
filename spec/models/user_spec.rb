require 'spec_helper'

describe User do
  let!(:user_ua) { FactoryGirl.create :user_ua }
  let!(:user_in) { FactoryGirl.create :user_in }

  it "has a valid factory for UA" do
    expect(user_ua).to be_valid
  end

	it "has a valid factory for IN" do
    expect(user_in).to be_valid
	end
end
