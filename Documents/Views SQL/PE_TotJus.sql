-- Total Justificados
select count(electors.idElector) as TotalJustificado, states.stateName as NomeEstado
from (((((Elections.round_electors 	inner join Elections.electors on round_electors.idElector = electors.idElector)
									inner join Elections.zones on electors.idZone = zones.idZone)
									inner join Elections.addresses on zones.idAddress = addresses.idAddress)
									inner join Elections.cities on addresses.idCity = cities.idCity)
									inner join Elections.states on cities.idState = states.idState)
where electorJustified = '1'
group by NomeEstado;