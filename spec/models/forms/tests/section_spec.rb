require 'spec_helper'

describe Forms::Test::Section do
  let!(:section)                            { FactoryGirl.create :section }
  let!(:section_without_title)              { FactoryGirl.build :section, title: nil }
  let!(:section_without_bonus_time)         { FactoryGirl.build :section, bonus_time: nil }
  let!(:section_without_questions_to_show)  { FactoryGirl.build :section, questions_to_show: nil }
  let!(:section_without_required_score)     { FactoryGirl.build :section, required_score: nil }
  let!(:section_without_time_limit)         { FactoryGirl.build :section, time_limit: nil }
  let!(:section_with_questions)             { FactoryGirl.build :section_with_questions }
  let!(:section_without_max_required_score) { FactoryGirl.build :section, required_score_unit: :percent, required_score: 800}

  it "has a valid factory" do
    expect(section).to be_valid
  end

  it "has a valid questions" do
    expect(section_with_questions).to be_valid
  end

	it "should validate that section has title" do
    section_without_title.valid?
    expect(section_without_title.errors[:title]).to include("can't be blank")
	end

  it "should validate that section's bonus time is numeric" do
    section_without_bonus_time.valid?
    expect(section_without_bonus_time.errors[:bonus_time]).to include("is not a number")
  end

	it "should validate that section's questions_to_show is numeric" do
    section_without_questions_to_show.valid?
    expect(section_without_questions_to_show.errors[:questions_to_show]).to include("is not a number")
	end

	it "should validate that section's required_score is numeric" do
    section_without_required_score.valid?
    expect(section_without_required_score.errors[:required_score]).to include("is not a number")
	end

	it "should validate that section's time_limit is numeric" do
    section_without_time_limit.valid?
    expect(section_without_time_limit.errors[:time_limit]).to include("is not a number")
	end

	it "should validate that section's required_score, is less than or equal to 100%" do
    section_without_max_required_score.valid?
    expect(section_without_max_required_score.errors[:required_score]).to include("should be less than or equal to 100%")
	end
end
