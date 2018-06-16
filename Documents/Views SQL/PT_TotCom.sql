select count(round_electors.idElector) as TotalCompareceu from Elections.round_electors
where round_electors.electorVoted = '1';
