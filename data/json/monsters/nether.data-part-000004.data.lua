local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_void_spider_spiderling",
    name = ccb.content.plural_text("weaver juvenile", "weaver juveniles"),
    description = ccb.content.text("The distressed movements of the juvenile reveal conjoined layers of flailing legs and fangs."),
    default_faction = "nether",
    copy_from = "mon_void_spider",
    color = "red",
    symbol = "s",
    hp = 10,
    armor = { bash = 5, cut = 5, bullet = 5, electric = 3, stab = 4, acid = 15 },
    grab_strength = 50,
    melee_dice = 3,
    melee_sides = 5,
    melee_skill = 3,
    attacks = {
        { id = "grab", cooldown = 7 },
        { id = "grab_drag", cooldown = 15, grab_settings = { drag_distance = 1 } },
        { id = "drag_followup", grab_settings = { drag_distance = 1 } },
    },
    inheritance = {
        add = { flags = { "SILENT_DISAPPEAR" } },
        remove = { flags = { "ALWAYS_SEES_YOU" } },
        scale = { speed = 1.2, dodge = 0.25, vision_day = 2 },
    },
    death = {
        outcome = { corpse = "NO_CORPSE", message = ccb.content.text("The %s shatters like pane of glass.") },
    },
}

ccb.content.define_monster {
    id = "mon_void_spider_spiderling_skewered",
    name = ccb.content.plural_text("skewered juvenile", "skewered juveniles"),
    copy_from = "mon_void_spider_spiderling",
    color = "light_green",
    description = ccb.content.text("Layers of flailing limbs struggle against an impaled emerald lance."),
    death = { drops = "void_spider_spiderling_skewered_drops" },
}
