class CocktailsController < ApplicationController

  def index
    @spirits = {gin: "https://images.unsplash.com/photo-1484132368430-ca5c967b425b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1932&q=80", vodka: "https://images.unsplash.com/photo-1516758288207-e9059e0b3b3f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3151&q=80", tequila: "https://images.unsplash.com/photo-1522128483605-23607c944cbb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1949&q=80", rum: "https://images.unsplash.com/photo-1505739817823-dcf70eb5a3f7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80", whiskey: "https://images.unsplash.com/photo-1508253730651-e5ace80a7025?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80", vermouth: "https://images.unsplash.com/photo-1542848802-92864b33761c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1947&q=80", brandy: "https://images.unsplash.com/photo-1557515527-269958c615de?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80", all: "https://images.unsplash.com/photo-1482112048165-dd23f81c367d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80"}

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

  def specify
    if params[:background].nil?
      @background = "https://images.unsplash.com/photo-1482112048165-dd23f81c367d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80"
      @cocktails = Cocktail.joins(:ingredients).where("ingredients.name ILIKE ? OR cocktails.name ILIKE ?", "%#{params[:search][:query]}%", "%#{params[:search][:query]}%").uniq
    else
      @background = params[:background]
      if params[:spirit] == "all"
        @cocktails = Cocktail.all
      else
        @cocktails = Cocktail.joins(:ingredients).where("ingredients.name ILIKE ?", "%#{params[:spirit]}%").uniq
      end
    end
  end


  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :photo)
  end
end
