class Forms::Config::MistakeType < ApplicationRecord
  self.table_name = 'forms_config_mistake_types'

  validates :name,    presence: true, length: { maximum: 255 }
  validates :color,   presence: true, length: { maximum: 255 }
  validates :penalty, presence: true
end
