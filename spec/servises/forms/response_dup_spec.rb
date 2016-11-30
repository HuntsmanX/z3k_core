require './app/services/forms/duplicate_test_for_response'

describe DuplicateTestForResponse do
  let!(:user)       { FactoryGirl.create :user }
  let!(:full_test)  { FactoryGirl.create :full_test }

  it "creates a response via clone test" do
    expect(DuplicateTestForResponse.new(user, full_test.id).response).to be_valid
  end
end
