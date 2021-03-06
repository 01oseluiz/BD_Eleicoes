class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  # GET /parties.json
  def index
    @parties = Party.limit(100)
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
  end

  # GET /parties/new
  def new
    @party = Party.new
  end

  # GET /parties/1/edit
  def edit
  end

  # POST /parties
  # POST /parties.json
  def create

    @party = Party.new(party_params)

    unless check_elector
      return
    end

    respond_to do |format|
      if @party.save
        format.html { redirect_to @party, notice: 'Party was successfully created.' }
        format.json { render :show, status: :created, location: @party }
      else
        format.html { render :new }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @party }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  def show_image
    @party = Party.find(params[:id])
    send_data @party.partyLogo, :type => 'image',:disposition => 'inline'
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_party
    @party = Party.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def party_params
    if params[:party][:partyLogo].nil? then
      img = {partyLogo: ''}
    else
      img = {partyLogo: params[:party][:partyLogo].read}
    end
    img.merge(params.require(:party).permit(:idParty, :partyName, :partyAbbv, :idPerson))
  end

  def check_elector
    ret = true
    if Elector.find_by(idPerson: params[:party][:idPerson]).nil?
      @party.errors.add(:base, "Elector must exist for this CPF")
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
      ret = false
    end
    ret
  end
end
