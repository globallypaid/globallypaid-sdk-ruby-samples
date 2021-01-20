ENV['RAILS_ENV'] ||= 'test'
require_relative '../../config/environment'
require './config'

ActiveMerchant::Billing::Gateway.logger = Logger.new(STDOUT)
ActiveMerchant::Billing::Gateway.wiredump_device = STDOUT

# Initialize the gateway
puts "Initializing the gateway..."
gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(@credentials)
  
credit_card = credit_card_gp('4000100011112224')

puts "Calling charge..."
response = gateway.charge(123, credit_card, @customer_data)

puts "Response: " + response.inspect