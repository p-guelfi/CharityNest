class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion

  def create
    @comment = @discussion.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to charity_project_discussion_path(@discussion.charity_project, @discussion), notice: 'Comment added.'
    else
      redirect_to charity_project_discussion_path(@discussion.charity_project, @discussion), alert: 'Failed to add comment.'
    end
  end

  private

  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
