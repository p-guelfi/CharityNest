class CharityProjectsController < ApplicationController
  def index
    @charity_projects = CharityProject.all
  end

  def show
  end
end
