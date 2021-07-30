Beaneater.configure do |config|
  config.beanstalkd_url = "localhost:11300"
end

Backburner.configure do |config|
  config.respond_timeout = 1800
  config.beanstalk_url = "beanstalk://#{Beaneater.configuration.beanstalkd_url}"
end
