/*select count(candidates.idCandidate) as NúmeroGovernadores, regions.regionName as NomeRegião -- Número Governadores
	from ((((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
                                inner join Elections.states on cargo_states.idState = states.idState)
                                inner join Elections.regions on states.idRegion = regions.idRegion)
	where cargoName = 'Governador'
    group by NomeRegião;*/

select 
    (select count(candidates.idCandidate) -- Número Governadores
		from ((((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
									inner join Elections.states on cargo_states.idState = states.idState)
									inner join Elections.regions on states.idRegion = regions.idRegion)
		where cargoName = 'Governador'
									) as NúmeroGovernadores,
	regions.regionName as NomeRegião from Elections.regions -- Regiões
    group by NomeRegião;