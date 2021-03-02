require './my_config'

# Initialize the gateway
ap "Initializing the gateway..."
gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(@credentials)

# payment = 'card_Q2Bzx5VWn0e7pkdN-ZHrRw'
payment = 'tok_WfyI3AXK_E2id1p3GlIJ9g'
ap "Payment: " + payment

ap "Calling Purchase..."
response = gateway.purchase(99, payment, @charge_customer_data)

ap "Purchase Response: "
ap response