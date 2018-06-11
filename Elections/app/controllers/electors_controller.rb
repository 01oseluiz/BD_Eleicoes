class ElectorsController < ApplicationController
  before_action :set_elector, only: [:show, :edit, :update, :destroy]

  # GET /electors
  # GET /electors.json
  def index
    @electors = Elector.all
  end

  # GET /electors/1
  # GET /electors/1.json
  def show
  end

  # GET /electors/new
  def new
    @elector = Elector.new
  end

  # GET /electors/1/edit
  def edit
  end

  # POST /electors
  # POST /electors.json
  def create
    @elector = Elector.new(elector_params)

    respond_to do |format|
      if @elector.save
        format.html { redirect_to @elector, notice: 'Elector was successfully created.' }
        format.json { render :show, status: :created, location: @elector }
      else
        format.html { render :new }
        format.json { render json: @elector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /electors/1
  # PATCH/PUT /electors/1.json
  def update
    respond_to do |format|
      if @elector.update(elector_params)
        format.html { redirect_to @elector, notice: 'Elector was successfully updated.' }
        format.json { render :show, status: :ok, location: @elector }
      else
        format.html { render :edit }
        format.json { render json: @elector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /electors/1
  # DELETE /electors/1.json
  def destroy
    @elector.destroy
    respond_to do |format|
      format.html { redirect_to electors_url, notice: 'Elector was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_elector
      @elector = Elector.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def elector_params
      params.require(:elector).permit(:idElector, :idPerson, :idZone, :issueDate)
    end
end
