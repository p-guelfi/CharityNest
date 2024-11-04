class PaymentsController < ApplicationController
  def new
    @donation = current_user.donations.where(state: 'pending').find(params[:donation_id])
    @charity_project = @donation.charity_project
  end
end
