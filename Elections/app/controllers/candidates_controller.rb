class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  # GET /candidates
  # GET /candidates.json
  def index
    @candidates = Candidate.limit(100)
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
  end

  # GET /candidates/new
  def new
    @candidate = Candidate.new
  end

  # GET /candidates/1/edit
  def edit
  end

  # POST /candidates
  # POST /candidates.json
  def create
    @candidate = Candidate.new(candidate_params)

    unless check_elector
      return
    end

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: 'Candidate was successfully created.' }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1
  # PATCH/PUT /candidates/1.json
  def update

    # Note: use form validation to ensure that
    #  params[:uploaded_file] is not null

    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to @candidate, notice: 'Candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to candidates_url, notice: 'Candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_image
    @candidate = Candidate.find(params[:id])
    send_data @candidate.candidatePhoto, :type => 'image',:disposition => 'inline'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_candidate
    @candidate = Candidate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def candidate_params
    if params[:candidate][:candidatePhoto].nil? then
      img = {candidatePhoto: ''}
    else
      img = {candidatePhoto: params[:candidate][:candidatePhoto].read}
    end
    img.merge(params.require(:candidate).permit(:candidateNumber, :idPerson, :idParty, :idCargo, :idCity))
  end

  def check_elector
    ret = true
    if Elector.find_by(idPerson: params[:candidate][:idPerson]).nil?
      @candidate.errors.add(:base, "Elector must exist for this CPF")
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
      ret = false
    end
    ret
  end

end