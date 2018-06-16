create view Candidatos_por_Estado as
select
	(select count(candidates.idCandidate) -- Número Presidentes
		from (((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
									inner join Elections.states on cargo_states.idState = states.idState)
		where cargoName = 'Presidente'
									) as NúmeroPresidentes,
	(select count(candidates.idCandidate) -- Número Governadores
		from (((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
									inner join Elections.states on cargo_states.idState = states.idState)
		where cargoName = 'Governador'
									) as NúmeroGovernadores,
	(select count(candidates.idCandidate) -- Número Senadores
		from (((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
									inner join Elections.states on cargo_states.idState = states.idState)
		where cargoName = 'Senador'
									)  as NúmeroSenadores,
	(select count(candidates.idCandidate) -- Número Deputados Federais
		from (((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
									inner join Elections.states on cargo_states.idState = states.idState)
		where cargoName = 'Deputado Federal'
									) as NúmeroDeputadosFederais,
	(select count(candidates.idCandidate) -- Número Deputados Estaduais/Distritais
		from (((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
									inner join Elections.states on cargo_states.idState = states.idState)
		where cargoName = 'Deputado Estadual/Distrital'
									) as NúmeroDeputadosEstaduais_Distritais,
	states.stateName as NomeEstado from Elections.states -- Estado
    group by NomeEstado;