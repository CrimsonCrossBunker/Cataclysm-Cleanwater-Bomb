local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_pyrokin_hotair_1",
    name = ccb.content.plural_text("warm air", "warm airs"),
    description = ccb.content.text("A patch of warm air, heated by pyrokinesis."),
    looks_like = "fd_biolum",
    default_faction = "player",
    species = { "UNKNOWN" },
    volume = "62500 ml",
    mass = "81500 g",
    hp = 1,
    speed = 0,
    symbol = "@",
    color = "cyan",
    aggression = -99,
    morale = 2,
    luminance = 15,
    dodge = 6,
    harvest = "exempt",
    emissions = { { id = "emit_pyrokinetic_summon_heat_1", delay = "1 s" } },
    attacks = { { reference = "DISAPPEAR", cooldown = 200 } },
    flags = { "FLIES", "NO_BREATHE", "NOT_HALLUCINATION", "HARDTOSHOOT", "IMMOBILE" },
    death = { outcome = { message = ccb.content.text("The %s disappears."), corpse = "NO_CORPSE" } },
}

ccb.content.define_monster {
    id = "mon_pyrokin_hotair_2",
    copy_from = "mon_pyrokin_hotair_1",
    luminance = 30,
    emissions = { { id = "emit_pyrokinetic_summon_heat_2", delay = "1 s" } },
}

ccb.content.define_monster {
    id = "mon_pyrokin_hotair_3",
    copy_from = "mon_pyrokin_hotair_1",
    luminance = 50,
    emissions = { { id = "emit_pyrokinetic_summon_heat_3", delay = "1 s" } },
}

ccb.content.define_monster {
    id = "mon_pyrokin_hotair_4",
    copy_from = "mon_pyrokin_hotair_1",
    luminance = 80,
    emissions = { { id = "emit_pyrokinetic_summon_heat_4", delay = "1 s" } },
}

ccb.content.define_monster {
    id = "mon_photokin_image",
    name = ccb.content.plural_text("Lucid Shadow", "Lucid Shadows"),
    description = ccb.content.text("A light illusion made to look like yourself."),
    looks_like = "mon_civilian_stationary",
    default_faction = "factionless",
    species = { "UNKNOWN" },
    volume = "62500 ml",
    mass = "0g",
    hp = 1,
    speed = 150,
    symbol = "@",
    color = "cyan",
    aggression = -99,
    morale = 2,
    luminance = 16,
    dodge = 8,
    harvest = "exempt",
    fear_triggers = { "PLAYER_CLOSE" },
    attacks = { { reference = "DISAPPEAR", cooldown = 200 } },
    flags = { "CLIMBS", "NO_BREATHE", "NOT_HALLUCINATION", "HARDTOSHOOT", "COPY_SUMMONER_LOOK" },
    death = { outcome = { message = ccb.content.text("The %s disappears."), corpse = "NO_CORPSE" } },
}

ccb.content.define_monster {
    id = "mon_photokin_army_image",
    name = ccb.content.plural_text("Phantom Legionnaire", "Phantom Legionnaires"),
    description = ccb.content.text("A light illusion made to look like yourself."),
    looks_like = "mon_civilian_stationary",
    default_faction = "factionless",
    species = { "UNKNOWN" },
    volume = "62500 ml",
    mass = "0g",
    hp = 1,
    speed = 150,
    symbol = "@",
    color = "cyan",
    aggression = -99,
    morale = 2,
    luminance = 16,
    dodge = 8,
    harvest = "exempt",
    fear_triggers = { "PLAYER_CLOSE" },
    flags = { "CLIMBS", "NO_BREATHE", "NOT_HALLUCINATION", "HARDTOSHOOT", "COPY_SUMMONER_LOOK" },
    death = {
        outcome = {
            spell = { id = "photokinetic_light_explosion_monster", min_level = 5, hit_self = true },
            message = ccb.content.text("The %s explodes in a brilliant burst of light!"),
            corpse = "NO_CORPSE",
        },
    },
}
