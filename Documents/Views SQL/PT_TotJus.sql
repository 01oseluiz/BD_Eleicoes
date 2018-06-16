select count(round_electors.idElector) as TotalJustificados from Elections.round_electors
where round_electors.electorJustified = '1';