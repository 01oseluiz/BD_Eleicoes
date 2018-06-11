class ZoneCandidatesController < ApplicationController
  before_action :set_zone_candidate, only: [:show, :edit, :update, :destroy]

  # GET /zone_candidates
  # GET /zone_candidates.json
  def index
    @zone_candidates = ZoneCandidate.all
  end

  # GET /zone_candidates/1
  # GET /zone_candidates/1.json
  def show
  end

  # GET /zone_candidates/new
  def new
    @zone_candidate = ZoneCandidate.new
  end

  # GET /zone_candidates/1/edit
  def edit
  end

  # POST /zone_candidates
  # POST /zone_candidates.json
  def create
    @zone_candidate = ZoneCandidate.new(zone_candidate_params)

    respond_to do |format|
      if @zone_candidate.save
        format.html { redirect_to @zone_candidate, notice: 'Zone candidate was successfully created.' }
        format.json { render :show, status: :created, location: @zone_candidate }
      else
        format.html { render :new }
        format.json { render json: @zone_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zone_candidates/1
  # PATCH/PUT /zone_candidates/1.json
  def update
    respond_to do |format|
      if @zone_candidate.update(zone_candidate_params)
        format.html { redirect_to @zone_candidate, notice: 'Zone candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @zone_candidate }
      else
        format.html { render :edit }
        format.json { render json: @zone_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zone_candidates/1
  # DELETE /zone_candidates/1.json
  def destroy
    @zone_candidate.destroy
    respond_to do |format|
      format.html { redirect_to zone_candidates_url, notice: 'Zone candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zone_candidate
      @zone_candidate = ZoneCandidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zone_candidate_params
      params.require(:zone_candidate).permit(:idCandidate, :idZone, :idRound, :voteTime, :voteIsManual)
    end
end
