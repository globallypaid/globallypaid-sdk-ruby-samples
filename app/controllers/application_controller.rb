require 'active_merchant'
class ApplicationController < ActionController::Base

    before_action :load_gateway

    private

    def load_gateway
        @gateway = ActiveMerchant::Billing::GloballyPaidGateway.new(
            publishable_api_key: '------',
            app_id: '------',
            shared_secret: '------',
            sandbox: true            
        )
        @amount = 99
        @valid_credit_card_number = '41111111111111'
        @credit_card = credit_card_gp(@valid_credit_card_number)
        @declined_card = credit_card_gp('4000300011112220')
        @options = {
          billing_contact: billing_contact,
          # address: address,
          description: 'Store Purchase',
          client_customer_id: "1474687",
          client_transaction_id: "154896575",
          client_transaction_description: "ChargeWithToken for TesterXXX3",
          client_invoice_id: "758496",
          currency_code: "USD"
        }
        @customer_id = 'cus_urYNN2Zk0kehHLmilAasFA'
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
    end

    def billing_contact
        billing_contact = {}
        billing_contact[:first_name] = "Joe"
        billing_contact[:last_name] = "Doe"
        billing_contact[:address] = address
        billing_contact[:phone] = "070261666"
        billing_contact[:email] = "joe.doe@gmail.com"
        billing_contact
      end
    
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

end
