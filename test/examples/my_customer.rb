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
    'first_name' => 'Joe',
    'last_name' => 'Doe'
  }
response_create_cutomer = gateway.create_customer(customer_data)
ap response_create_cutomer

customer_id = response_create_cutomer.params["id"]
puts "CustomerId: "
ap customer_id

ap "Get the customer..."
response = gateway.get_customer(customer_id)
ap JSON.parse(response)

ap "Update customer..."
customer_data = {
    'client_customer_id' => '1474777',
    'first_name' => 'Joe_Updated',
    'last_name' => 'Doe_Updated'
  }
response_update_customer = gateway.update_customer(customer_id, customer_data)
ap response_update_customer

ap "Delete the customer..."
response_delete_customer = gateway.delete_customer('cus_0G8v0pu87EOZjKbraOpfQA')
ap response_delete_customer

