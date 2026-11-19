local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup {
    id = "GROUP_MEGAFAUNA_DM",
    load_mode = "append",
    default_monster = "mon_direwolf",
}
    :monster("mon_direwolf_dm", 10, 1, 1, 1)
    :monster("mon_sabcat_dm", 10, 1, 1, 1)
    :monster("mon_cave_lion_dm", 10, 1, 1, 1)
    :monster("mon_titanis_walleri_dm", 10, 1, 1, 1))
