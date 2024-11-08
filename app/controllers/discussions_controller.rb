class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_charity_project
  before_action :authorize_user_access, only: [:index, :show, :new, :create]

  def index
    @discussions = @charity_project.discussions
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def new
    @discussion = @charity_project.discussions.build
  end

  def create
    @discussion = @charity_project.discussions.build(discussion_params)
    @discussion.user = current_user
    if @discussion.save
      redirect_to charity_project_discussions_path(@charity_project), notice: 'Discussion created successfully.'
    else
      render :new
    end
  end

  def edit
    @discussion = current_user.discussions.find(params[:id])
  end

  def update
    @discussion = current_user.discussions.find(params[:id])
    if @discussion.update(discussion_params)
      redirect_to charity_project_discussion_path(@charity_project, @discussion), notice: 'Discussion updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @discussion = current_user.discussions.find(params[:id])
    @discussion.destroy
    redirect_to charity_project_discussions_path(@charity_project), notice: 'Discussion deleted.'
  end

  private

  def set_charity_project
    @charity_project = CharityProject.find(params[:charity_project_id])
  end

  def authorize_user_access
    # Ensure the user has donated to this charity project
    unless current_user.donations.exists?(charity_project_id: @charity_project.id)
      redirect_to root_path, alert: 'You must donate to access this forum.'
    end
  end

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end
end
