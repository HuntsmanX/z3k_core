namespace :forms do

  desc 'Recalculates counter cache fields'
  task :recalculate_cache => :environment do
    Forms::Test.all.each &:recalculate_max_score!

    Forms::Response.all.each &:recalculate_scores!
    Forms::Response.all.each &:recalculate_checked!

    Forms::Response::Section.all.each &:recalculate_successful!

    Forms::Test.all.each do |t|
      Forms::Test.reset_counters(t.id, :sections)
    end

    Forms::Test::Section.all.each do |s|
      Forms::Test::Section.reset_counters(s.id, :questions)
    end

    Forms::Response.all.each do |r|
      Forms::Response.reset_counters(r.id, :sections)
    end
  end

end
