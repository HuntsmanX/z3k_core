example_test = Forms::Test.create(name: 'ExampleTest')

example_section = example_test.sections.create(title: 'FirstSection', time_limit: 60,
                             description: 'Description for example test',
                             required_score: 60, required_score_units: 'points',
                             order_index: 0, bonus_time: 0,shuffle_questions: true,
                             questions_to_show: 0, acceptable_score: 0, acceptable_score_units: "points",
                             show_next_section: "always")

first_example_question = example_section.questions.new(content: "{'entityMap':{'0':{'type':'sequence','mutability':'IMMUTABLE','data':{}}},'blocks':[{'key':'8qdri','text':'Untitled question','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}},{'key':'8b3ej','text':' ','type':'atomic','depth':0,'inlineStyleRanges':[],'entityRanges':[{'offset':0,'length':1,'key':0}],'data':{}},{'key':'f3de1','text':'','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}}]}",
                                                       order_index: 0)
first_example_question.save(validate: false)

first_field = first_example_question.fields.new(field_type: "sequence", block_key: "8b3ej", content: "", score: 1, autocheck: true)
first_field.save(validate: false)

first_field.options.create(content: "1", is_correct: true,  order_index: 0)
first_field.options.create(content: "2", is_correct: false, order_index: 1)
first_field.options.create(content: "3", is_correct: false, order_index: 2)
first_field.options.create(content: "4", is_correct: false, order_index: 3)

second_example_question = example_section.questions.new(content: "{'entityMap':{'0':{'type':'radio_buttons','mutability':'IMMUTABLE','data':{}}},'blocks':[{'key':'5t6mf','text':'Untitled question','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}},{'key':'tfgk','text':'','type':'atomic','depth':0,'inlineStyleRanges':[],'entityRanges':[{'offset':0,'length':1,'key':0}],'data':{}},{'key':'afti9','text':'','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}}]}",
                                                           order_index: 1)
second_example_question.save(validate: false)

second_example_question_field = second_example_question.fields.new(field_type: "radio_buttons", block_key: "tfgk", content: "", score: 1, autocheck: false)
second_example_question_field.save(validate: false)

second_example_question_field.options.create(content: "1", is_correct: true, order_index: 0)
second_example_question_field.options.create(content: "2", is_correct: false, order_index: 1)
second_example_question_field.options.create(content: "3", is_correct: false, order_index: 2)

third_example_question = example_section.questions.new(content: "{'entityMap':{'0':{'type':'checkboxes','mutability':'IMMUTABLE','data':{}}},'blocks':[{'key':'7s9u4','text':'Untitled question','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}},{'key':'3n01m','text':'','type':'atomic','depth':0,'inlineStyleRanges':[],'entityRanges':[{'offset':0,'length':1,'key':0}],'data':{}},{'key':'9f1cq','text':'','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}}]}",
                                                          order_index: 2)
third_example_question.save(validate: false)

third_example_question_field = third_example_question.fields.new(field_type: "checkboxes", block_key: "3n01m", content: "", score: 1, autocheck: false,)
third_example_question_field.save(validate: false)

third_example_question_field.options.create(content: "1", is_correct: true, order_index: 0)
third_example_question_field.options.create(content: "2", is_correct: false, order_index: 1)
third_example_question_field.options.create(content: "3", is_correct: false, order_index: 2)

fourth_example_question = example_section.questions.new(content: "{'entityMap':{'0':{'type':'dropdown','mutability':'IMMUTABLE','data':{}}},'blocks':[{'key':'bv94r','text':'Untitled question','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}},{'key':'ag3vk','text':'','type':'atomic','depth':0,'inlineStyleRanges':[],'entityRanges':[{'offset':0,'length':1,'key':0}],'data':{}},{'key':'eko67','text':'','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}}]}",
                                                           order_index: 3)
fourth_example_question.save(validate: false)

fourth_example_question_field = fourth_example_question.fields.new(field_type: "dropdown", block_key: "ag3vk", content: "", score: 1, autocheck: false)
fourth_example_question_field.save(validate: false)

fourth_example_question_field.options.create(content: "1", is_correct: true, order_index: 0)
fourth_example_question_field.options.create(content: "2", is_correct: false, order_index: 1)
fourth_example_question_field.options.create(content: "3", is_correct: false, order_index: 2)

example_response = Forms::Response.create(name: 'ExampleResponse', test_id: example_test.id)
example_response_section = example_response.sections.new(title: "Response Section", time_limit: 0, description: "Section description", required_score: 0, uuid: "Qdu-aApOCGA", score_units: nil, order_index: nil, acceptable_score: 0)
example_response_section.save(validate: false)

first_response_section_question = example_response_section.questions.new(content: "{'entityMap':{'0':{'type':'sequence','mutability':'IMMUTABLE','data':{}}},'blocks':[{'key':'8qdri','text':'Untitled question','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}},{'key':'8b3ej','text':'','type':'atomic','depth':0,'inlineStyleRanges':[],'entityRanges':[{'offset':0,'length':1,'key':0}],'data':{}},{'key':'f3de1','text':'','type':'unstyled','depth':0,'inlineStyleRanges':[],'entityRanges':[],'data':{}}]}",
                                                                         order_index: 0)
first_response_section_question.save(validate: false)

first_response_section_question_field = first_response_section_question.fields.new(field_type: "sequence", block_key: "8b3ej", content: "", score: 1, autocheck: true,  user_content: "", user_score: 0, checked: true)
first_response_section_question_field.save(validate: false)

first_response_section_question_field.options.create( content: "1", is_correct: true, order_index: 0, user_selected: false)
first_response_section_question_field.options.create( content: "2", is_correct: false, order_index: 1, user_selected: false)
first_response_section_question_field.options.create( content: "3", is_correct: false, order_index: 2, user_selected: true)
first_response_section_question_field.options.create( content: "4", is_correct: false, order_index: 3, user_selected: false)
