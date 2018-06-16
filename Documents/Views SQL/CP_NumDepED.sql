/*select count(candidates.idCandidate) as NúmeroDeputados_Estaduais_Distritais, parties.partyName as NomePartido -- Número Deputados Estaduais/Distritais
	from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
								inner join Elections.parties on candidates.idParty = parties.idParty)
	where cargoName = 'Deputado Estadual/Distrital'
    group by NomePartido;
*/
select
    (select count(candidates.idCandidate) -- Número Deputados Estaduais/Distritais
		from ((Elections.candidates inner join Elections.cargos on candidates.idCargo = cargos.idCargo)
									inner join Elections.parties on candidates.idParty = parties.idParty)
		where cargoName = 'Deputado Estadual/Distrital'
									) as NúmeroDeputados_Estaduais_Distritais,
	parties.partyName as NomePartido from Elections.parties
    group by NomePartido;