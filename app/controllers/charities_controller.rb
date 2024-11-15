class CharitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    set_sorting
    if set_category
      @charities = Charity.where(category: @category)
    else
      @charities = Charity.all
    end
    if @sorting == "name"
      @charities = @charities.order(:name)
    elsif @sorting == "score"
      @charities = @charities.sort_by{ |charity| -charity.score }
    else
      @charities
    end
  end

  def show
    @charity = Charity.find(params[:id])
    @charity_projects = @charity.charity_projects.includes(:donations)

    # Build the markers array for the charity's projects
    @markers = @charity_projects.geocoded.map do |project|
      {
        lat: project.latitude,
        lng: project.longitude,
        info_window_html: render_to_string(partial: "charity_projects/info_window", locals: {charity_project: project}),
        marker_html: render_to_string(partial: "charity_projects/marker")
      }
    end
  end

  private

  def charity_params
    params.require(:charity).permit(:name, :description, :category_id)
  end

  def set_charity
    @charity = Charity.find(params[:id])
  end

  def set_category
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
    end
  end

  def set_sorting
    if params[:sort_by].present?
      @sorting = params[:sort_by]
    end
  end

end
