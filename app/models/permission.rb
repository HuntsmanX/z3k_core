class Permission < ApplicationRecord

  belongs_to :role

  def self.get_schema
    YAML::load_file(File.join(Rails.root, '/config/permissions_schema.yml')).with_indifferent_access
  end

  def method_missing name, *args
    self.send('conditions').try(:[], name.to_s) if name.to_s.split('_')[0] == 'conditions'
  end

end
