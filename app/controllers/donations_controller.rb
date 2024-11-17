class DonationsController < ApplicationController
  before_action :set_donation, only: %i[show edit update]
  before_action :set_user, only: %i[index new create]
  before_action :set_charity_project, only: %i[new create]
  # before_action :authorize_donation

  def index
    @donations = @user.donations.order(created_at: :desc)
    # get all discussions and reports for the user's charity projects he donated to with an active record query and sort them by creation date in descending order and save in variable @news
    charity_project_ids = @user.donations.map(&:charity_project_id)
    @charity_projects = CharityProject.geocoded.where(id: charity_project_ids)
    discussions = Discussion.where(charity_project_id: charity_project_ids)
    reports = Report.where(charity_project_id: charity_project_ids)
    @news = (discussions + reports).sort_by{ |news| news.created_at }.reverse

    @markers = @charity_projects.map do |charity_project|
      {
        lat: charity_project.latitude,
        lng: charity_project.longitude,
        info_window_html: render_to_string(partial: "charity_projects/info_window", locals: { charity_project: charity_project }),
        marker_html: render_to_string(partial: "charity_projects/marker")
      }
    end

    if params[:payment_status] == 'success'
      flash[:notice] = "Payment successful! Thank you for your donation. Stay tuned for updates on the project: #{ @donations.first.charity_project.name}."
    end
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
      # Define amount based on user input
      amount_cents = @donation.amount.cents
      photo_key = @charity_project.photos.first.key
      cloudinary_url = ENV['CLOUDINARY_URL']
      cloud_name = cloudinary_url.split('@').last
      environment = Rails.env.production? ? "production" : "development"
      # With my cloudinary account in development
      # image_url = "https://res.cloudinary.com/dtbqxujlt/image/upload/c_fill,g_center,h_200,w_300/v1/development/#{photo_key}?_a=BACADKEv"
      # With David's cloudinary account in production
      # image_url = "https://res.cloudinary.com/dztdhys55/image/upload/c_fill,g_center,h_200,w_300/v1/production/#{photo_key}?_a=BACADKEv"
      # Dynamic:
      image_url = "https://res.cloudinary.com/#{cloud_name}/image/upload/c_fill,g_center,h_200,w_300/v1/#{environment}/#{photo_key}?_a=BACADKEv"

      # Initialize session options
      session_options = {
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            currency: 'eur',
            product_data: {
              name: "Donation to #{@charity_project.name}",
              images: image_url ? [image_url] : []
            },
            unit_amount: amount_cents,
            # Add recurring options only if the donation is recurrent
            recurring: @donation.recurrent ? { interval: 'month' } : nil,
          },
          quantity: 1
        }],
        mode: @donation.recurrent ? 'subscription' : 'payment', # Use subscription mode if recurrent
        success_url: donations_url(payment_status: 'success'),
        cancel_url: new_donation_payment_url(@donation)
      }

      # Create a Stripe Checkout session
      session = Stripe::Checkout::Session.create(session_options)

      @donation.update(checkout_session_id: session.id)
      redirect_to new_donation_payment_path(@donation)
    else
      flash[:alert] = "Something went wrong while creating your donation. Please try again."
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

  def unsubscribe
    @donation = Donation.find(params[:id])
    if @donation.destroy
      redirect_to donations_path, notice: 'You have successfully unsubscribed from this donation.'
    else
      redirect_to donation_path(@donation), alert: 'Failed to unsubscribe from the donation.'
    end
  end

end
