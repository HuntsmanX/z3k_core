class Forms::DuplicateTestForResponse < ApplicationService

  def initialize(testee, test_id)
    @response = testee.responses.new
    @test     = Forms::Test.with_nested.find_by id: test_id
  end

  def perform
    return [false, 'Unable to create response for a test with warnings'] if test.errors.any?
    duplicate_test ? [true, response] : [false, response.errors]
  end

  private

  attr_reader :test, :response

  def duplicate_test
   @response.attributes = @test.attributes.except('id')
   @response.save
   duplicate_sections if @test.sections.any?
  end

  def duplicate_sections
    @test.sections.each do |section|
      response_section = @response.sections.create(section.attributes.except('id', 'test_id', 'questions_count'))
      section_questions = get_section_questions(section)
      duplicate_questions(response_section, section_questions) if section_questions.any?
    end
  end

  def get_section_questions(section)
    questions = section.questions
    shuffle   = section.shuffle_questions
    show      = section.questions_to_show

    questions = questions.shuffle    if     shuffle
    questions = questions.take(show) unless show.nil? || show.zero?

    questions
  end

  def duplicate_questions(section, questions)
    questions.each do |q|
      response_question = section.questions.create q.attributes.except('id', 'section_id', 'created_at', 'updated_at')
      duplicate_fields(response_question, q.fields) if q.fields.any?
    end
  end

  def duplicate_fields(question, fields)
    fields.each do |field|
      response_field = question.fields.create field.attributes.except!('id', 'question_id', 'created_at', 'updated_at')
      duplicate_options(response_field, field.options) if field.options.any?
    end
  end

  def duplicate_options(field, options)

    indexes = options.map(&:order_index)

    options.shuffle.each do |option|
      attributes = option.attributes.except!('id', 'field_id', 'created_at', 'updated_at').with_indifferent_access
      attributes.merge!(correct_order_index: attributes[:order_index], order_index: indexes.delete_at(rand(indexes.length))) if field.sequence?
      field.options.create attributes
    end

    if field.dropdown? || field.inline_dropdown?
      field.options.create(
        content:       'Please select',
        is_correct:    false,
        user_selected: true,
        order_index:   -1
      )
    end
  end

end
