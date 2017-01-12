require './app/services/forms/check_response_section'
require './app/services/forms/duplicate_test_for_response'

describe ::Forms::CheckResponseSection do
  let!(:user_ua)                      { FactoryGirl.create :user_ua }
  let!(:test)                         { FactoryGirl.create :test }
  let!(:section)                      { FactoryGirl.create :section, acceptable_score: 20, required_score: 20 }
  let!(:question_with_fields)         { FactoryGirl.create :question_with_fields }
  let!(:question_with_fields_second)  { FactoryGirl.create :question_with_fields,
                                                            content: "{'entityMap':{'0':{'type':'text_area','mutability':'IMMUTABLE','data':{}}},'blocks':[{'key':'8cbhh','text':'2+2 =','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}},{'key':'6604h','text':' ','type':'atomic','depth':0,'inlineStyleRanges':[],'entityRanges':[{'offset':0,'length':1,'key':0}],'data':{}},{'key':'26ijr','text':'','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}}]}' ",
                                                            order_index: 1}

  let!(:option)        { FactoryGirl.create :option, content: '11', is_correct: false }
  let!(:option_second) { FactoryGirl.create :option, content: '10', is_correct: true }

  it "checks right response section (points)" do
    full_test = create_full_test
    response_result = ::Forms::DuplicateTestForResponse.new(user_ua, full_test.id).call
    response = response_result.payload
    update_response_section_for_correct_answer(response.sections.first)
    expect(::Forms::CheckResponseSection.new(response.sections.first).call.payload).to be true
  end

  it "checks wrong response section (points)" do
    full_test = create_full_test
    response_result = ::Forms::DuplicateTestForResponse.new(user_ua, full_test.id).call
    response = response_result.payload
    update_response_section_for_incorrect_answer(response.sections.first)
    expect(::Forms::CheckResponseSection.new(response.sections.first).call.error).to be false
  end

  it "checks right response section (percent)" do
    full_test = create_full_test
    response_result = ::Forms::DuplicateTestForResponse.new(user_ua, full_test.id).call
    response = response_result.payload
    response.sections.first.update(acceptable_score_unit: 'percent', required_score_unit: 'percent',  acceptable_score: 50)
    update_response_section_for_correct_answer_percent(response.sections.first)
    expect(::Forms::CheckResponseSection.new(response.sections.first).call.payload).to be true
  end

  it "checks wrong response section (percent)" do
    full_test = create_full_test
    response_result = ::Forms::DuplicateTestForResponse.new(user_ua, full_test.id).call
    response = response_result.payload
    response.sections.first.update(acceptable_score_unit: 'percent', required_score_unit: 'percent',  acceptable_score: 50)
    update_response_section_for_incorrect_answer(response.sections.first)
    expect(::Forms::CheckResponseSection.new(response.sections.first).call.error).to be false
  end

  it "show next sections regardless of score" do
    full_test = create_full_test
    response_result = ::Forms::DuplicateTestForResponse.new(user_ua, full_test.id).call
    response = response_result.payload
    response.sections.first.update(show_next_section: 'show_next_regardless_of_score', acceptable_score: 50)
    update_response_section_for_incorrect_answer(response.sections.first)
    expect(::Forms::CheckResponseSection.new(response.sections.first).call.payload).to be true
  end

	def create_full_test
    question_with_fields_second.fields.first.update(field_type: 'text_area', block_key: '6604h', content: '4')
    section.questions << [question_with_fields, question_with_fields_second]
    test.sections << section
    test
  end

	def update_response_section_for_correct_answer(section)
    section.questions.first.fields.first.update(user_content: section.questions.first.fields.first.content)
    section.questions.second.fields.first.update(user_content: section.questions.second.fields.first.content)
  end

	def update_response_section_for_incorrect_answer(section)
    section.questions.first.fields.first.update(user_content: 89)
    section.questions.second.fields.first.update(user_content: 159)
  end

	def update_response_section_for_correct_answer_percent(section)
    section.questions.first.fields.first.update(user_content: section.questions.first.fields.first.content)
  end

end
