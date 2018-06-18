class WelcomeController < ApplicationController

  def index
  end

  def votar
  end

  def check_elector

    @elector = Elector.find_by(idElector: params[:idElector])

    if @elector.nil?
      flash[:error] = "Titulo de Eleitor Invalido!"
      redirect_to votar_path
      return
    end

    render 'votar'
  end

  def create_voto
    @elector = Elector.find_by(idElector: params[:idElector])

    round = '1'
    zone = @elector.idZone
    current_data = Time.zone.now
    voteIsManual = false

    # Salva voto Presidente
    @Presidente = ZoneCandidate.new(idZone: zone, idCandidate: params[:voto][:Presidente], voteTime: current_data, voteIsManual: voteIsManual, idRound: round)
    @Presidente.save

    # Salva voto Governador
    @Governador = ZoneCandidate.new(idZone: zone, idCandidate: params[:voto][:Governador], voteTime: current_data, voteIsManual: voteIsManual, idRound: round)
    @Governador.save

    # Salva voto Senador
    @Senador = ZoneCandidate.new(idZone: zone, idCandidate: params[:voto][:Senador], voteTime: current_data, voteIsManual: voteIsManual, idRound: round)
    @Senador.save

    # Salva voto Deputado_Federal
    @Deputado_Federal = ZoneCandidate.new(idZone: zone, idCandidate: params[:voto][:Deputado_Federal], voteTime: current_data, voteIsManual: voteIsManual, idRound: round)
    @Deputado_Federal.save

    # Salva voto Deputado_Estadual
    @Deputado_Estadual = ZoneCandidate.new(idZone: zone, idCandidate: params[:voto][:Deputado_Estadual], voteTime: current_data, voteIsManual: voteIsManual, idRound: round)
    @Deputado_Estadual.save

    # Registra Voto
    @reg_voto = RoundElector.find_by(idElector:@elector.idElector, idRound: round)

    if @reg_voto.nil?
      @reg_voto = RoundElector.new(idRound: round, idElector: @elector.idElector, electorVoted: true, electorJustified: false)
      @reg_voto.save

      flash[:notice] = "Voto computado!"
    elsif @reg_voto.electorVoted == 0
      sql = "UPDATE `Elections`.`round_electors` SET `electorVoted`='1', `electorJustified`='0' WHERE `idRound`='#{round}' and`idElector`='#{@elector.idElector}';"
      ActiveRecord::Base.connection.execute(sql)

      flash[:notice] = "Voto computado!"
    else
      flash[:error] = "Eleitor já Votou!"
    end

    redirect_to votar_path
  end

  def resultados
    @res = nil

    unless params[:res].nil?
      cargo = params[:res][:Cargo]
      estado = params[:res][:Estado]
      round = params[:res][:Round]

      if cargo != "" and estado != "" and round != ""
        @res = ActiveRecord::Base.connection.select_all("call get_result(#{cargo},#{estado},#{round});")
      end
    end
    render 'resultados'
  end

  def estatisticas
    @est = nil
  end

  def cand_inst_sex
    @est = ActiveRecord::Base.connection.select_all("select * from cand_per_inst_sex")
    render 'estatisticas'
  end

  def cand_per_party
    @est = ActiveRecord::Base.connection.select_all("select * from cand_per_party")
    render 'estatisticas'
  end

  def cand_per_region
    @est = ActiveRecord::Base.connection.select_all("select * from cand_per_region")
    render 'estatisticas'
  end

  def cand_per_state
    @est = ActiveRecord::Base.connection.select_all("select * from cand_per_state")
    render 'estatisticas'
  end

  def global_participation
    @est = ActiveRecord::Base.connection.select_all("select * from global_participation")
    render 'estatisticas'
  end

  def participation_per_region
    @est = ActiveRecord::Base.connection.select_all("select * from participation_per_region")
    render 'estatisticas'
  end

  def participation_per_state
    @est = ActiveRecord::Base.connection.select_all("select * from participation_per_state")
    render 'estatisticas'
  end

  def votes_per_party
    @est = ActiveRecord::Base.connection.select_all("select * from votes_per_party")
    render 'estatisticas'
  end
end
