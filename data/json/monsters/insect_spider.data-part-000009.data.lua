local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_spider_cellar_mom",
    name = ccb.content.plural_text("mommy long-legs", "mommy long legs"),
    description = ccb.content.text("This surprisingly shy giant cellar spider holds a head-sized ball of crawling spiderlings of different ages in its mandibles, carefully balancing on her long legs not to drop the precious cargo.  She seems uninterested in you."),
    copy_from = "mon_spider_cellar_giant",
    speed = 85,
    aggression = -15,
    morale = 10,
    attacks = { { id = "grab", cooldown = 25, when = "monster_attack_intact_legs" } },
    inheritance = {
        add = { flags = { "STUMBLES" } },
        remove = { flags = { "HARDTOSHOOT" }, anger_triggers = { "PLAYER_WEAK" } },
    },
    death = {
        outcome = {
            message = ccb.content.text("The spiderlings fall to the ground!"),
            spell = { id = "death_spider_cellar_mom", hit_self = true },
        },
    },
}
