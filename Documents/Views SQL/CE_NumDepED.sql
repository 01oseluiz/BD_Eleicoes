select count(candidates.idCandidate) as NúmeroDeputadosEstaduais_Distritais, states.stateName as NomeEstado -- Número Deputados Estaduais/Distritais
	from (((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
                                inner join Elections.states on cargo_states.idState = states.idState)
	where cargoName = 'Deputado Estadual/Distrital'
    group by NomeEstado;