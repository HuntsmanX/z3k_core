require 'faker'

FactoryGirl.define do
  factory :test, class: Forms::Test do |f|
    f.name { Faker::StarWars.planet }

    factory :test_with_sections do
      after(:create) do |test|
        create(:section, test: test)
      end
    end

    factory :full_test do
      after(:create) do |test|
        section = create(:section, test: test)
        section.questions << FactoryGirl.create(:question_with_fields, section: section)
      end
    end
  end

  factory :section, class: Forms::Test::Section do |f|
    f.title             { Faker::StarWars.planet }
    f.required_score    { Faker::Number.between(1, 50) }
    f.acceptable_score  { Faker::Number.between(1, 50) }
    f.description       { Faker::ChuckNorris.fact }
    f.time_limit        { Faker::Number.between(1, 50) }
    f.shuffle_questions { true }

      factory :section_with_questions do
        before(:create) do |section|
          section.questions << FactoryGirl.create(:question_with_fields, section: section)
        end
      end
  end

  factory :question, class: Forms::Test::Question do |f|
    f.content     { "{'entityMap':{'0':{'type':'sequence','mutability':'IMMUTABLE','data':{}}},'blocks':[{'key':'8qdri','text':'Untitled question','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}},{'key':'8b3ej','text':' ','type':'atomic','depth':0,'inlineStyleRanges':[],'entityRanges':[{'offset':0,'length':1,'key':0}],'data':{}},{'key':'f3de1','text':'','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}}]}" }
    f.order_index { 0 }
    factory :question_with_fields do
      before(:create) do |question|
        question.fields << FactoryGirl.build(:field_with_options, question: question)
      end
    end
  end

  factory :field, class: Forms::Test::Field do |f|
    f.field_type { "sequence" }
    f.block_key  { "8b3ej" }
    f.content    { "" }
    f.score      { 1 }
    f.autocheck  { true }

    factory :field_with_options do
      after(:build) do |field|
        field.options << FactoryGirl.build(:option, field: field)
        field.options << FactoryGirl.build(:option, content: "2", is_correct: false, order_index: 1, field: field)
        field.options << FactoryGirl.build(:option, content: "3", is_correct: false, order_index: 2, field: field)
      end
    end
  end

  factory :option, class: Forms::Test::Option  do |f|
    f.content     { "1" }
    f.is_correct  { true }
    f.order_index { 0 }
  end
end
