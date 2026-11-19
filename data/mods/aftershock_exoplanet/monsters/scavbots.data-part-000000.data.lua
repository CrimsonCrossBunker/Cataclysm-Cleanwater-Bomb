local ccb = require("ccb")

-- ["emit_bee_field"]
ccb.content.define_monster {
    id = "mon_utilibot_beehive",
    copy_from = "mon_utilibot",
    name = ccb.content.plural_text("bee bot", "bee bots"),
    description = ccb.content.text("A salvaged utility robot converted into an AI monitored bee hive that periodically removes and delivers honey combs."),
    color = "brown",
    speed = 0,
    aggression = 0,
    morale = 20,
    fear_triggers = { "HURT" },
    revert_item = "bot_utilibot_beehive",
    biosignature = { item = "honeycomb", interval = 3600 },
    attacks = { { reference = "PARROT", cooldown = 10 } },
    death = {
        drops = { groups = { { id = "broken_robots", weight = 1 }, { id = "beehive", weight = 1 } } },
    },
}

ccb.content.define_monster {
    id = "mon_light_hack",
    copy_from = "base_drone",
    name = ccb.content.plural_text("floating lantern", "floating lanterns"),
    looks_like = "bot_manhack",
    description = ccb.content.text("A salvaged drone repurposed into a mobile light source."),
    speed = 250,
    color = "yellow",
    luminance = 100,
    aggression = 0,
    morale = 50,
    dodge = 8,
    revert_item = "bot_light_hack",
    armor = { bash = 8, cut = 10, bullet = 15 },
    inheritance = { add = { flags = { "STUMBLES", "HARDTOSHOOT" } } },
}
