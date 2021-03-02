ENV['RAILS_ENV'] ||= 'test'
require_relative '../../config/environment'
require 'awesome_print'

ActiveMerchant::Billing::Base.mode = :test


if ENV['DEBUG_ACTIVE_MERCHANT'] == 'true'
    require 'logger'
    ActiveMerchant::Billing::Gateway.logger = Logger.new(STDOUT)
    ActiveMerchant::Billing::Gateway.wiredump_device = STDOUT
  end

@credentials = {
    :publishable_api_key => '-----', 
    :app_id => '-----', 
    :shared_secret => '-----', 
    :sandbox => true
}

def credit_card_gp(number)
    creditcard = {}
    creditcard[:number] = number # "4847182731147117"
    creditcard[:expiration] = "0627"
    creditcard[:cvv] = "361"
    creditcard
end
  
def address(options = {})
{
    name:     'Jim Smith',
    address1: '456 My Street',
    address2: 'Apt 1',
    company:  'Widgets Inc',
    city:     'Ottawa',
    state:    'ON',
    zip:      'K1C2N6',
    country:  'CA',
    phone:    '(555)555-5555',
    fax:      '(555)555-6666'
}.update(options)
end
  
def billing_contact
    billing_contact = {}
    billing_contact[:first_name] = "Jim"
    billing_contact[:last_name] = "Smith"
    billing_contact[:address] = address
    billing_contact[:phone] = "070261666"
    billing_contact[:email] = "jim.smith@gmail.com"
    billing_contact
end
  
@token_customer_data = {
    billing_contact: billing_contact
}

@customer_data = {
    billing_contact: billing_contact
}

@charge_customer_data = {
    client_customer_id: "1474687",
    client_transaction_id: "154896575",
    client_transaction_description: "Charge With Token from Ruby",
    client_invoice_id: "758496",
    currency_code: "USD",
    country_code: "US",
    cof_type: "UNSCHEDULED_CARDHOLDER",
    save_payment_instrument: false,
    avs: false
}

  # credit_card = ActiveMerchant::Billing::CreditCard.new(
#     :first_name         => 'Bob',
#     :last_name          => 'Bobsen',
#     :number             => '4242424242424242',
#     :month              => '8',
#     :year               => Time.now.year+1,
#     :verification_value => '000')  