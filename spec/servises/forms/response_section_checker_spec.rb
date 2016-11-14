require './app/services/forms/response_section_checker'

describe ResponseSectionChecker do
  let!(:user)           { FactoryGirl.create :user }
  let!(:full_response)  { FactoryGirl.create :full_response }

  it "cheks wrong response section" do
    expect(ResponseSectionChecker.can_visit_next_section?(full_response.sections.last)).to be false
  end
end
