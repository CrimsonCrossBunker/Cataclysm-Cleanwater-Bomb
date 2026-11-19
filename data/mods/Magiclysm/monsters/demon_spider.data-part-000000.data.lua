local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "demon_spider_base",
    abstract = true,
    name = ccb.content.text_without_extraction("base demon spider"),
    description = ccb.content.text_without_extraction("abstract demon spider you shouldn't see this"),
    hp = 45,
    volume = "30 L",
    mass = "40750 g",
    symbol = "s",
    color = "red",
    default_faction = "demon_spider",
    body_type = "spider",
    speed = 150,
    species = { "DEMON_SPIDER" },
    materials = { "iflesh", "demon_chitin" },
    harvest = "demon_spider",
    flags = { "SEES", "SMELLS", "HEARS", "VENOM", "WEBWALK", "CLIMBS", "PUSH_MON" },
    weakpoint_sets = { "wps_arthropod", "wps_arthropod_spider" },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_basic_bug",
        "prof_wp_spider",
    },
}

ccb.content.define_monster {
    id = "mon_demon_spiderling",
    name = ccb.content.plural_text("demon spiderling", "demon spiderlings"),
    copy_from = "demon_spider_base",
    description = ccb.content.text("Despite it being the size of a small dog, you can tell this is a very young spider.  Its red color is why you gave it this name; you have never seen this creature before the Cataclysm.  It is quick, and its large fangs drip with venom."),
    difficulty_adjustment = 2,
    aggression = -10,
    morale = 100,
    melee_skill = 6,
    melee_dice = 1,
    melee_sides = 6,
    melee_damage = { { type = "heat", amount = 4 } },
    dodge = 7,
    vision_day = 5,
    vision_night = 7,
    emissions = { { id = "emit_hot_air2_stream", delay = "1 s" } },
    armor = { bash = 1, cut = 8, stab = 8, acid = 3, heat = 150, bullet = 8, cold = -20 },
    inheritance = { add = { flags = { "HARDTOSHOOT" } } },
}
