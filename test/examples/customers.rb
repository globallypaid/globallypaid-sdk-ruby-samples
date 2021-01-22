require './config'

# Initialize the gateway
ap "Initializing the gateway..."
gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(@credentials)
  
ap "Calling customer list..."
response = gateway.list_customers()

puts "Response: "

ap JSON.parse(response.success?)

ap "Creating new customer..."
customer_data = {
    'client_customer_id' => '1474777',
    'first_name' => 'Peco',
    'last_name' => 'Danajlovski'
  }
response = gateway.create_customer(customer_data)
ap response.params

ap "Deleting the customer..."
customer_id = response.params["id"]

response = gateway.delete_customer(customer_id)
ap response.params