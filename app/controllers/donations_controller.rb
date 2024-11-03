class DonationsController < ApplicationController
  before_action :set_donation, only: %i[show edit update]
  before_action :set_user, only: %i[index new create]
  before_action :set_charity_project, only: %i[new create]
  # before_action :authorize_donation

  def index
    @donations = @user.donations
  end

  def new
    @donation = Donation.new
  end

  # def create
  #   @donation = Donation.new(donation_params)
  #   @donation.user = @user
  #   @donation.charity_project = @charity_project

  #   if @donation.save
  #     redirect_to donation_path(@donation)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create
    @donation = Donation.new(donation_params)
    @donation.user = current_user
    @donation.charity_project = @charity_project
    @donation.state = 'pending' # Set the state to pending

    if @donation.save
      # Create a Stripe Checkout session
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            currency: 'eur',
            product_data: {
              name: "Donation to #{@charity_project.name}",
            },
            unit_amount: @donation.amount_cents,
          },
          quantity: 1
        }],
        mode: 'payment', # This line is important
        success_url: donation_url(@donation),
        cancel_url: new_donation_payment_url(@donation)
      )

      # Update the donation with the checkout session ID
      @donation.update(checkout_session_id: session.id)
      redirect_to new_donation_payment_path(@donation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @donation = current_user.donations.find(params[:id])
    @charity_project = @donation.charity_project
  end

  def edit
  end

  def update
    if @donation.update(donation_params)
      redirect_to donation_path(@donation)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:amount, :recurrent)
  end

  def set_donation
    @donation = Donation.find(params[:id])
  end

  def set_user
    if user_signed_in?
      @user = current_user
    else
      redirect_to new_user_session_path
    end
  end

  def set_charity_project
    @charity_project = CharityProject.find(params[:charity_project_id])
  end

  def authorize_donation
    authorize @donation
  end
end
