require './config'


# Initialize the gateway
ap "Initializing the gateway..."
gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(@credentials)
  
credit_card = credit_card_gp('4000100011112224')

ap "Calling authorization..."
auth = gateway.authorize(1000, credit_card, @customer_data)

ap "Calling refund..."
response = gateway.refund(1000, auth.authorization)
ap "Response: " 
ap response.params