# You must create the SETTINGS
class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env
end