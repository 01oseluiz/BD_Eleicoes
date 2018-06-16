/*select count(candidates.idCandidate) as NúmeroGovernadores, parties.partyName as NomePartido -- Número Governadores
	from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.parties on candidates.idParty = parties.idParty)
	where cargoName = 'Governador'
    group by NomePartido;
*/
select
    (select count(candidates.idCandidate) -- Número Governadores
		from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.parties on candidates.idParty = parties.idParty)
		where cargoName = 'Governador'
									) as NúmeroGovernadores,
	parties.partyName as NomePartido from Elections.parties
    group by NomePartido;