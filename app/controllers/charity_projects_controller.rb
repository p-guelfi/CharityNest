class CharityProjectsController < ApplicationController
  def index
    @charity_projects = CharityProject.all
  end
end
