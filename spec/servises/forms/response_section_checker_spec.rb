require './app/services/forms/response_section_checker'

describe ResponseSectionChecker do
  let!(:user)           { FactoryGirl.create :user }
  let!(:full_response)  { FactoryGirl.create :full_response }

  it "cheks wrong response section" do
    expect(ResponseSectionChecker.can_visit_next_section?(full_response.sections.last)).to be false
  end

	it "cheks right response section" do
    full_response.sections.last.update(required_score: 1)
    expect(ResponseSectionChecker.can_visit_next_section?(full_response.sections.last)).to be true
	end
end
