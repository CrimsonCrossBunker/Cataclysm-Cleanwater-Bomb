local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup {
    id = "GROUP_DESERT",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_bat", 50, 2, 3, 12, { conditions = { "DAWN", "DUSK", "SPRING", "SUMMER", "AUTUMN" } }))
