require './config'

# Initialize the gateway
puts "Initializing the gateway..."
gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(@credentials)

credit_card = credit_card_gp('4000100011112224')

ap "Authorizing..."
auth = gateway.authorize(500, credit_card, @customer_data)
ap auth.params

ap "Calling capture..."
response = gateway.capture(500, auth.authorization)
ap response.params

