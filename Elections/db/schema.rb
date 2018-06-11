# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "addresses", primary_key: "idAddress", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "addressName", limit: 70, null: false
    t.bigint "idCity", null: false
    t.index ["idCity"], name: "Address_City_idx"
  end

  create_table "candidates", primary_key: "idCandidate", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "idPerson", null: false
    t.bigint "idParty", null: false
    t.bigint "idCargo", null: false
    t.bigint "idCity", null: false
    t.binary "candidatePhoto"
    t.index ["idCargo"], name: "Candidate_Cargo_idx"
    t.index ["idCity"], name: "Candidate_City_idx"
    t.index ["idParty"], name: "Candidate_Party_idx"
    t.index ["idPerson"], name: "Candidate_Person_idx"
  end

  create_table "cargo_states", primary_key: ["idCargo", "idState"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "idCargo", null: false
    t.bigint "idState", null: false
    t.integer "cargoAmount", null: false
    t.index ["idState"], name: "Amount_State_idx"
  end

  create_table "cargos", primary_key: "idCargo", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cargoName", limit: 30, null: false
  end

  create_table "cities", primary_key: "idCity", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cityName", limit: 50, null: false
    t.bigint "idState", null: false
    t.index ["idState"], name: "City_State_idx"
  end

  create_table "educations", primary_key: "idEducation", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "educationName", null: false
  end

  create_table "electors", primary_key: "idElector", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "idPerson", null: false
    t.bigint "idZone", null: false
    t.date "issueDate", null: false
    t.index ["idPerson"], name: "Elector_Person_idx"
    t.index ["idZone"], name: "Elector_Zone_idx"
  end

  create_table "parties", primary_key: "idParty", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "partyName", limit: 60, null: false
    t.string "partyAbbv", limit: 7, null: false
    t.bigint "idPerson", null: false
    t.binary "partyLogo"
    t.index ["idPerson"], name: "Party_Person_idx"
    t.index ["partyAbbv"], name: "partyAbbv_UNIQUE", unique: true
  end

  create_table "people", primary_key: "idPerson", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "personFirstName", limit: 20, null: false
    t.string "personLastName", limit: 40, null: false
    t.date "personBirthDate", null: false
    t.string "personSex", limit: 1, null: false
    t.bigint "idAddress", null: false
    t.bigint "idEducation", null: false
    t.index ["idAddress"], name: "Elector_Address_idx"
    t.index ["idEducation"], name: "Elector_Scholar_idx"
  end

  create_table "regions", primary_key: "idRegion", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "regionName", limit: 15, null: false
  end

  create_table "round_candidates", primary_key: ["idRound", "idCandidate"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "idRound", null: false
    t.bigint "idCandidate", null: false
    t.index ["idCandidate"], name: "Round_Candidate_idx"
  end

  create_table "round_electors", primary_key: ["idRound", "idElector"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "idRound", null: false
    t.bigint "idElector", null: false
    t.integer "electorVoted", limit: 1, default: 0, null: false
    t.integer "electorJustified", limit: 1, default: 0, null: false
    t.index ["idElector"], name: "Round_Elector_idx"
  end

  create_table "rounds", primary_key: "idRound", id: :bigint, default: 1, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "roundDate", null: false
  end

  create_table "states", primary_key: "idState", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "stateName", limit: 20, null: false
    t.string "stateAbbv", limit: 2, null: false
    t.bigint "idRegion", null: false
    t.binary "stateFlag"
    t.index ["idRegion"], name: "State_Region_idx"
  end

  create_table "zone_candidates", primary_key: "idVote", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "idCandidate", default: 0, null: false
    t.bigint "idZone", null: false
    t.bigint "idRound", null: false
    t.timestamp "voteTime", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "voteIsManual", limit: 1, default: 0, null: false
    t.index ["idCandidate"], name: "Vote_Candidate"
    t.index ["idRound"], name: "Vote_Round_idx"
    t.index ["idZone"], name: "Vote_Zone_idx"
  end

  create_table "zones", primary_key: ["idZone", "numZone", "idAddress"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "idZone", null: false, auto_increment: true
    t.integer "numZone", null: false
    t.bigint "idAddress", null: false
    t.index ["idAddress"], name: "Zone_Addr_idx"
  end

  add_foreign_key "addresses", "cities", column: "idCity", primary_key: "idCity", name: "Address_City"
  add_foreign_key "candidates", "cargos", column: "idCargo", primary_key: "idCargo", name: "Candidate_Cargo"
  add_foreign_key "candidates", "cities", column: "idCity", primary_key: "idCity", name: "Candidate_City"
  add_foreign_key "candidates", "parties", column: "idParty", primary_key: "idParty", name: "Candidate_Party"
  add_foreign_key "candidates", "people", column: "idPerson", primary_key: "idPerson", name: "Candidate_Person"
  add_foreign_key "cargo_states", "cargos", column: "idCargo", primary_key: "idCargo", name: "Amount_Cargo"
  add_foreign_key "cargo_states", "states", column: "idState", primary_key: "idState", name: "Amount_State"
  add_foreign_key "cities", "states", column: "idState", primary_key: "idState", name: "City_State"
  add_foreign_key "electors", "people", column: "idPerson", primary_key: "idPerson", name: "Elector_Person"
  add_foreign_key "electors", "zones", column: "idZone", primary_key: "idZone", name: "Elector_Zone"
  add_foreign_key "parties", "people", column: "idPerson", primary_key: "idPerson", name: "Party_Person"
  add_foreign_key "people", "addresses", column: "idAddress", primary_key: "idAddress", name: "Elector_Address"
  add_foreign_key "people", "educations", column: "idEducation", primary_key: "idEducation", name: "Elector_Scholar"
  add_foreign_key "round_candidates", "candidates", column: "idCandidate", primary_key: "idCandidate", name: "Round_Candidate"
  add_foreign_key "round_candidates", "rounds", column: "idRound", primary_key: "idRound", name: "CRound"
  add_foreign_key "round_electors", "electors", column: "idElector", primary_key: "idElector", name: "Round_Elector"
  add_foreign_key "round_electors", "rounds", column: "idRound", primary_key: "idRound", name: "ERound"
  add_foreign_key "states", "regions", column: "idRegion", primary_key: "idRegion", name: "State_Region"
  add_foreign_key "zone_candidates", "candidates", column: "idCandidate", primary_key: "idCandidate", name: "Vote_Candidate"
  add_foreign_key "zone_candidates", "rounds", column: "idRound", primary_key: "idRound", name: "Vote_Round"
  add_foreign_key "zone_candidates", "zones", column: "idZone", primary_key: "idZone", name: "Vote_Zone"
  add_foreign_key "zones", "addresses", column: "idAddress", primary_key: "idAddress", name: "Zone_Addr"
end
