require './config'

# Initialize the gateway
ap "Initializing the gateway..."
gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(@credentials)

# Existing customer ID for testing
CUSTOMER_ID = "cus_x3r5d8AiG0q2OVbpZdvRdQ"

# List payment instruments
ap "List payment instruments"
response = gateway.list_payment_instruments(CUSTOMER_ID)
ap JSON.parse(response.success?)

ap "Creating payment instrument for customer"
paymentinstrument_data = {
            "type" => "CreditCard",
            "customer_id" => CUSTOMER_ID,
            "client_customer_id" => "1474687",
            "brand" => "Visa",
            "last_four" => "7117",
            "expiration" => "0627"
}
response = gateway.create_paymentinstrument(paymentinstrument_data)
ap response.params  

puts "Deleting the payment instrument..."
response = gateway.delete_paymentinstrument(response.params["id"])