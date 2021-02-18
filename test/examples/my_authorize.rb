require './my_config'

# Initialize the gateway
ap "Initializing the gateway..."
gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(@credentials)

# payment = 'card_Q2Bzx5VWn0e7pkdN-ZHrRw'
payment = 'tok_WfyI3AXK_E2id1p3GlIJ9g'
ap "Payment: " + payment

ap "Calling Authorize..."
response = gateway.authorize(123, payment, @charge_customer_data)

ap "Authorize Response: "
ap response