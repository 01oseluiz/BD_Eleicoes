-- Votos Válidos
/*select count(zone_candidates.idVote) as VotosVálidos, states.stateName as NomeEstado
from ((((Elections.zone_candidates	inner join Elections.zones on zone_candidates.idZone = zones.idZone)
									inner join Elections.addresses on zones.idAddress = addresses.idAddress)
									inner join Elections.cities on addresses.idCity = cities.idCity)
									inner join Elections.states on cities.idState = states.idState)
where zone_candidates.idCandidate != '1' and zone_candidates.idCandidate != '0'
group by NomeEstado;*/

select
	(select count(zone_candidates.idVote) -- Votos Válidos
		from ((((Elections.zone_candidates	inner join Elections.zones on zone_candidates.idZone = zones.idZone)
											inner join Elections.addresses on zones.idAddress = addresses.idAddress)
											inner join Elections.cities on addresses.idCity = cities.idCity)
											inner join Elections.states on cities.idState = states.idState)
		where zone_candidates.idCandidate != '1' and zone_candidates.idCandidate != '0'
											) as VotosVálidos, 
	states.stateName as NomeEstado from Elections.states -- Estados
	group by NomeEstado;