select count(candidates.idCandidate) as NúmeroDeputadosFederais, regions.regionName as NomeRegião -- Número Deputados Federais
	from ((((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
                                inner join Elections.states on cargo_states.idState = states.idState)
                                inner join Elections.regions on states.idRegion = regions.idRegion)
	where cargoName = 'Deputado Federal'
    group by NomeRegião;