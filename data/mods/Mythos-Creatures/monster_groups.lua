local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

-- Remove shoggoth from group.
content.add(content.MonsterGroup { id = "GROUP_GOO", load_mode = "replace" }
    :monster("mon_blob_small", 200, 0, 1, 1)
    :monster("mon_blob_small", 100, 0, 2, 12)
    :monster("mon_blob", 693, 3, 5, 10)
    :monster("mon_blob_large", 5, 6, 5, 10)
    :monster("mon_blob_brain", 1, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BLACK_ROAD", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_ghoul", 5, 1, 1, 1)
    :monster("mon_ghoul", 5, 7, 5, 20)
    :monster("mon_ghoul", 5, 13, 15, 40)
    :monster("mon_ghoul", 5, 20, 25, 60)
    :monster("mon_ghoul", 5, 0, 1, 1)
    :monster("mon_feral_human_pipe", 40, 1, 2, 3)
    :monster("mon_feral_human_crowbar", 40, 1, 2, 3)
    :monster("mon_feral_human_axe", 20, 2, 1, 2)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- Normal subway, extra spawns underneath a city
content.add(content.MonsterGroup { id = "GROUP_SUBWAY_CITY", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_ghoul", 100, 3, 1, 3)
    :monster("mon_ghast", 100, 4, 1, 3)
    :monster("mon_ghoul", 100, 3, 1, 5)
    :monster("mon_ghast", 100, 4, 1, 5)
    :monster("mon_ghoul", 100, 3, 3, 7)
    :monster("mon_ghast", 100, 4, 3, 7))

content.add(content.MonsterGroup { id = "DUMP_ANIMALS", load_mode = "append" }
    :monster("mon_ghast", 10, 1, 1, 1, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 15, 1, 1, 1))

-- Add rat things to sewers.
content.add(content.MonsterGroup { id = "GROUP_SEWER", load_mode = "append" }
    :monster("mon_rat_thing", 50, 0, 3, 12))

content.add(content.MonsterGroup { id = "GROUP_PARK_SCENIC", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 875, 1, 1, 1)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 1, 2, 3)
    :monster("mon_feral_human_crowbar", 40, 1, 2, 3)
    :monster("mon_feral_human_axe", 20, 2, 1, 2)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_ROOF_ZOMBIE", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 885, 1, 1, 1)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 1, 2, 3)
    :monster("mon_feral_human_crowbar", 40, 1, 2, 3)
    :monster("mon_feral_human_axe", 20, 2, 1, 2))

content.add(content.MonsterGroup {
    id = "GROUP_PARK_PLAYGROUND",
    load_mode = "replace",
    default_monster = "mon_null",
}
    :monster("mon_null", 900, 1, 1, 1)
    :monster("mon_feral_human_pipe", 40, 1, 2, 3)
    :monster("mon_feral_human_crowbar", 40, 1, 2, 3)
    :monster("mon_feral_human_axe", 20, 2, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_PARK_DOG", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 885, 1, 1, 1)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 1, 2, 3)
    :monster("mon_feral_human_crowbar", 40, 1, 2, 3)
    :monster("mon_feral_human_axe", 20, 2, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_SCORCHED", load_mode = "replace" }
    :monster("mon_null", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 875, 1, 1, 1)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 7, 5, 20)
    :monster("mon_ghoul", 5, 13, 15, 40)
    :monster("mon_ghoul", 5, 20, 25, 60)
    :monster("mon_ghoul", 5, 0, 1, 1)
    :monster("mon_feral_human_pipe", 40, 1, 2, 3)
    :monster("mon_feral_human_crowbar", 40, 1, 2, 3)
    :monster("mon_feral_human_axe", 20, 2, 1, 2)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- nemesis squad
content.add(content.MonsterGroup { id = "GROUP_NEMESIS", load_mode = "replace" }
    :monster("mon_null", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_VANILLA", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 870, 1, 1, 1)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_rat_thing", 5, 0, 1, 1)
    :monster("mon_feral_human_pipe", 40, 0, 1, 1)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 1)
    :monster("mon_feral_human_axe", 20, 0, 1, 1)
    :monster("mon_shantak", 1, 0, 1, 1)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- +30% cops
content.add(content.MonsterGroup { id = "GROUP_POLICE", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_feral_human_pipe", 40, 0, 1, 1)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 1)
    :monster("mon_feral_human_axe", 20, 0, 1, 1)
    :monster("mon_shantak", 1, 0, 1, 1)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- +15% child
content.add(content.MonsterGroup { id = "GROUP_HOUSE", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PREPPER_HOUSE", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- +13% fast
content.add(content.MonsterGroup { id = "GROUP_PHARM", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- +15% electric
content.add(content.MonsterGroup { id = "GROUP_ELECTRO", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- +15% fat
content.add(content.MonsterGroup { id = "GROUP_GROCERY", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PUBLICWORKERS", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- 10% chance of a zombie
content.add(content.MonsterGroup { id = "GROUP_MAYBE_ZOMBIE", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 875, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3))

-- School monster spawns.
content.add(content.MonsterGroup { id = "GROUP_SCHOOL", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SMALL_STATION", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_LARGE_STATION", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_CHURCH_ZOMBIE", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_PRISON", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_COP", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- Hospital monster spawns. Same as GROUP_ZOMBIE, but without Z-dogs + 20% medical
content.add(content.MonsterGroup { id = "GROUP_HOSPITAL", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

-- Steel mill monster spawns.
content.add(content.MonsterGroup { id = "GROUP_STEEL_MILL", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MALL", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_FIRE", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "FERAL_HUMANS", load_mode = "replace" }
    :monster("mon_feral_human_pipe", 840, 1, 1, 1)
    :monster("mon_feral_human_pipe", 100, 1, 3, 8)
    :monster("mon_feral_human_crowbar", 40, 1, 2, 6)
    :monster("mon_feral_human_axe", 20, 2, 1, 4))

content.add(content.MonsterGroup { id = "DUMP_ZOMBIES", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PLAIN", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_HOTEL_POOL", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_HOTEL_GYM", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_POOL_NOKIDS", load_mode = "replace", default_monster = "mon_null" }
    :monster("mon_null", 865, 1, 1, 1)
    :monster("mon_rat_thing", 10, 1, 5, 20)
    :monster("mon_ghast", 5, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 5, 1, 2, 3)
    :monster("mon_ghoul", 5, 1, 5, 7)
    :monster("mon_feral_human_pipe", 40, 0, 1, 3)
    :monster("mon_feral_human_crowbar", 40, 0, 1, 3)
    :monster("mon_feral_human_axe", 20, 0, 1, 3)
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_BREATHER", load_mode = "append" }
    :monster("mon_breather", 990, 1, 1, 1)
    :monster("mon_breather", 10, 2, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_BREATHER_HUB", load_mode = "append" }
    :monster("mon_breather_hub", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CHURCH_BLANK", load_mode = "append" }
    :monster("mon_blank", 1, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DARK_WYRM", load_mode = "append" }
    :monster("mon_dark_wyrm", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DOG_THING", load_mode = "append" }
    :monster("mon_dog_thing", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_NETHER_REALITY_TEAR_FIELD",
    load_mode = "append",
    default_monster = "mon_blank",
}
    :monster("mon_flying_polyp", 100, 0, 1, 1)
    :monster("mon_hunting_horror", 100, 0, 1, 1)
    :monster("mon_mi_go", 100, 0, 1, 1)
    :monster("mon_unseen_hunter", 100, 1, 1, 1, { starts = duration(30, "day") })
    :monster("mon_mi_go_scout", 100, 0, 1, 1, { starts = duration(60, "day") })
    :monster("mon_yugg", 100, 0, 1, 1)
    :monster("mon_gelatin", 100, 0, 1, 1)
    :monster("mon_flaming_eye", 100, 0, 1, 1)
    :monster("mon_kreck", 100, 0, 1, 1)
    :monster("mon_gracke", 100, 0, 1, 1)
    :monster("mon_blank", 100, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER", load_mode = "append", default_monster = "mon_blank" }
    :monster("mon_blank", 135, 0, 1, 1)
    :monster("mon_flying_polyp", 25, 0, 1, 1)
    :monster("mon_hunting_horror", 240, 0, 1, 1)
    :monster("mon_unseen_hunter", 50, 0, 1, 1, { starts = duration(120, "day") })
    :monster("mon_yugg", 70, 0, 1, 1)
    :monster("mon_gelatin", 120, 0, 1, 1)
    :monster("mon_flaming_eye", 120, 0, 1, 1)
    :monster("mon_kreck", 210, 0, 1, 1)
    :monster("mon_gozu", 25, 0, 1, 1)
    :monster("mon_shoggoth", 5, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_NETHER_CAPTURED",
    load_mode = "append",
    default_monster = "mon_gracke",
}
    :monster("mon_gelatin", 250, 0, 1, 1)
    :monster("mon_mi_go", 250, 0, 1, 1)
    :monster("mon_mi_go_scout", 250, 0, 1, 1, { starts = duration(60, "day") })
    :monster("mon_kreck", 250, 0, 1, 1)
    :monster("mon_gracke", 250, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_NETHER_PORTAL",
    load_mode = "append",
    default_monster = "mon_gracke",
}
    :monster("mon_gelatin", 200, 0, 1, 1)
    :monster("mon_flaming_eye", 200, 0, 1, 1)
    :monster("mon_kreck", 200, 0, 1, 1)
    :monster("mon_gracke", 200, 0, 1, 1)
    :monster("mon_unseen_hunter", 100, 0, 1, 1, { starts = duration(120, "day") })
    :monster("mon_blank", 200, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIRAL", load_mode = "append" }
    :monster("mon_human_snail", 740, 0, 1, 1)
    :monster("mon_twisted_body", 180, 0, 1, 1)
    :monster("mon_vortex", 80, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TINDALOS", load_mode = "append" }
    :monster("mon_hound_tindalos", 1, 1, 1, 1))

-- Current count is 925.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup { id = "GROUP_CAVE", load_mode = "append", is_animal = true }
    :monster("mon_ghast", 25, 3, 1, 5, { conditions = { "NIGHT", "DUSK" } })
    :monster("mon_ghoul", 25, 3, 1, 5))

-- Current SPRING first DAY count is 513.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup {
    id = "GROUP_FOREST",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") })
    :monster("mon_dark_young", 1, 10, 1, 1, { starts = duration(28, "day") })
    :monster("mon_dark_young", 2, 10, 1, 1, { starts = duration(112, "day") })
    :monster("mon_dark_young", 3, 10, 1, 1, { starts = duration(360, "day") })
    :monster("mon_dark_young", 4, 10, 1, 1, { starts = duration(720, "day") })
    :monster("mon_ghast", 20, 2, 1, 5, { starts = duration(28, "day"), conditions = { "DUSK", "NIGHT" } })
    :monster("mon_ghoul", 25, 3, 1, 5))

-- Current SPRING first DAY count is 944.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
-- DDA weight in this group is somewhere around 803.  Leaving roughly 190 frequency points left for mods.
content.add(content.MonsterGroup {
    id = "GROUP_RIVER",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") })
    :monster("mon_deep_one", 8, 10, 1, 5)
    :monster("mon_deep_one", 15, 10, 1, 10, { conditions = { "NIGHT" } }))

-- Current SPRING first DAY count is 417.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup {
    id = "GROUP_SWAMP",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_shoggoth", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shoggoth", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shoggoth", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shoggoth", 4, 10, 1, 4, { starts = duration(360, "day") })
    :monster("mon_dark_young", 1, 10, 1, 1, { starts = duration(28, "day") })
    :monster("mon_dark_young", 2, 10, 1, 1, { starts = duration(112, "day") })
    :monster("mon_dark_young", 3, 10, 1, 1, { starts = duration(360, "day") })
    :monster("mon_dark_young", 4, 10, 1, 1, { starts = duration(720, "day") }))

-- Current SPRING first DAY count is 350.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup { id = "GROUP_ROOF_ANIMAL", load_mode = "append", is_animal = true }
    :monster("mon_shantak", 1, 10, 1, 1, { starts = duration(12, "day") })
    :monster("mon_shantak", 2, 10, 1, 2, { starts = duration(28, "day") })
    :monster("mon_shantak", 3, 10, 1, 3, { starts = duration(112, "day") })
    :monster("mon_shantak", 4, 10, 1, 4, { starts = duration(360, "day") }))
