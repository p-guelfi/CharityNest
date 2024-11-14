class CharitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if set_category
      if set_sorting
        @charities = Charity.where(category: @category).order(@sorting)
      else
        @charities = Charity.where(category: @category)
      end
    else
      if set_sorting
        @charities = Charity.all.order(@sorting)
      else
        @charities = Charity.all
      end
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
      @sorting = params[:sort_by].to_sym
    end
  end

end
