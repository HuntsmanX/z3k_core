class Forms::FindOrInitTestee

  def initialize recruitment_id
    @recruitment_id = recruitment_id
  end

  def testee
    attrs = OpenStruct.new Forms::Testee.show(@recruitment_id, 'recruitment')

    user = User.find_or_initialize_by(recruitment_id: recruitment_id)

    user.assign_attributes({
      city_id:  attrs.city_id,
      email:    generate_email(attrs),
      password: SecureRandom.hex(10),
      names:    {
        first_name:     attrs.first_name,
        last_name:      attrs.last_name,
        first_name_eng: attrs.first_name_eng,
        last_name_eng:  attrs.last_name_eng
      }
    })
    user.save!
    user
  end

  private

  attr_reader :recruitment_id

  def generate_email attrs
    parts = [SecureRandom.hex(4), attrs.first_name_eng, attrs.last_name_eng]
    "#{parts.join('-')}@zone3000.net".downcase
  end

end
