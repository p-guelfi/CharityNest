class CharityProjectsController < ApplicationController
  def index
    if params[:query].present?
      @charity_projects = CharityProject.global_search(params[:query])
    else
      @charity_projects = CharityProject.all
    end
  end

  def show
  end
end
