require './my_config'

# Initialize the gateway
ap "Initializing the gateway..."
gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(@credentials)

# payment = 'card_Q2Bzx5VWn0e7pkdN-ZHrRw'
payment = 'tok_WfyI3AXK_E2id1p3GlIJ9g'
ap "Payment: " + payment

ap "Calling Authorize..."
auth_response = gateway.authorize(123, token_id, @charge_customer_data)

ap "Authorize Response: "
ap auth_response

ap "Authorization: "
ap auth_response.authorization

ap "Calling capture..."
capture_response = gateway.capture(123, auth_response.authorization)

ap "Capture Response: "
ap capture_response

