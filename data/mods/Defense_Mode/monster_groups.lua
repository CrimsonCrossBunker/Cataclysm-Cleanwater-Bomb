local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

content.add(content.MonsterGroup { id = "GROUP_TRIFFID_DM", load_mode = "append", default_monster = "mon_triffid" }
    :monster("mon_triffid", 205, 1, 1, 1)
    :monster("mon_triffid", 300, 2, 2, 3)
    :monster("mon_fungal_fighter", 160, 0, 1, 1)
    :monster("mon_vinebeast", 160, 10, 1, 1, { starts = duration(40, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_SPIDER_DM",
    load_mode = "append",
    default_monster = "mon_spider_web_dm",
}
    :monster("mon_spider_cellar_giant_dm", 205, 1, 1, 1)
    :monster("mon_spider_web_dm", 300, 2, 2, 3)
    :monster("mon_spider_jumping_mega_dm", 160, 0, 1, 1)
    :monster("mon_spider_widow_giant_dm", 160, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ROBOT_DM", load_mode = "append" }
    :monster("mon_manhack", 515, 0, 1, 1)
    :monster("mon_skitterbot", 220, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER_DM", load_mode = "append", default_monster = "mon_blank" }
    :monster("mon_blank", 135, 0, 1, 1)
    :monster("mon_flying_polyp", 5, 0, 1, 1)
    :monster("mon_yugg", 10, 0, 1, 1)
    :monster("mon_kreck", 210, 0, 1, 1)
    :monster("mon_gozu", 5, 0, 1, 1))

-- nemesis squad, exists here to remove them from Defense Mode
content.add(content.MonsterGroup {
    id = "GROUP_NEMESIS",
    load_mode = "append",
    default_monster = "mon_zombie_nemesis",
}
    :monster("mon_zombie", 1000, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie", 10, 7, 5, 20)
    :monster("mon_zombie", 10, 13, 15, 40)
    :monster("mon_zombie", 10, 20, 25, 60)
    :monster("mon_zombie", 4720, 0, 1, 1)
    :monster("mon_zombie_fat", 750, 2, 1, 1)
    :monster("mon_zombie_fat", 30, 7, 3, 5)
    :monster("mon_zombie_tough", 750, 3, 1, 1)
    :monster("mon_zombie_child", 750, 1, 1, 1)
    :monster("mon_zombie_rot", 500, 3, 1, 1)
    :monster("mon_zombie_crawler", 250, 3, 1, 1)
    :monster("mon_zombie_dog", 200, 2, 1, 1)
    :monster("mon_zombie_dog", 10, 4, 3, 5)
    :monster("mon_zombie_dog", 10, 16, 5, 8)
    :monster("mon_zombie_dog", 10, 24, 8, 12)
    :monster("mon_dog_zombie_cop", 50, 4, 1, 1)
    :monster("mon_dog_zombie_rot", 50, 5, 1, 1)
    :monster("mon_zombie_cop", 200, 3, 1, 1)
    :monster("mon_zombie_fursuit", 1, 3, 1, 1)
    :monster("mon_zombie_swat", 100, 3, 1, 1)
    :monster("mon_zombie_medical", 100, 2, 1, 1)
    :monster("mon_zombie_hazmat", 100, 3, 1, 1)
    :monster("mon_zombie_fireman", 100, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 100, 5, 1, 1)
    :monster("mon_zombie_static", 100, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 10, 25, 1, 1)
    :monster("mon_zombie_survivor", 10, 25, 1, 1, { starts = duration(120, "day") })
    :monster("mon_zombie_survivor_elite", 10, 25, 1, 1, { starts = duration(160, "day") })
    :group("GROUP_FERAL", 13, 1, 1, 1)
    :monster("mon_beekeeper", 10, 5, 1, 1)
    :monster("mon_zombie_technician", 10, 12, 1, 1)
    :monster("mon_zombie_runner", 200, 5, 1, 4))
