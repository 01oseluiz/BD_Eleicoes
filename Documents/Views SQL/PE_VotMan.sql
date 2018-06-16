-- Votos Manuais
/*select count(zone_candidates.idVote) as VotosManuais, states.stateName as NomeEstado
from ((((Elections.zone_candidates	inner join Elections.zones on zone_candidates.idZone = zones.idZone)
									inner join Elections.addresses on zones.idAddress = addresses.idAddress)
									inner join Elections.cities on addresses.idCity = cities.idCity)
									inner join Elections.states on cities.idState = states.idState)
where zone_candidates.voteIsManual = '1'
group by NomeEstado;
*/

select
	(select count(zone_candidates.idVote) -- Votos Manuais
		from ((((Elections.zone_candidates	inner join Elections.zones on zone_candidates.idZone = zones.idZone)
											inner join Elections.addresses on zones.idAddress = addresses.idAddress)
											inner join Elections.cities on addresses.idCity = cities.idCity)
											inner join Elections.states on cities.idState = states.idState)
		where zone_candidates.voteIsManual = '1'
											) as VotosManuais,
	states.stateName as NomeEstado from Elections.states -- Estados
	group by NomeEstado;