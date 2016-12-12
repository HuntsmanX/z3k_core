class Forms::DuplicateTestForResponse
  attr_reader :response

  def initialize(testee, test_id)
    @response = testee.responses.new
    @test     = Forms::Test.with_nested.find_by id: test_id

    duplicate_test!
  end

  private

  def duplicate_test!
     @response.name =    @test.name
     @response.test_id = @test.id
     @response.save

     duplicate_sections if @test.sections.any?
  end

  def duplicate_sections
    @test.sections.each do |section|
      response_section = response.sections.create(
        title:                  section.title,
        time_limit:             section.time_limit,
        bonus_time:             section.bonus_time,
        description:            section.description,
        order_index:            section.order_index,
        required_score:         section.required_score,
        acceptable_score:       section.acceptable_score,
        acceptable_score_unit:  section.acceptable_score_unit,
        required_score_unit:    section.required_score_unit,
        show_next_section:      section.show_next_section,
        questions_to_show:      section.questions_to_show,
        shuffle_questions:      section.shuffle_questions
      )

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
