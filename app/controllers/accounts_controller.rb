class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  layout 'devise'

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
    # @account.users.build # build a blank user or the child form won't display
    @account_types = AccountType.all
    @account_default = params[:plan].nil? ? '' : params[:plan]

    render layout: 'devise'
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    # set up Stripe session
    Stripe.api_key = YAML.load_file("#{Rails.root}/config/stripe.yml")[Rails.env][:secret_key]

    @account_type = AccountType.find params[:account_type_id]
    @account      = Account.new({ :account_type_id => @account_type.id, name: account_params[:name] })

    user = User.new(user_params)
    unless user.valid?
      flash[:notice] = 'User invalid'
      render :new
      return
    end

    # Get the credit card details submitted by the form
    token    = params[:stripeToken]
    customer = create_stripe_customer(token, user.email)

    @account.stripe_customer_id = customer.id

    begin
      # Create the charge on Stripe's servers - this will charge the user's card
      subscription = customer.subscriptions.create(:plan => @account_type.stripe_subscription_plan)
      @account.recurrence_at = Time.at(subscription.start.to_i).utc.strftime('%d')

    rescue Exception => e
      # The card has been declined
      flash[:notice] = e.message
      render :new
      return
    end

    respond_to do |format|
      begin
        @account.save
        user.save
        AccountUser.create({ :account_id => @account.id, :user_id => user.id })

        format.html { redirect_to confirm_email_path, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      rescue Exception => e
        flash[:notice] = e.message
        format.html { render :new }
        format.json { render json: e.message, status: :unprocessable_entity }
      end
    end
    # respond_to do |format|
    #   if @account.save
    #     if user.save
    #       AccountUser.create({ :account_id => @account.id, :user_id => user.id })
    #     else
    #       format.html { render :new }
    #       format.json { render json: user.errors, status: :unprocessable_entity }
    #     end
    #     format.html { redirect_to confirm_email_path, notice: 'Account was successfully created.' }
    #     format.json { render :show, status: :created, location: @account }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @account.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    # do nothing
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit!
  end

  def user_params
    params.require(:account).permit(:user => [ :full_name, :email, :password, :password_confirmation ])[:user]
  end

  def create_stripe_customer(token, email)
    Stripe::Customer.create({ :card => token, :description => email })
  end

  def create_stripe_charge(price, customer_id)
    Stripe::Charge.create({
        :amount => price,
        :currency => 'usd',
        :customer => customer_id
    })
  end
end
