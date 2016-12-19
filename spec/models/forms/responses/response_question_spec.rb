require 'spec_helper'

describe Forms::Response::Question do
  let!(:response_question_with_fields) { FactoryGirl.create :response_question_with_fields }

  it "has a valid response question" do
    expect(response_question_with_fields).to be_valid
  end

  it "has a valid fields" do
    expect(response_question_with_fields).to be_valid
  end
end
