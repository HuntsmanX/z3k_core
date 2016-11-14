require './app/services/forms/response_dup'

describe ResponseDup do
  let!(:user)       { FactoryGirl.create :user }
  let!(:full_test)  { FactoryGirl.create :full_test }

  it "creates a response via clone test" do
    expect(ResponseDup.new(user, full_test.id).response).to be_valid
  end
end
