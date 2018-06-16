/*select count(candidates.idCandidate) as NúmeroDeputadosFederais, states.stateName as NomeEstado -- Número Deputados Federais
	from (((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
                                inner join Elections.states on cargo_states.idState = states.idState)
	where cargoName = 'Deputado Federal'
    group by NomeEstado;*/
    
select
    (select count(candidates.idCandidate) -- Número Deputados Federais
		from (((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
									inner join Elections.states on cargo_states.idState = states.idState)
		where cargoName = 'Deputado Federal'
									) as NúmeroDeputadosFederais,
	states.stateName as NomeEstado from Elections.states -- Estado
    group by NomeEstado;