/*select count(zone_candidates.idVote) as VotosManuais, regions.regionName as NomeRegião -- Votos Manuais
	from (((((Elections.zone_candidates	inner join Elections.zones on zone_candidates.idZone = zones.idZone)
										inner join Elections.addresses on zones.idAddress = addresses.idAddress)
										inner join Elections.cities on addresses.idCity = cities.idCity)
										inner join Elections.states on cities.idState = states.idState)
                                        inner join Elections.regions on states.idRegion = regions.idRegion)
	where zone_candidates.voteIsManual = '1'
    group by NomeRegião;*/

select
	(select count(zone_candidates.idVote) -- Votos Manuais
		from (((((Elections.zone_candidates	inner join Elections.zones on zone_candidates.idZone = zones.idZone)
											inner join Elections.addresses on zones.idAddress = addresses.idAddress)
											inner join Elections.cities on addresses.idCity = cities.idCity)
											inner join Elections.states on cities.idState = states.idState)
											inner join Elections.regions on states.idRegion = regions.idRegion)
		where zone_candidates.voteIsManual = '1'
											) as VotosManuais,
	regions.regionName as NomeRegião from Elections.regions -- Regiões
    group by NomeRegião;