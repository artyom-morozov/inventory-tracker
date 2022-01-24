class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: %i[ edit update destroy ]
  # GET /items or /items.json
  def index
    if params[:id]
      @item_user = User.all.find(params[:id])
      @items = @item_user.items
    # elsif params[:search]
    #   @items = Item.search(params[:search])
    elsif params[:category]
      @category = Category.all.find(params[:category])
      @items = @category.items
    else
      @items = Item.all
    end
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, notice: "Empty search field!") and return  
    else
      @parameter = params[:search].downcase  
      @results = Item.where("lower(title) LIKE :search OR lower(description) LIKE :search", search: "%#{@parameter}%")
    end
  end

  # GET /items/1 or /items/1.json
  def show
    @photo = @item.photo.variant(resize_to_fit: [500, 500], saver: { quality: 1 }).blob
  end

  # GET /items/new
  def new
    @item = current_user.items.build
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    # @item = Item.new(item_params)
    @item = current_user.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #  Make sure correct user is logged in
  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    redirect_to items_path, notice: "Not authorize to edit this item" if @item.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:title, :price, :search,  :user_id, :count, :photo, :description, category_ids: [])
    end
end
