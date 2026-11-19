local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_uplifted_octopus_spawn",
    copy_from = "mon_uplifted_octupus",
    name = ccb.content.plural_text("Cecaelian Spawn", "Cecaelian Spawns"),
    description = ccb.content.text("A young Cecaelia.  If one is out here, a very protective parent is likely nearby."),
    volume = "45 L",
    mass = "60 kg",
    hp = 20,
    speed = 90,
    aggression = -5,
    symbol = "c",
    morale = 30,
    melee_skill = 2,
    melee_dice = 2,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 2 } },
    dodge = 2,
    harvest = "demihuman",
    attacks = { { reference = "EAT_FOOD", cooldown = 60 } },
    upgrade = { grow_at_age = 480, monster = "mon_uplifted_octupus" },
}
