class Role < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :role_assignments
  has_many :users, through: :role_assignments

  has_many :permissions

  accepts_nested_attributes_for :permissions

  def permissions
    stored_values = super

    schema = PermissionsSchema.new

    diff = schema.permission_keys - stored_values.map(&:key)

    diff.each do |key|
      super.create({
        key:        key,
        allowed:    false,
        conditions: schema.permission_for(key).default_conditions
      })
    end if diff.any?

    super
  end

  def remove_user(id)
    self.role_assignments.where(user_id: id).delete_all
  end

  def add_user(id)
    assignment = self.role_assignments.build(user_id: id)
    assignment.save
  end

  private

  def collect_conditions!(attributes)
    return attributes.de['conditions'] if attributes.fetch('conditions', false)

    attributes.keys.each do |k|
      answer = collect_conditions!(attributes[k]) if attributes[k].is_a? Hash
      return answer if answer
    end

    false
  end

end
