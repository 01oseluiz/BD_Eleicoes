create view Candidatos_por_Partido as
select
	(select count(candidates.idCandidate) -- Número Presidentes
		from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.parties on candidates.idParty = parties.idParty)
		where cargoName = 'Presidente') as NúmeroPresidentes,
    (select count(candidates.idCandidate) -- Número Governadores
		from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.parties on candidates.idParty = parties.idParty)
		where cargoName = 'Governador') as NúmeroGovernadores,
    (select count(candidates.idCandidate) -- Número Senadores
		from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.parties on candidates.idParty = parties.idParty)
		where cargoName = 'Senador') as NúmeroSenadores,
    (select count(candidates.idCandidate) -- Número Deputados Federais
		from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.parties on candidates.idParty = parties.idParty)
		where cargoName = 'Deputado Federal'
									) as NúmeroDeputadosFederais,
    (select count(candidates.idCandidate) -- Número Deputados Estaduais/Distritais
		from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.parties on candidates.idParty = parties.idParty)
		where cargoName = 'Deputado Estadual/Distrital'
										) as NúmeroDeputados_Estaduais_Distritais,
    parties.partyName as NomePartido from Elections.parties
    group by NomePartido;