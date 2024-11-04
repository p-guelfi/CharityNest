class StripeCheckoutSessionService
  def call(event)
    # Log the incoming event for debugging
    Rails.logger.info "Received event: #{event.inspect}"

    # Find the donation based on the checkout session ID
    donation = Donation.find_by(checkout_session_id: event.data.object.id)

    # Check if the donation exists
    if donation
      # Update the state to 'paid'
      if donation.update(state: 'paid')
        Rails.logger.info "Donation updated successfully: #{donation.inspect}"
      else
        Rails.logger.error "Failed to update donation: #{donation.errors.full_messages.join(", ")}"
      end
    else
      Rails.logger.error "No donation found with checkout_session_id: #{event.data.object.id}"
    end
  end
end
