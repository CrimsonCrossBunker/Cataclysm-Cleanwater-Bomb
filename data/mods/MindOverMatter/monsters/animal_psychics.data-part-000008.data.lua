local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_wild_rabbit_blinker",
    name = ccb.content.plural_text("hopalong", "hopalongs"),
    description = ccb.content.text("A brown-coated cottontail rabbit, with a fluffy white tail.  Its small size and docile nature makes it easy prey for predators, at least the ones that can catch it.  You can't tell which one of the two cottontail species from the region this is.  You can tell there's something different about it, though, when it suddenly vanishes and reappears nearby."),
    copy_from = "mon_rabbit_base",
    looks_like = "mon_rabbit",
    mass = "1200 g",
    reproduction = {
        offspring = { monster_group = "GROUP_REPRODUCTION_WILD_RABBIT_BLINKER_BABIES" },
        count = 5,
        interval = 28,
    },
    attacks = {
        {
            move_cost = 50,
            allow_no_target = true,
            maximum_range = 6,
            message = ccb.content.text_without_extraction("%1$s vanishes and reappears elsewhere!"),
            kind = "leap",
            cooldown = { 1, 3 },
            when = "monster_attack_psionics_available",
        },
        {
            id = "psi_rabbit_blinker_blinking",
            spell = { id = "teleport_blink_monster", min_level = 10 },
            cooldown = 30,
            casting_message = ccb.content.text("%1$s vanishes and reappears elsewhere!"),
            kind = "spell",
            when = "monster_attack_psionics_available",
        },
    },
}

ccb.content.define_monster {
    id = "mon_wild_rabbit_blinker_baby",
    name = ccb.content.plural_text("hopalong kit", "hopalong kits"),
    description = ccb.content.text("A tiny and very cute hopalong kit."),
    copy_from = "mon_rabbit_baby_base",
    looks_like = "mon_rabbit_baby",
    upgrade = { grow_at_age = 23, monster = "mon_wild_rabbit" },
    attacks = {
        {
            move_cost = 50,
            allow_no_target = true,
            maximum_range = 4,
            message = ccb.content.text_without_extraction("%1$s vanishes and reappears elsewhere!"),
            kind = "leap",
            cooldown = { 10, 30 },
            when = "monster_attack_psionics_available",
        },
    },
}
