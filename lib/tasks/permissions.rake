namespace :permissions do

  desc 'Permissions initial setup'
  task :seed => :environment do
    permissions = YAML::load_file(File.join(Rails.root, '/config/permissions_schema.yml')).with_indifferent_access
    permissions.each_pair do |k,p|
      Permission.create(key: k, allowed: true, conditions: p[:conditions])
    end
  end
end