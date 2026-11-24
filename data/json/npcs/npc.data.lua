local ccb = require("ccb")

-- Generic hostile military deserter.
ccb.content.define_npc {
    id = "deserter",
    suffix = ccb.content.text("Deserter"),
    class = "NC_SOLDIER",
    attitude = 10,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "no_faction",
}

-- Generic Marloss Priest who leads pilgrim bands.
ccb.content.define_npc {
    id = "marloss_voice",
    suffix = ccb.content.text("Marloss Voice"),
    class = "NC_MARLOSS_VOICE",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_MARLOSS_VOICE",
    faction = "marloss",
}

-- Bee mutant or mutant bee (supposed to be ambiguous). Should be 'it', but we'll go with 'she' because it's a bee.
ccb.content.define_npc {
    id = "apis",
    unique_name = ccb.content.text("Apis"),
    class = "NC_APIS",
    gender = "female",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_DONE",
    faction = "apis_hive",
}

-- Crazy Person.
ccb.content.define_npc {
    id = "derelict_dweller",
    suffix = ccb.content.text("Psycho"),
    class = "NC_THUG",
    attitude = 8,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "no_faction",
}

-- A chef hiding at their job since the Cataclysm. They spawn in a slightly fortified back room of a restaurant with a stockpile of food.
ccb.content.define_npc {
    id = "survivor_chef",
    suffix = ccb.content.text("chef"),
    class = "NC_SURVIVOR_CHEF",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_NC_SURVIVOR_CHEF",
    faction = "no_faction",
}

-- A farmer survivor, friendly but suspicious.
ccb.content.define_npc {
    id = "farmer",
    suffix = ccb.content.text("farmer"),
    class = "NC_FARMER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_NC_FARMER",
    faction = "no_faction",
}

-- Foodperson mascot, except if you ask them Foodperson is a real hero and it's them!
ccb.content.define_npc {
    id = "true_foodperson",
    unique_name = ccb.content.text("Foodperson"),
    class = "NC_TRUE_FOODPERSON",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_TRUE_FOODPERSON",
    missions_offered = "MISSION_PROVE_YOUR_WORTH",
    faction = "no_faction",
}

-- A prototype cyborg you saved.
ccb.content.define_npc {
    id = "cyborg_rescued",
    suffix = ccb.content.text("Cyborg"),
    class = "NC_CYBORG",
    attitude = 1,
    mission = "NULL",
    chat = "TALK_CYBORG_1",
    faction = "no_faction",
}

-- A police officer who has taken over the station since the Cataclysm.  They sell items out of the evidence locker.
ccb.content.define_npc {
    id = "survivor_cop",
    suffix = ccb.content.text("officer"),
    class = "NC_CITY_COP",
    attitude = 0,
    mission = "SHOPKEEP",
    missions_offered = "MISSION_GET_CITY_COP_MOMENTO",
    chat = "TALK_CITY_COP",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "survivor_camper",
    suffix = ccb.content.text("camper"),
    class = "NC_SCAVENGER_STATIC",
    attitude = 1,
    mission = "GUARD",
    chat = "TALK_NPC_CAMPER_SURVIVOR",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "apartment_survivor",
    suffix = ccb.content.text("scavenger"),
    class = "NC_SCAVENGER_STATIC",
    attitude = 1,
    mission = "GUARD",
    chat = "TALK_NPC_APARTMENT_SURVIVOR",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "prepper_survivor",
    suffix = ccb.content.text("prepper"),
    class = "NC_SCAVENGER_PREPPER",
    attitude = 1,
    mission = "GUARD",
    chat = "TALK_NPC_PREPPER_SURVIVOR",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "survivor_moonshiner",
    suffix = ccb.content.text("moonshiner"),
    class = "NC_SCAVENGER_MOONSHINER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_NPC_MOONSHINER",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "NPC_gun_store_survivor",
    class = "NC_SCAVENGER",
    suffix = ccb.content.text("marksman"),
    attitude = 1,
    mission = "GUARD",
    chat = "TALK_NPC_GUN_STORE_SURVIVOR",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "NPC_animal_shelter_survivor",
    class = "NC_VETERINARIAN",
    suffix = ccb.content.text("veterinarian"),
    attitude = 1,
    mission = "GUARD",
    chat = "TALK_NPC_ANIMAL_SHELTER_SURVIVOR",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "NPC_park_survivor",
    class = "NC_SCAVENGER",
    attitude = 1,
    mission = "GUARD",
    chat = "TALK_STRANGER_NEUTRAL",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "NPC_evac_shelter_survivor",
    class = "NC_SCAVENGER_STATIC",
    suffix = ccb.content.text("scavenger"),
    attitude = 1,
    mission = "GUARD_PATROL",
    chat = "TALK_NPC_EVAC_SURVIVOR",
    faction = "no_faction",
}

-- A still-sane mutant human who escaped from a XEDRA facility and is willing to interact with the player.
ccb.content.define_npc {
    id = "survivor_lab_mutant",
    suffix = ccb.content.text("mutant"),
    class = "NC_LAB_MUTANT",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_STRANGER_WARY",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "NPC_homeless_survivor",
    class = "NC_SCAVENGER_STATIC",
    suffix = ccb.content.text("scavenger"),
    attitude = 1,
    mission = "GUARD_PATROL",
    chat = "TALK_NPC_HOMELESS_SURVIVOR",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "NPC_homeless_broker",
    class = "NC_HOMELESS_BROKER",
    suffix = ccb.content.text("scavenger"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_NPC_HOMELESS_BROKER",
    faction = "wasteland_scavengers",
    missions_offered = "MISSION_KILL_SLIMES",
}

ccb.content.define_npc {
    id = "NPC_homeless_group_survivor",
    class = "NC_SCAVENGER_NOMOVE",
    suffix = ccb.content.text("scavenger"),
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_NPC_HOMELESS_GROUP_SURVIVOR",
    faction = "wasteland_scavengers",
}

-- the gunslinger that spawns for MISSION_RECRUIT_TRACKER
ccb.content.define_npc {
    id = "tracker_gunslinger",
    class = "NC_COWBOY",
    attitude = 1,
    mission = "SHOPKEEP",
    missions_offered = "MISSION_JOIN_TRACKER",
    chat = "TALK_STRANGER_FRIENDLY",
    faction = "no_faction",
}

-- Someone helps you test the game.
ccb.content.define_npc {
    id = "NPC_debug",
    suffix = ccb.content.text("Debug"),
    class = "NC_NONE",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "no_faction",
    on_death = "prevent_debug_npc_death",
}
