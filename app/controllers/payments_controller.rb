class PaymentsController < ApplicationController

  # We are not using session data so it's safe to skip authenticity checks
  skip_forgery_protection

  def index
    ap "index..."
    # auth = @gateway.authorize(@amount, @credit_card, @options)
    # @gateway.capture(@amount, auth.authorization)
  end

  def create
    ap "Create puechase. Payment..." + params["id"]
    response = @gateway.purchase(123, params["id"], @charge_customer_data)
    
    puts "Response: #{response.inspect}"

    render :json => response.message
  end

end
