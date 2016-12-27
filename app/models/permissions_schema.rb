class PermissionsSchema

  include Singleton

  def initialize
    path = File.join Rails.root, '/config/permissions_schema.yml'
    @schema = YAML::load_file(path).with_indifferent_access
  end

  def permissions
    @permissions ||= get_permissions
  end

  def permission_keys
    permissions.map &:key
  end

  def permission_for permission_key
    permissions.find { |p| p.key == permission_key }
  end

  def condition_attr_names
    permissions.map(&:conditions).map(&:keys).flatten
  end

  private

  def get_permissions
    permissions = app_keys.map do |app_key|
      get_app_permissions app_key
    end.flatten

    permissions.each_with_index do |permission, index|
      permission.order_index = index
    end
  end

  def get_app_permissions app_key
    resource_keys(app_key).map do |resource_key|
      get_resource_permissions app_key, resource_key
    end.flatten
  end

  def get_resource_permissions app_key, resource_key
    resource = @schema[app_key][resource_key]

    resource[:permissions].map do |p|
      p[:app]           = app_key
      p[:resource]      = "#{app_key}:#{resource_key}"
      p[:key]           = "#{app_key}:#{resource_key}:#{p[:action]}"
      p[:resource_name] = resource[:name]

      Permission.new p
    end
  end

  def app_keys
    @schema.keys
  end

  def resource_keys app_key
    @schema[app_key].keys
  end

  class Permission

    include ActiveModel::Model

    attr_accessor :app,
      :resource,
      :key,
      :resource_name,
      :conditions,
      :action,
      :label,
      :order_index

    def initialize attrs
      assign_attributes attrs
      format_conditions!
    end

    def default_conditions
      conditions.keys.each_with_object({}) do |c, hash|
        option = conditions[c][:options].first
        hash[c] = option[:value]
      end
    end

    private

    def format_conditions!
      @conditions ||= {}
      @conditions.keys.each do |c|
        @conditions[c][:options] = @conditions[c][:options].map do |key, val|
          { value: key, label: val }
        end
      end
    end

  end

end
