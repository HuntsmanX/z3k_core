class PermissionsSchema

  class Permission
    include ActiveModel::Model

    attr_accessor :key, :action, :label, :resource_name, :resource_class, :conditions

    def initialize attrs
      self.assign_attributes attrs
      format_conditions!
    end

    def default_conditions
      conditions.each_with_object({}) do |condition, hash|
        option = condition.options.first
        hash[condition[:name]] = option[:value]
      end
    end

    private

    def format_conditions!
      @conditions ||= []
      @conditions.each do |condition|
        condition['options'] = condition['options'].map do |key, val|
          { value: key, label: val }
        end
      end
      @conditions.map! { |condition| OpenStruct.new condition }
    end

  end

  def initialize
    path = File.join Rails.root, '/config/permissions_schema.yml'
    @schema = YAML::load_file(path).with_indifferent_access
  end

  def permissions
    @permissions ||= resource_keys.map { |key| permissions_for key }.flatten
  end

  def permission_keys
    permissions.map &:key
  end

  def permission_for permission_key
    permissions.find { |p| p.key == permission_key }
  end

  private

  def resource_keys
    @schema.keys
  end

  def permissions_for resource_key
    resource = @schema[resource_key]

    resource[:permissions].map do |p|
      p[:resource_name]  = resource[:name]
      p[:resource_class] = resource[:class].constantize

      Permission.new p
    end
  end

end
