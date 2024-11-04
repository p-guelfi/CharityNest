class CharitiesController < ApplicationController
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
