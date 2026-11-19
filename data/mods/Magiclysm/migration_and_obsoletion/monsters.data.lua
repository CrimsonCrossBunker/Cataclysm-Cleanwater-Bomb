local ccb = require("ccb")

-- Now only for shaman, todo: make them natural spawn, add harvest, etc
-- PACIFIST because #55528
ccb.content.define_monster {
    id = "mon_shambling_mound",
    name = ccb.content.plural_text("shambling mound", "shambling mounds"),
    description = ccb.content.text("This giant plant mess is one of the oldest magic species in the world.  They were very rare before the Cataclysm, but their population has since dramatically increased."),
    default_faction = "magical_beast",
    volume = "679000 ml",
    mass = "769 kg",
    hp = 800,
    speed = 15,
    symbol = "M",
    color = "green",
    aggression = 100,
    morale = 60,
    melee_skill = 0,
    melee_dice = 0,
    melee_sides = 0,
    melee_damage = { { type = "cut", amount = 0 } },
    dodge = 0,
    vision_day = 45,
    vision_night = 6,
    attacks = { { spell = { id = "shambling_aoe", min_level = 0 }, cooldown = 1, kind = "spell" } },
    materials = { "veggy" },
    flags = {
        "SEES", "HEARS", "WARM", "HARDTOSHOOT", "BASHES", "DESTROYS", "ATTACKMON", "PUSH_MON",
        "PUSH_VEH", "PACIFIST",
    },
    armor = { bash = 20, cut = 20, bullet = 20 },
    death = { outcome = { message = ccb.content.text("The %s dissolves."), corpse = "NO_CORPSE" } },
}
