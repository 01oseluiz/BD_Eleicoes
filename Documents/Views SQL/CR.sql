-- create view Candidatos_por_Região as
select 
	(select count(candidates.idCandidate) -- Número Presidentes
	from ((((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
                                inner join Elections.states on cargo_states.idState = states.idState)
                                inner join Elections.regions on states.idRegion = regions.idRegion)
	where cargoName = 'Presidente'
								) as NúmeroPresidentes,
    (select count(candidates.idCandidate) -- Número Governadores
	from ((((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
                                inner join Elections.states on cargo_states.idState = states.idState)
                                inner join Elections.regions on states.idRegion = regions.idRegion)
	where cargoName = 'Governador'
								) as NúmeroGovernadores,
	(select count(candidates.idCandidate) -- Número Senadores
	from ((((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
                                inner join Elections.states on cargo_states.idState = states.idState)
                                inner join Elections.regions on states.idRegion = regions.idRegion)
	where cargoName = 'Senador'
								) as NúmeroSenadores,
	(select count(candidates.idCandidate) -- Número Deputados Federais
	from ((((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
                                inner join Elections.states on cargo_states.idState = states.idState)
                                inner join Elections.regions on states.idRegion = regions.idRegion)
	where cargoName = 'Deputado Federal'
								) as NúmeroDeputadosFederais,
	(select count(candidates.idCandidate) -- Número Deputados Estaduais/Distritais
	from ((((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.cargo_states on cargos.idCargo = cargo_states.idCargo)
                                inner join Elections.states on cargo_states.idState = states.idState)
                                inner join Elections.regions on states.idRegion = regions.idRegion)
	where cargoName = 'Deputado Estadual/Distrital'
								) as NúmeroNúmeroDeputadosEstaduais_Distritais,
	regions.regionName as NomeRegião from Elections.regions -- Regiões
    group by NomeRegião;
    