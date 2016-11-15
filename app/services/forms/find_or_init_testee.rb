class Forms::FindOrInitTestee

  def initialize params
    @params = params
  end

  def testee
    self.send "get_#{source_type}"
  end

  private

  def get_local
    User.find_or_initialize_by(email: email) do |t|
      t.first_name = first_name
      t.last_name  = last_name
      t.city_id    = city_id
      t.password   = SecureRandom.hex(4)
      # t.phone = phone
    end
  end

  def get_recruitment
    testee = OpenStruct.new Forms::Testee.show(user_id, 'recruitment')

    User.find_or_initialize_by(recruitment_id: user_id) do |t|
      t.city_id    = testee.city_id
      t.email      = testee.email
      # t.phone    = testee.phone TODO: add contacts to user
      t.first_name = testee.full_name.split&.[](0)
      t.last_name  = testee.full_name.split&.[](1)
      t.password   = SecureRandom.hex(4)
    end

  end

  def method_missing name, *args, &block
    super unless @params.key?(name)
    @params[name]
  end

end
