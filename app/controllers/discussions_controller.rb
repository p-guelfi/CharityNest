class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_charity_project
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]

  def index
    @discussions = @charity_project.discussions
  end

  def show
    @comment = @discussion.comments.build
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
  end

  def update
    if @discussion.update(discussion_params)
      redirect_to charity_project_discussion_path(@charity_project, @discussion), notice: 'Discussion updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @discussion.destroy
    redirect_to charity_project_discussions_path(@charity_project), notice: 'Discussion deleted.'
  end

  private

  def set_charity_project
    if params[:charity_project_id].present?
      @charity_project = CharityProject.find(params[:charity_project_id])
    end
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
    redirect_to charity_project_discussions_path(@charity_project), alert: 'Discussion not found' if @discussion.nil?
  end

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end
end
