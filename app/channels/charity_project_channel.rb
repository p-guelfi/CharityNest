class CharityProjectChannel < ApplicationCable::Channel
  def subscribed
    charity_projects = User.find(params[:id]).donations.map(&:charity_project).uniq
    charity_projects.each do |charity_project|
      stream_for charity_project
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
