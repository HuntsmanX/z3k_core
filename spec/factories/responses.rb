require 'faker'

FactoryGirl.define do
  factory :response, class: Forms::Response do |f|
    f.name { Faker::StarWars.planet }

    factory :response_with_sections do
      after(:create) do |response|
        create(:response_section, response: response)
      end
    end

    factory :full_response do
      after(:create) do |response|
        response_section = create(:response_section, response: response)
        response_section.questions << FactoryGirl.create(:response_question_with_fields, section: response_section)
      end
    end
  end

  factory :response_section, class: Forms::Response::Section do |f|
    f.title { Faker::StarWars.planet }
    f.required_score { 50 }
    f.acceptable_score { Faker::Number.between(1, 50) }
    f.description { Faker::ChuckNorris.fact }
    f.time_limit { Faker::Number.between(1, 50) }

    factory :response_section_with_questions do
      before(:create) do |section|
        section.questions << FactoryGirl.create(:response_question_with_fields, section: section)
      end
    end
  end

  factory :response_question, class: Forms::Response::Question do |f|
    f.content     { "{'entityMap':{'0':{'type':'sequence','mutability':'IMMUTABLE','data':{}}},'blocks':[{'key':'8qdri','text':'Untitled question','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}},{'key':'8b3ej','text':' ','type':'atomic','depth':0,'inlineStyleRanges':[],'entityRanges':[{'offset':0,'length':1,'key':0}],'data':{}},{'key':'f3de1','text':'','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}}]}" }
    f.order_index { 0 }
    factory :response_question_with_fields do
      before(:create) do |question|
        question.fields << FactoryGirl.build(:response_field_with_options, question: question)
      end
    end
  end

  factory :response_field, class: Forms::Response::Field do |f|
    f.field_type { "sequence" }
    f.block_key  { "8b3ej" }
    f.content    { "" }
    f.score      { 10 }
    f.autocheck  { true }
    f.user_score {}

    factory :response_field_with_options do
      after(:build) do |field|
        field.options << FactoryGirl.build(:response_option, field: field)
        field.options << FactoryGirl.build(:response_option, content: "2", is_correct: false, order_index: 1, field: field)
        field.options << FactoryGirl.build(:response_option, content: "3", is_correct: false, order_index: 2, field: field)
      end
    end
  end

  factory :response_option, class: Forms::Response::Option  do |f|
    f.content       { "1" }
    f.user_selected { true }
    f.is_correct    { true }
    f.order_index   { 0 }
  end
end
