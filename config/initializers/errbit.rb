Airbrake.configure do |config|
  config.api_key = 'a2fc9e70201da9acd0cb1561959e22fc'
  config.host    = 'errbit.genesys.shefcompsci.org.uk'
  config.port    = 443
  config.secure  = config.port == 443
end