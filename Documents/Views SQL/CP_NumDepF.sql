/*select count(candidates.idCandidate) as NúmeroDeputadosFederais, parties.partyName as NomePartido -- Número Deputados Federais
	from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.parties on candidates.idParty = parties.idParty)
	where cargoName = 'Deputado Federal'
    group by NomePartido;*/

select
    (select count(candidates.idCandidate) -- Número Deputados Federais
		from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.parties on candidates.idParty = parties.idParty)
		where cargoName = 'Deputado Federal'
									) as NúmeroDeputadosFederais,
	parties.partyName as NomePartido from Elections.parties
    group by NomePartido;