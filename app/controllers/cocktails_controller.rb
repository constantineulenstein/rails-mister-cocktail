class CocktailsController < ApplicationController

  def index
    if params[:search].nil?
      @cocktails = Cocktail.all
    else
      @cocktails = Cocktail.where("name LIKE ?", "%#{params[:search][:query]}%")
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail.id)
    else
      render :new
    end
  end


  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :photo)
  end
end
