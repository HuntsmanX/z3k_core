require 'csv'

#Cities
City.find_or_create_by(name: 'Kharkiv', locale: 'RU', timezone: 'Europe/Kiev')
City.find_or_create_by(name: 'Lviv', locale: 'RU', timezone: 'Europe/Kiev')
City.find_or_create_by(name: 'Coimbatore', locale: 'EN', timezone: 'Asia/Kolkata')

CSV.parse(File.read('lib/import_data/transliterations.csv'), headers: true).each { |row| Transliteration.find_or_create_by(row.to_h) }
