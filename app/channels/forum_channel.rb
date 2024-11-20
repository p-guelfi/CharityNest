class ForumChannel < ApplicationCable::Channel
  def subscribed
    discussions = User.find(params[:id]).discussions
    discussions.each do |discussion|
      stream_for discussion
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
