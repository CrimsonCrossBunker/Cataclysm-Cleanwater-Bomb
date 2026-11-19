local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_mutant_cryo",
    name = ccb.content.plural_text("frost maddened human", "frost maddened humans"),
    description = ccb.content.text("Sky blue irises cover the entirety of the eye.  What happened to this person during their deep freeze?"),
    default_faction = "cryo",
    looks_like = "chud",
    body_type = "human",
    species = { "HUMAN" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 80,
    speed = 100,
    materials = { "flesh" },
    symbol = "@",
    color = "magenta",
    aggression = 40,
    morale = 100,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 4,
    melee_damage = { { type = "cold", amount = 4 } },
    dodge = 2,
    harvest = "human",
    dissect = "dissect_human",
    vision_day = 30,
    vision_night = 3,
    pathing = { avoid_traps = true, avoid_sharp = true },
    anger_triggers = { "FRIEND_DIED", "FRIEND_ATTACKED", "HURT" },
    flags = {
        "SEES", "HEARS", "SMELLS", "BASHES", "GROUP_BASH", "HUMAN", "CAN_OPEN_DOORS",
        "PATH_AVOID_DANGER", "COLDPROOF",
    },
    death = { drops = "cryo_lab_drops" },
}

ccb.content.define_monster {
    id = "mon_cryokinetic",
    copy_from = "mon_mutant_cryo",
    description = ccb.content.text("Sky blue irises with gray floating flecks cover the entirety of the eye.  Flurries seem to emanate from around them."),
    hp = 90,
    color = "light_blue",
    aggression = 30,
    morale = 100,
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 5,
    melee_damage = { { type = "cold", amount = 8 } },
    dodge = 3,
    attacks = {
        {
            spell = { id = "cryo_blast", min_level = 5 },
            cooldown = 20,
            casting_message = ccb.content.text("A burst of frozen air explodes from their lungs!"),
            kind = "spell",
        },
    },
}

ccb.content.define_monster {
    id = "mon_flesh_golem_afs",
    copy_from = "mon_flesh_golem",
    upgrade = { half_life = 60, monster = "mon_flesh_golem_afs" },
    attacks = {
        { reference = "FLESH_GOLEM", cooldown = 8 },
        { reference = "ABSORB_MEAT", cooldown = 1 },
        { reference = "hypo_pkill", cooldown = 1 },
    },
    death = { drops = "mon_zombie_scientist_death_drops" },
}
