require 'spec_helper'

describe Forms::Test::Question do
  let!(:question_with_fields)     { FactoryGirl.create :question_with_fields }
  let!(:question_without_fields)  { FactoryGirl.build :question }

  it "has a valid question with fields" do
    expect(question_with_fields).to be_valid
  end

  it "has a valid fields" do
    expect(question_with_fields).to be_valid
  end

	it "has invalid fields_count" do
    question_without_fields.valid?
    expect(question_without_fields.errors[:question]).to include("must contain at least one field")
  end
end
