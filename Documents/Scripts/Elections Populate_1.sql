-- Table Regions

INSERT INTO regions(regionName) VALUES('Norte');
INSERT INTO regions(regionName) VALUES('Nordeste');
INSERT INTO regions(regionName) VALUES('Centro-Oeste');
INSERT INTO regions(regionName) VALUES('Sudeste');
INSERT INTO regions(regionName) VALUES('Sul');

-- Table Cargos

INSERT INTO cargos(cargoName) VALUES('Presidente');
INSERT INTO cargos(cargoName) VALUES('Governador');
INSERT INTO cargos(cargoName) VALUES('Senador');
INSERT INTO cargos(cargoName) VALUES('Deputado Federal');
INSERT INTO cargos(cargoName) VALUES('Deputado Estadual/Distrital');

-- Table Rounds

INSERT INTO rounds VALUES (1, '2018-10-07');
INSERT INTO rounds VALUES (2, '2018-10-28');

-- Table States

INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Acre', 'AC', 1);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Alagoas', 'AL', 2);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Amazonas', 'AM', 1);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Amapá', 'AP', 1);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Bahia', 'BA', 2);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Ceará', 'CE', 2);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Distrito Federal', 'DF', 3);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Espírito Santo', 'ES', 4);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Goiás', 'GO', 3);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Maranhão', 'MA', 2);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Mato Grosso', 'MT', 3);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Mato Grosso do Sul', 'MS', 3);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Minas Gerais', 'MG', 4);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Pará', 'PA', 1);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Paraíba', 'PB', 2);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Paraná', 'PR', 5);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Pernambuco', 'PE', 2);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Piauí', 'PI', 2);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Rio de Janeiro', 'RJ', 4);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Rio Grande do Norte', 'RN', 2);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Rio Grande do Sul', 'RS', 5);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Rondônia', 'RO', 1);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Roraima', 'RR', 1);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Santa Catarina', 'SC', 5);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('São Paulo', 'SP', 4);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Sergipe', 'SE', 2);
INSERT INTO states(stateName, stateAbbv, idRegion) VALUES('Tocantins', 'TO', 1);

-- Table Cargo_State

INSERT INTO cargo_states VALUES(4,1,8);
INSERT INTO cargo_states VALUES(4,2,9);
INSERT INTO cargo_states VALUES(4,3,8);
INSERT INTO cargo_states VALUES(4,4,8);
INSERT INTO cargo_states VALUES(4,5,39);
INSERT INTO cargo_states VALUES(4,6,22);
INSERT INTO cargo_states VALUES(4,7,8);
INSERT INTO cargo_states VALUES(4,8,10);
INSERT INTO cargo_states VALUES(4,9,17);
INSERT INTO cargo_states VALUES(4,10,18);
INSERT INTO cargo_states VALUES(4,13,53);
INSERT INTO cargo_states VALUES(4,12,8);
INSERT INTO cargo_states VALUES(4,11,8);
INSERT INTO cargo_states VALUES(4,14,17);
INSERT INTO cargo_states VALUES(4,15,12);
INSERT INTO cargo_states VALUES(4,17,25);
INSERT INTO cargo_states VALUES(4,18,10);
INSERT INTO cargo_states VALUES(4,16,30);
INSERT INTO cargo_states VALUES(4,19,46);
INSERT INTO cargo_states VALUES(4,20,8);
INSERT INTO cargo_states VALUES(4,22,8);
INSERT INTO cargo_states VALUES(4,23,8);
INSERT INTO cargo_states VALUES(4,21,31);
INSERT INTO cargo_states VALUES(4,24,16);
INSERT INTO cargo_states VALUES(4,26,8);
INSERT INTO cargo_states VALUES(4,25,70);
INSERT INTO cargo_states VALUES(4,27,8);
INSERT INTO cargo_states VALUES(5,1,24);
INSERT INTO cargo_states VALUES(5,2,27);
INSERT INTO cargo_states VALUES(5,3,24);
INSERT INTO cargo_states VALUES(5,4,24);
INSERT INTO cargo_states VALUES(5,5,63);
INSERT INTO cargo_states VALUES(5,6,46);
INSERT INTO cargo_states VALUES(5,7,24);
INSERT INTO cargo_states VALUES(5,8,30);
INSERT INTO cargo_states VALUES(5,9,41);
INSERT INTO cargo_states VALUES(5,10,42);
INSERT INTO cargo_states VALUES(5,13,77);
INSERT INTO cargo_states VALUES(5,12,24);
INSERT INTO cargo_states VALUES(5,11,24);
INSERT INTO cargo_states VALUES(5,14,41);
INSERT INTO cargo_states VALUES(5,15,36);
INSERT INTO cargo_states VALUES(5,17,49);
INSERT INTO cargo_states VALUES(5,18,30);
INSERT INTO cargo_states VALUES(5,16,54);
INSERT INTO cargo_states VALUES(5,19,70);
INSERT INTO cargo_states VALUES(5,20,24);
INSERT INTO cargo_states VALUES(5,22,24);
INSERT INTO cargo_states VALUES(5,23,24);
INSERT INTO cargo_states VALUES(5,21,55);
INSERT INTO cargo_states VALUES(5,24,40);
INSERT INTO cargo_states VALUES(5,26,24);
INSERT INTO cargo_states VALUES(5,25,94);
INSERT INTO cargo_states VALUES(5,27,24);

-- Table Education

INSERT INTO educations VALUES(1,'Fundamental - Incompleto');
INSERT INTO educations VALUES(2,'Fundamental - Completo');
INSERT INTO educations VALUES(3,'Médio - Incompleto');
INSERT INTO educations VALUES(4,'Médio - Completo');
INSERT INTO educations VALUES(5,'Superior - Incompleto');
INSERT INTO educations VALUES(6,'Superior - Completo');
INSERT INTO educations VALUES(7,'Pós-graduação (Lato senso) - Incompleto');
INSERT INTO educations VALUES(8,'Pós-graduação (Lato senso) - Completo');
INSERT INTO educations VALUES(9,'Pós-graduação (Stricto sensu, nível mestrado) - Incompleto');
INSERT INTO educations VALUES(10,'Pós-graduação (Stricto sensu, nível mestrado) - Completo');
INSERT INTO educations VALUES(11,'Pós-graduação (Stricto sensu, nível doutor) - Incompleto');
INSERT INTO educations VALUES(12,'Pós-graduação (Stricto sensu, nível doutor) - Completo');

