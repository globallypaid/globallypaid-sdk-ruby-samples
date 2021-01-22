require './config'

# Initialize the gateway
ap "Initializing the gateway..."
gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(@credentials)
  
credit_card = credit_card_gp('4000100011112224')

ap "Calling charge..."
response = gateway.charge(123, credit_card, @customer_data)

ap "Response: "
ap response.params