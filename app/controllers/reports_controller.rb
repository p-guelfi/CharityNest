class ReportsController < ApplicationController
  def new
    @report = Report.new
    set_charity_project
  end

  def create
    @report = Report.new(report_params)
    @report.charity_project = @charity_project
    @report.user = set_user
    if @report.save
      flash[:notice] = "Your report has been created successfully."
      redirect_to charity_project_path(@charity_project)
    else
      flash[:alert] = "Something went wrong while creating your report. Please try again."
      render :new, status: :unprocessable_entity
    end
  end


  private

  def report_params
    params.require(:report).permit(:title, :teaser, :body, :type )
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
end
