class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy place_order ]
  before_action :set_form_vars, only: [:new, :edit]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]


  # GET /listings or /listings.json
  def index
    case params[:condition]
    when "well_used"
      listings = Listing.well_used
    when "barely_used"
      listings = Listing.barely_used
    when "almost_new"
      listings = Listing.almost_new
    when "brand_new"
      listings = Listing.brand_new
    else
      listings = Listing.all
    end  

    @listings = listings.order(params[:sort])
  end

  def search
    if params[:search].blank?
      redirect_to listings_path and return
    else
      @query = params[:search].downcase
      @search_results = Listing.all.where("lower(title) LIKE :search", search: "%#{@query}%")
    end
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def place_order
    Order.create(
      listing_id: @listing.id,
      seller_id: @listing.user_id,
      buyer_id: current_user.id
    )

    @listing.update(sold: true)

    redirect_to orders_success_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def set_form_vars
      @categories = Category.all
  		@conditions = Listing.conditions.keys
    end

    def authorize_user 
      if @listing.user_id != current_user.id
        flash[:alert] = "You don't have permission to do that"
        redirect_to listings_path
      end 
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:title, :description, :condition, :price, :sold, :user_id, :category_id, :picture)
    end
end
