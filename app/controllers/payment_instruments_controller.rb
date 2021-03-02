class PaymentInstrumentsController < ApplicationController
  before_action :set_payment_instrument, only: [:show, :edit, :update, :destroy]

  # GET /payment_instruments
  # GET /payment_instruments.json
  def index    

    result = @gateway.list_payment_instruments(@customer_id)
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
    @options[:billing_contact][:first_name] = payment_instrument_params[:first_name]
    @options[:billing_contact][:last_name] = payment_instrument_params[:last_name]

    paymentinstrument_data = {
      "type" => payment_instrument_params[:type],
      "customer_id" => payment_instrument_params[:customer_id],
      "client_customer_id" => @options[:client_customer_id],
      "creditcard" => credit_card_gp(payment_instrument_params[:credit_card_number]),
      "billing_contact" => @options[:billing_contact]
    }
    @gateway.create_paymentinstrument(paymentinstrument_data)
    
    respond_to do |format|
      format.html { redirect_to payment_instruments_url, notice: 'PaymentInstrument was successfully created.' }
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
      params.require(:payment_instrument).permit(:type, :customer_id, :credit_card_number, :first_name, :last_name)
    end
end
