local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_spider_cellar_giant_s",
    name = ccb.content.plural_text("cellar spiderling", "cellar spiderlings"),
    description = ccb.content.text("A juvenile cellar spider, about the size of a beer bottle."),
    copy_from = "mon_larva_abstract",
    default_faction = "spider_cellar",
    body_type = "spider",
    species = { "SPIDER" },
    speed = 90,
    symbol = "s",
    color = "brown",
    weakpoint_sets = { "wps_arthropod", "wps_arthropod_spider" },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_basic_bug",
        "prof_wp_spider",
    },
    vision_day = 5,
    vision_night = 5,
    upgrade = { grow_at_age = 30, monster = "mon_spider_cellar_giant" },
    inheritance = { add = { flags = { "WEBWALK" } } },
}
