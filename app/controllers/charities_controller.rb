class CharitiesController < ApplicationController

  def show
    @charity = Charity.find(params[:id])
    @charity_projects = @charity.charity_projects.includes(:donations)
  end
end
