require './app/services/forms/duplicate_test_for_response'

describe ::Forms::DuplicateTestForResponse do
  let!(:user_ua)    { FactoryGirl.create :user_ua }
  let!(:full_test)  { FactoryGirl.create :full_test }

  it "creates a response via clone test" do
    response = ::Forms::DuplicateTestForResponse.new(user_ua, full_test.id).call
    expect(response.payload).to be_valid
  end
end
