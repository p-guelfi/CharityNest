class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_donation
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user_access, only: [:index, :show, :new, :create]

  def index
    @discussions = @donation.discussions
  end

  def show
    @comment = @discussion.comments.build
  end

  def new
    @discussion = @donation.discussions.build
  end

  def create
    @discussion = @donation.discussions.build(discussion_params)
    @discussion.user = current_user
    if @discussion.save
      redirect_to donation_discussions_path(@donation), notice: 'Discussion created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @discussion.update(discussion_params)
      redirect_to donation_discussion_path(@donation, @discussion), notice: 'Discussion updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @discussion.destroy
    redirect_to donation_discussions_path(@donation), notice: 'Discussion deleted.'
  end

  private

  def set_donation
    @donation = Donation.find(params[:donation_id])
  end

  def set_discussion
    @discussion = @donation.discussions.find_by(id: params[:id])
    redirect_to donation_discussions_path(@donation), alert: 'Discussion not found' if @discussion.nil?
  end

  def authorize_user_access
    # Ensure the user owns the donation
    unless current_user == @donation.user
      redirect_to root_path, alert: 'You can only access discussions for your donations.'
    end
  end

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end
end
