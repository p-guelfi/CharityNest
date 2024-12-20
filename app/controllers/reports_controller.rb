class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update]
  before_action :set_charity_project, only: %i[new create]

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.charity_project = @charity_project
    @report.user = set_user
    if @report.save
      CharityProjectChannel.broadcast_to(@report.charity_project,
        render_to_string(partial: "reports/card_report_teaser",
          locals: { report: @report }))
      flash[:notice] = "Your report has been created successfully."
      redirect_to report_path(@report)
    else
      flash[:alert] = "Something went wrong while creating your report. Please try again."
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def index
    if set_charity_project
      @reports = @charity_project.reports.all
    else
      @reports = Report.all
    end
  end

  def edit
  end

  def update
    if @report.update(report_params)
      redirect_to report_path(@report)
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def report_params
    params.require(:report).permit(
      :title,
      :teaser,
      :body,
      :type,
      :report_type,
      :score,
      :score_impact,
      :score_communication,
      :score_efficiency,
      :score_adaptability,
      photos: [])
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def set_user
    if user_signed_in?
      @user = current_user
    else
      redirect_to new_user_session_path
    end
  end

  def set_charity_project
    if params[:charity_project_id].present?
      @charity_project = CharityProject.find(params[:charity_project_id])
    end
  end
end
