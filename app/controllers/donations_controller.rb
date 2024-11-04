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

  def create
    @donation = Donation.new(donation_params)
    @donation.user = @user
    @donation.charity_project = @charity_project

    if @donation.save
      redirect_to donation_path(@donation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
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

  def unsubscribe
    @donation = Donation.find(params[:id])
    if @donation.destroy
      redirect_to donations_path, notice: 'You have successfully unsubscribed from this donation.'
    else
      redirect_to donation_path(@donation), alert: 'Failed to unsubscribe from the donation.'
    end
  end

end
