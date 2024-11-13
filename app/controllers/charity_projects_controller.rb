class CharityProjectsController < ApplicationController

  def index
    if params[:query].present?
      @charity_projects = CharityProject.global_search(params[:query])
    else
      @charity_projects = CharityProject.all
    end

    @markers = @charity_projects.geocoded.map do |charity_project|
      {
        lat: charity_project.latitude,
        lng: charity_project.longitude
      }
    end
  end

  def show
    @charity_project = CharityProject.find(params[:id])
    @markers = [{
      lat: @charity_project.latitude,
      lng: @charity_project.longitude
    }]
  end
end
