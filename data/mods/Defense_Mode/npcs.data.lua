local ccb = require("ccb")

-- Scenario specific unique NPC, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "follower_liz",
    unique_name = ccb.content.text("Liz"),
    gender = "female",
    age = 25,
    class = "NC_BOUNTY_HUNTER",
    attitude = 3,
    mission = "NULL",
    chat = "TALK_FRIEND",
    faction = "your_followers",
}

-- Scenario specific unique NPC, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "follower_david",
    unique_name = ccb.content.text("David"),
    gender = "male",
    age = 27,
    class = "NC_BOUNTY_HUNTER",
    attitude = 3,
    mission = "NULL",
    chat = "TALK_FRIEND",
    faction = "your_followers",
}

-- Scenario specific unique NPC, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "follower_dianne",
    unique_name = ccb.content.text("Dianne"),
    gender = "female",
    age = 26,
    class = "NC_BOUNTY_HUNTER",
    attitude = 3,
    mission = "NULL",
    chat = "TALK_FRIEND",
    faction = "your_followers",
}

-- Scenario specific unique NPC, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "follower_ed",
    unique_name = ccb.content.text("Ed"),
    gender = "male",
    age = 23,
    class = "NC_BOUNTY_HUNTER",
    attitude = 3,
    mission = "NULL",
    chat = "TALK_FRIEND",
    faction = "your_followers",
}

-- Scenario specific unique NPC, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "follower_barbara",
    unique_name = ccb.content.text("Barbara"),
    gender = "female",
    age = 80,
    class = "NC_BOUNTY_HUNTER",
    attitude = 3,
    mission = "NULL",
    chat = "TALK_FRIEND",
    faction = "your_followers",
}

ccb.content.define_npc {
    id = "follower_mercenary",
    class = "NC_BOUNTY_HUNTER",
    attitude = 3,
    mission = "NULL",
    chat = "TALK_FRIEND",
    faction = "your_followers",
}

ccb.content.define_npc {
    id = "random_survivor",
    class = "NC_SCAVENGER",
    attitude = 1,
    mission = "NULL",
    chat = "TALK_NPC_DEFENSE_WANDERER",
    faction = "no_faction",
}

ccb.content.define_npc {
    id = "random_survivor_nefarious",
    class = "NC_SCAVENGER",
    attitude = 1,
    mission = "NULL",
    chat = "TALK_MUG",
    faction = "no_faction",
}

-- Despite being similar to most other bandits, these are made to attack head-on.
ccb.content.define_npc {
    id = "defense_mode_raider",
    suffix = ccb.content.text("raider"),
    class = "NC_SCAVENGER",
    attitude = 10,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

-- Carries everything you could ever need to defend yourself.
ccb.content.define_npc {
    id = "defense_mode_merchant",
    suffix = ccb.content.text("merchant"),
    class = "NC_DM_MERCHANT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_DM_MERCHANT",
    faction = "free_merchants",
    perception = -20,
    dexterity = -20,
    personality = { aggression = -100, bravery = -100, collector = 0, altruism = 0 },
}

ccb.content.define_npc_class {
    id = "NC_DM_MERCHANT",
    name = ccb.content.text("Merchant"),
    job_description = ccb.content.text("I'm the one who sells you things."),
    common = false,
    strength = 10000,
    worn = "NC_DM_MERCHANT_worn",
    carry = "NC_DM_MERCHANT_carry",
    price_rules = {
        { group = "NC_DM_MERCHANT_stock", markup = 2.5 },
        { group = "zombie_humanoid", fixed_adjustment = -2.5 },
        { group = "human", fixed_adjustment = -2.5 },
        { group = "arachnid", fixed_adjustment = -2.5 },
        { group = "triffid_paralytic", fixed_adjustment = -2.5 },
        { group = "default_zombie_death_drops", fixed_adjustment = -0.5 },
        { group = "mon_zombie_cop_death_drops", fixed_adjustment = -0.5 },
        { group = "mon_zombie_fireman_death_drops", fixed_adjustment = -0.5 },
        { group = "mon_zombie_hazmat_death_drops", fixed_adjustment = -0.5 },
        { group = "mon_zombie_swat_death_drops", fixed_adjustment = -0.5 },
        { group = "mon_zombie_resort_dancer_death_drops", fixed_adjustment = -0.5 },
        { group = "mon_zombie_resort_bouncer_death_drops", fixed_adjustment = -0.5 },
        { group = "mon_zombie_resort_staff_death_drops", fixed_adjustment = -0.5 },
    },
    traits = {
        { "DEBUG_FLIMSY", 100 },
        { "DEBUG_FLIMSY2", 100 },
        { "DEBUG_NOSCENT", 100 },
        { "DEBUG_SILENT", 100 },
        { "DEBUG_LS", 100 },
    },
}

ccb.content.define_mutation {
    id = "DEBUG_FLIMSY",
    name = ccb.content.text("Debug No HP"),
    points = -6,
    description = ccb.content.text("You will die in one hit, more or less.  Sneezing too hard will kill you."),
    debug = true,
    enchantments = { "INLINE_ENCH_DEBUG_FLIMSY_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_FLIMSY2",
    name = ccb.content.text("Debug No HP II"),
    points = -6,
    description = ccb.content.text("You will die in one hit, more or less.  Sneezing too hard will kill you."),
    debug = true,
    enchantments = { "INLINE_ENCH_DEBUG_FLIMSY2_0" },
}
