class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_donation_and_discussion

  def create
    @comment = @discussion.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to donation_discussion_path(@donation, @discussion), notice: 'Comment added successfully.'
    else
      redirect_to donation_discussion_path(@donation, @discussion), alert: 'Failed to add comment.'
    end
  end

  def destroy
    @donation = Donation.find(params[:donation_id])
    @discussion = @donation.discussions.find(params[:discussion_id])
    @comment = @discussion.comments.find(params[:id])
    @comment.destroy
    redirect_to donation_discussion_path(@donation, @discussion), notice: 'Comment was successfully deleted.'
  end


  private

  def set_donation_and_discussion
    @donation = Donation.find(params[:donation_id])
    @discussion = @donation.discussions.find(params[:discussion_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
