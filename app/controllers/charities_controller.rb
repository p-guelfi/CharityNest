class CharitiesController < ApplicationController
  def index
    if set_category
      @charities = Charity.where(category: @category)
    else
      @charities = Charity.all
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
end
