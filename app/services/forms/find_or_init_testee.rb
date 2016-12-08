class Forms::FindOrInitTestee

  def initialize params
    @params = params
  end

  def testee(source_type = "recruitment")
    self.send "get_#{source_type}"
  end

  private

  def get_local
    User.find_or_initialize_by(email: email) do |t|
      t.first_name = first_name
      t.last_name  = last_name
      t.city_id    = city_id
      t.password   = SecureRandom.hex(4)
    end
  end

  def get_recruitment
    testee = OpenStruct.new Forms::Testee.show(@params, 'recruitment')
    user = User.find_or_initialize_by(recruitment_id: @params) do |t|
      t.city_id    = testee.city_id
      t.email      = testee.email
      t.first_name = testee.full_name.split&.[](0)
      t.last_name  = testee.full_name.split&.[](1)
      t.password   = SecureRandom.hex(4)
    end
    user.skip_confirmation!
    user.save!
    user
  end

  def method_missing name, *args, &block
    super unless @params.key?(name)
    @params[name]
  end

end
