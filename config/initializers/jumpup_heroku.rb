Jumpup::Heroku.configure do |config|
  config.app = 'greymane'
end if Rails.env.development?
