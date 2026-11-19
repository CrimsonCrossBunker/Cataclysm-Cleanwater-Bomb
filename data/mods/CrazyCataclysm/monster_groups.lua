local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

-- Autumn is Halloween
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie_skeltal", 1, 60, 1, 1)
    :monster("mon_zombie_skeltal", 1, 30, 1, 1, { conditions = { "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_HOSPITAL", load_mode = "append" }
    :monster("mon_zombie_skeltal", 1, 60, 1, 1)
    :monster("mon_zombie_skeltal", 1, 30, 1, 1, { conditions = { "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_GROCERY", load_mode = "append" }
    :monster("mon_zombie_skeltal", 1, 60, 1, 1)
    :monster("mon_zombie_skeltal", 1, 30, 1, 1, { conditions = { "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_HOUSE", load_mode = "append" }
    :monster("mon_zombie_skeltal", 1, 60, 1, 1)
    :monster("mon_zombie_skeltal", 1, 30, 1, 1, { conditions = { "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_FOREST", load_mode = "append" }
    :monster("mon_bear_smoky", 1, 0, 1, 1, {
        starts = duration(112, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_SWAMP", load_mode = "append" }
    :monster("mon_bear_smoky", 1, 0, 1, 1, {
        starts = duration(112, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_RIVER", load_mode = "append" }
    :monster("mon_bear_smoky", 1, 0, 1, 1, {
        starts = duration(112, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

-- Additional bears during winter, when they hibernate.
content.add(content.MonsterGroup { id = "GROUP_CAVE", load_mode = "append" }
    :monster("mon_bear_smoky", 10, 0, 1, 1, { starts = duration(112, "day") })
    :monster("mon_bear_smoky", 100, 0, 1, 1, { conditions = { "WINTER" } }))

content.add(content.MonsterGroup { id = "GROUP_SEWAGE_TREATMENT", load_mode = "append", is_animal = true }
    :monster("mon_gator", 40, 2, 1, 2))

-- nemesis squad
content.add(content.MonsterGroup { id = "GROUP_NEMESIS", load_mode = "replace" }
    :monster("mon_shia", 1, 1, 1, 1)
    :monster("mon_immortal_snail", 1, 1, 1, 1))
