class CharityProjectsController < ApplicationController

  def index
    if params[:query].present?
      @charity_projects = CharityProject.global_search(params[:query])
      redirect_to charity_projects_path(query: nil) and return
    else
      @charity_projects = CharityProject.all
    end

    sort_by = params[:sort_by]
    order = params[:order] == "desc" ? :desc : :asc

    case sort_by
    when 'name'
      @charity_projects = @charity_projects.order(name: order)
    when 'location'
      @charity_projects = @charity_projects.order(location: order)
    when 'goal'
      @charity_projects = @charity_projects.order(goal: order)
    end

    # Set a variable to toggle sort order
    @next_order = order == :asc ? "desc" : "asc"
  end

  def show
  end
end
