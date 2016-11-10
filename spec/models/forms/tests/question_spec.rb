require 'spec_helper'

describe Forms::Test::Question do
let!(:question_with_fields) { FactoryGirl.create :question_with_fields }

  it "has a valid factory" do
    expect(question_with_fields).to be_valid
  end

  it "has a valid fields" do
    expect(question_with_fields).to be_valid
  end
end
