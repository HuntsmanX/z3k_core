class Forms::CheckResponseSection

  methods_names_for_select = [
    :check_checkboxes,
    :check_dropdown,
    :check_sequence,
    :check_radio_buttons,
    :check_inline_dropdown
  ]

  method_names_for_text = [
    :check_text_input,
    :check_text_area,
    :check_inline_text_input
  ]

  def self.field_score(field)
    avg = option_average_score(field)
    score = 0

    if field.sequence?
      field.options.each { |opt| score += avg if opt.order_index == opt.correct_order_index }
    else
      field.options.where(is_correct: true).pluck(:user_selected).uniq.each { |correct| score += avg if correct.present? }
    end

    score
  end

  def self.option_average_score(field)
    field.score / field.options.count
  end

  def self.check(response_section)
    user_score = []
    response_section.questions.each do |question|
      question.fields.where(autocheck: true).where.not(field_type: ::Forms::Test::Field.field_types['text_editor']).each do |field|
        user_score << self.send("check_#{field.field_type}", field)
      end
    end
    response_section.show_next_regardless_of_score? ? true : self.pass_section?(response_section, user_score)
  end

  def self.pass_section?(response_section, user_score)
    max_response_section = response_section.questions.map(&:fields).flatten.map(&:score).inject(:+) || 0
    scores = user_score.grep(Integer).reduce(:+) || -1
    if response_section.required_score_unit_percent?
      available_score = max_response_section * (response_section.required_score / 100.0)
      scores = user_score.grep(Integer).reduce(:+) || -1
      scores >= available_score
    else
      scores >= response_section.required_score
    end
  end

  methods_names_for_select.each do |method_name|
    Forms::CheckResponseSection.define_singleton_method(method_name) do |field|
      score = field_score(field)
      field.update(score: score, checked: true)
      score
    end
  end

  method_names_for_text.each do |method_name|
    Forms::CheckResponseSection.define_singleton_method(method_name) do |field|
      if field.content == field.user_content
        field.update(user_score: field.score)
        score = field.score
      else
       score = 0
      end
      field.update(checked: true)
      score
    end
  end

end
