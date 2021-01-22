class PaymentInstrumentsController < ApplicationController
  before_action :set_payment_instrument, only: [:show, :edit, :update, :destroy]

  # GET /payment_instruments
  # GET /payment_instruments.json
  def index    

    result = @gateway.list_payment_instruments('cus_x3r5d8AiG0q2OVbpZdvRdQ')
    @payment_instruments = JSON.parse(result.success?)
  end


  # GET /payment_instruments/1
  # GET /payment_instruments/1.json
  def show
  end

  # GET /payment_instruments/new
  def new
    result = @gateway.list_customers
    @customers = JSON.parse(result.success?)      
    @payment_instrument = PaymentInstrument.new
  end

  # GET /payment_instruments/1/edit
  def edit
  end

  # POST /payment_instruments
  # POST /payment_instruments.json
  def create
    @payment_instrument = PaymentInstrument.new(payment_instrument_params)

    paymentinstrument_data = {
      "type" => "CreditCard",
      "customer_id" => "cus_gHJuy8OR1UGrIfuyyvmyHQ	",
      "client_customer_id" => "1474687",
      "brand" => "Visa",
      "last_four" => "7117",
      "expiration" => "0627",
      "creditcard" => credit_card_gp(4111111111111111),
      "billing_contact" => {
          "first_name" => "Test",
           "last_name" => "Tester",
             "address" => {
                       "line_1" => "123 Main St",
                       "line_2" => nil,
                         "city" => "NYC",
                        "state" => "NY",
                  "postal_code" => "92657",
                      "country" => "United States"
          }
      }
  }
  gateway.create_paymentinstrument(paymentinstrument_data)

    respond_to do |format|
      if @payment_instrument.save
        format.html { redirect_to @payment_instrument, notice: 'Payment instrument was successfully created.' }
        format.json { render :show, status: :created, location: @payment_instrument }
      else
        format.html { render :new }
        format.json { render json: @payment_instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_instruments/1
  # PATCH/PUT /payment_instruments/1.json
  def update
    respond_to do |format|
      if @payment_instrument.update(payment_instrument_params)
        format.html { redirect_to @payment_instrument, notice: 'Payment instrument was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_instrument }
      else
        format.html { render :edit }
        format.json { render json: @payment_instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_instruments/1
  # DELETE /payment_instruments/1.json
  def destroy
    @payment_instrument.destroy
    respond_to do |format|
      format.html { redirect_to payment_instruments_url, notice: 'Payment instrument was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_instrument
      @payment_instrument = PaymentInstrument.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_instrument_params
      params.require(:payment_instrument).permit(:type, :client_id, :customer_id, :billing_contact)
    end
end
