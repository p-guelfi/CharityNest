class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :cookies, :privacy, :impressum]

  def home
    @categories = Category.all
  end

# app/controllers/pages_controller.rb
  def about
  end
end
