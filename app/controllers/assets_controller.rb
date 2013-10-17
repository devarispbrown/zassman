class AssetsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :search]
  # GET /assets
  # GET /assets.json
  def index
    if params[:tag]
      @assets = Asset.tagged_with(params[:tag]).page(params[:page]).per_page(15)
    else
      @assets = Asset.order("created_at desc").page(params[:page]).per_page(15)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assets }
      format.js
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.json
  def new
    @asset = current_user.assets.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = current_user.assets.find(params[:id])
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = current_user.assets.new(params[:asset])

    respond_to do |format|
      if @asset.save
        track_activity @asset
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        format.json { render json: @asset, status: :created, location: @asset }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.json
  def update
    @asset = current_user.assets.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        track_activity @asset
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset = current_user.assets.find(params[:id])
    @asset.destroy
    track_activity @asset

    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end

  def search
    # if params[:q]
    # query = params[:q]
    # @search = Asset.search do
    # fulltext query
    # end
    # @search_results = @search.results
    # end

    if params[:q].present?
      @search_results = Asset.search(params[:q], page: params[:page])
    else
      @search_results = Asset.all.page params[:page]
    end
  end
end