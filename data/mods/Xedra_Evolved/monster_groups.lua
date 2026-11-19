local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

content.add(content.MonsterGroup { id = "GROUP_RENFIELD_UPGRADE", load_mode = "append" }
    :monster("mon_renfield", 910, 1, 1, 1)
    :monster("mon_renfield_9mm", 450, 1, 1, 1)
    :monster("mon_renfield_shotgun", 250, 1, 1, 1)
    :monster("mon_renfield_flamethrower", 45, 1, 1, 1)
    :monster("mon_renfield_bionic_monster", 25, 1, 1, 1)
    :monster("mon_renfield_abomination", 25, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDER", load_mode = "append" }
    :monster("mon_spider_disease", 40, 0, 1, 1)
    :monster("mon_spider_web_small", 400, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CHANGELING_MIRRORED_FIELD", load_mode = "append" }
    :monster("mon_changeling", 100, 1, 1, 1)
    :monster("mon_fetch_child", 400, 0, 1, 1)
    :monster("mon_fae_wolf", 250, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CHANGELING_STRIKE_FORCE", load_mode = "append" }
    :monster("mon_changeling_bannerman", 100, 1, 1, 1)
    :monster("mon_fetch_daffodil_warrior", 400, 0, 1, 1)
    :monster("mon_pooka_aspirant", 10, 4, 1, 1)
    :monster("mon_redcap_aspirant", 10, 4, 1, 1)
    :group("GROUP_TROLLS", 1, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TROLLS", load_mode = "append" }
    :monster("mon_xe_troll", 20, 1, 1, 1)
    :monster("mon_xe_troll_full_armor", 1, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GOBLIN_SPIDER", load_mode = "append" }
    :monster("mon_goblin_spider", 100, 1, 1, 1)
    :monster("mon_fetch_child", 200, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_DREAM_WOUND_SHADOW",
    load_mode = "append",
    default_monster = "mon_dream_shadow",
}
    :monster("mon_dream_shadow", 500, 0, 1, 1)
    :monster("mon_dream_shadowbeast", 200, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FOREST", load_mode = "append", is_animal = true }
    :monster("mon_xe_unicorn", 10, 10, 1, 5, { starts = duration(40, "day") })
    :monster("mon_goblin_spider", 15, 15, 3, 12, { starts = duration(130, "day") })
    :monster("mon_mi_go_stalking_warper", 5, 2, 1, 1, { starts = duration(40, "day") }))

content.add(content.MonsterGroup { id = "GROUP_RIVER", load_mode = "append", is_animal = true }
    :monster("mon_xe_mavka", 1, 10, 1, 5, { starts = duration(83, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PARK_SCENIC", load_mode = "append" }
    :group("GROUP_VAMPIRE_MOROI_TYPES", 10, 1, 1, 1)
    :monster("mon_vampire_strigoi", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PARK_PLAYGROUND", load_mode = "append" }
    :group("GROUP_VAMPIRE_MOROI_TYPES", 10, 1, 1, 1)
    :monster("mon_vampire_strigoi", 1, 1, 1, 1)
    :monster("mon_mi_go_stalking_warper", 5, 2, 1, 1, { starts = duration(40, "day") }))

content.add(content.MonsterGroup { id = "GROUP_HOUSE", load_mode = "append" }
    :group("GROUP_VAMPIRE_MOROI_TYPES", 5, 1, 1, 1)
    :monster("mon_vampire_strigoi", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MANSION_START", load_mode = "append" }
    :group("GROUP_VAMPIRE_MOROI_TYPES", 80, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_HOSPITAL", load_mode = "append" }
    :group("GROUP_VAMPIRE_MOROI_TYPES", 5, 1, 1, 1)
    :monster("mon_vampire_strigoi", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "FERAL_HUMANS", load_mode = "append" }
    :group("GROUP_VAMPIRE_MOROI_TYPES", 5, 1, 1, 1)
    :monster("mon_vampire_strigoi", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_RETIREMENT_COMMUNITY", load_mode = "append" }
    :group("GROUP_VAMPIRE_MOROI_TYPES", 5, 1, 1, 1)
    :monster("mon_vampire_strigoi", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MOROI", load_mode = "append" }
    :group("GROUP_VAMPIRE_MOROI_TYPES", 35, 1, 1, 1)
    :monster("mon_renfield", 50, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_VAMPIRE_CATHEDRAL", load_mode = "append" }
    :monster("mon_bat_giant", 35, 1, 1, 2)
    :monster("mon_renfield", 50, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_VAMPIRE_MOROI_TYPES", load_mode = "append" }
    :monster("mon_vampire_moroi_fast", 10, 1, 1, 1)
    :monster("mon_vampire_moroi_tough", 25, 1, 1, 1)
    :monster("mon_vampire_moroi_animalistic", 15, 1, 1, 1)
    :monster("mon_vampire_moroi_stealthy", 15, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_STRIGOI", load_mode = "append" }
    :monster("mon_renfield", 50, 1, 1, 2)
    :monster("mon_vampire_strigoi", 25, 1, 1, 1)
    :monster("mon_vampire_strigoi", 1, 1, 2, 4)
    :monster("xe_mon_bat", 30, 1, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_VAMPIRES_MIXED", load_mode = "append" }
    :monster("mon_renfield", 50, 1, 1, 2)
    :group("GROUP_VAMPIRE_MOROI_TYPES", 25, 1, 1, 1)
    :monster("mon_vampire_strigoi", 15, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CAVE_FERAL_VAMPIRE", load_mode = "append" }
    :monster("mon_vampire_feral", 10, 1, 1, 1)
    :monster("mon_vampire_feral", 1, 1, 2, 5))

content.add(content.MonsterGroup { id = "GROUP_RENFIELDS", load_mode = "append" }
    :monster("mon_renfield", 50, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_SWARM_BATS", load_mode = "append", is_animal = true }
    :monster("xe_mon_bat", 10, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_GIANT_BATS", load_mode = "append", is_animal = true }
    :monster("mon_bat_giant", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_VAMPIRE_BATS", load_mode = "append", is_animal = true }
    :monster("mon_vampire_bat", 10, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_ALL_BATS", load_mode = "append", is_animal = true }
    :monster("xe_mon_bat", 10, 1, 1, 2)
    :monster("mon_vampire_bat", 10, 1, 1, 2)
    :monster("mon_bat_giant", 10, 1, 1, 1))

-- A small Exodii hunter/killer unit or party.  Hunting for Xedra Survivors or Balthazar pawns.
content.add(content.MonsterGroup { id = "GROUP_Exodii_Jotunn", load_mode = "append" }
    :monster("mon_exodii_quad", 100, 1, 1, 1)
    :monster("mon_exodii_quad", 50, 20, 1, 3)
    :monster("mon_exodii_quad_jotunn", 800, 30, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_FERAL_AGENTS", load_mode = "append" }
    :monster("mon_feral_zebra_agent", 100, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_FERAL_AGENTS_BORDER_PATROL_OFFICE", load_mode = "append" }
    :monster("mon_feral_zebra_agent", 100, 1, 2, 4)
    :monster("mon_feral_zebra_agent_p90", 100, 1, 0, 2))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_IERDE", load_mode = "append" }
    :monster("mon_monstrous_badger", 150, 0, 1, 1)
    :monster("mon_stoneling", 250, 0, 1, 1)
    :monster("mon_shamir_worm", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_IERDE_LESSER", load_mode = "append" }
    :monster("mon_monstrous_badger", 100, 0, 1, 1)
    :monster("mon_stoneling", 200, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_IERDE_MEDIAL", load_mode = "append" }
    :monster("mon_shamir_worm", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_UNDINE", load_mode = "append" }
    :monster("mon_water_sprite", 125, 0, 1, 1)
    :monster("mon_spitting_lizard", 300, 0, 1, 1)
    :monster("mon_undertow", 75, 2, 1, 1)
    :monster("mon_shabriri", 60, 2, 1, 1)
    :monster("mon_nuckalavee", 5, 5, 1, 1, { conditions = { "SPRING", "AUTUMN", "WINTER" } }))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_UNDINE_LESSER", load_mode = "append" }
    :monster("mon_water_sprite", 100, 0, 1, 1)
    :monster("mon_spitting_lizard", 100, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_UNDINE_MEDIAL", load_mode = "append" }
    :monster("mon_undertow", 100, 0, 1, 1)
    :monster("mon_shabriri", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_UNDINE_GREATER", load_mode = "append" }
    :monster("mon_nuckalavee", 20, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_SALAMANDER", load_mode = "append" }
    :monster("mon_smoke_mephit", 100, 0, 1, 1)
    :monster("mon_salamander_tiny", 300, 0, 1, 1)
    :monster("mon_elemental_saraph", 5, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_SALAMANDER_LESSER", load_mode = "append" }
    :monster("mon_smoke_mephit", 100, 0, 1, 1)
    :monster("mon_salamander_tiny", 100, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_SALAMANDER_GREATER", load_mode = "append" }
    :monster("mon_elemental_saraph", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_SYLPH", load_mode = "append" }
    :monster("mon_skyglass_butterflies", 150, 0, 1, 1)
    :monster("mon_dragonfly_fae", 250, 0, 1, 1)
    :monster("mon_sheyd", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_SYLPH_LESSER", load_mode = "append" }
    :monster("mon_skyglass_butterflies", 80, 0, 1, 1)
    :monster("mon_dragonfly_fae", 40, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_SYLPH_MEDIAL", load_mode = "append" }
    :monster("mon_sheyd", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_ARVORE", load_mode = "append" }
    :monster("mon_vineling", 100, 0, 1, 1)
    :monster("mon_ratatosk_children", 300, 0, 1, 1)
    :monster("mon_bear_thorn", 50, 0, 1, 1)
    :monster("mon_defender_wood", 5, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_ARVORE_LESSER", load_mode = "append" }
    :monster("mon_vineling", 100, 0, 1, 1)
    :monster("mon_ratatosk_children", 100, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_ARVORE_MEDIAL", load_mode = "append" }
    :monster("mon_bear_thorn", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_ARVORE_GREATER", load_mode = "append" }
    :monster("mon_defender_wood", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GENIUS_HOMULLUS", load_mode = "append" }
    :monster("mon_zoomorphic_figure_small", 40, 0, 1, 1)
    :monster("mon_xe_golem", 40, 0, 1, 1)
    :monster("mon_venus_doll", 400, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_CAMP_OM", load_mode = "append" }
    :monster("mon_mi_go_stalking_warper", 50, 20, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_COMMON", load_mode = "append" }
    :monster("mon_mi_go_stalking_warper", 50, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_humanoid", 50, 2, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_CAPTORS", load_mode = "append" }
    :monster("mon_mi_go_stalking_warper", 300, 2, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_BOSS", load_mode = "append" }
    :monster("mon_mi_go_stalking_warper", 200, 2, 1, 1)
    :monster("mon_mi_go_stalking_warper", 50, 5, 2, 3))

content.add(content.MonsterGroup { id = "GROUP_SALAMANDER_ERUPTION_SURFACE", load_mode = "append" }
    :monster("mon_smoke_mephit", 100, 0, 1, 1)
    :monster("mon_salamander_tiny", 300, 0, 1, 1)
    :monster("mon_elemental_saraph", 5, 0, 1, 1)
    :monster("mon_salamagman_small", 50, 0, 1, 1)
    :monster("mon_salamagman_large", 5, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SALAMANDER_ERUPTION", load_mode = "append" }
    :monster("mon_smoke_mephit", 10, 0, 1, 1)
    :monster("mon_salamander_tiny", 30, 0, 1, 1)
    :monster("mon_salamagman_small", 100, 0, 1, 1)
    :monster("mon_salamagman_large", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SALAMANDER_FINALE", load_mode = "append" }
    :monster("mon_salamagman_warlord_butterfly", 100, 0, 1, 2)
    :monster("mon_salamagman_small", 25, 0, 1, 6)
    :monster("mon_salamagman_large", 50, 0, 1, 4))

-- This unfortunately has to be random because otherwise it doesn't only choose the appropriate season, if it rolls an inappropriate one nothing spawns
content.add(content.MonsterGroup { id = "GROUP_MARCH_LORDS", load_mode = "append" }
    :group("GROUP_MARCH_LORDS_SPRING", 1, 1, 1, 1)
    :group("GROUP_MARCH_LORDS_SUMMER", 1, 1, 1, 1)
    :group("GROUP_MARCH_LORDS_AUTUMN", 1, 1, 1, 1)
    :group("GROUP_MARCH_LORDS_WINTER", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MARCH_LORDS_SPRING", load_mode = "append" }
    :monster("mon_march_lord_spring", 3, 1, 1, 1)
    :monster("mon_march_lord_summer", 1, 1, 1, 1)
    :monster("mon_march_lord_autumn", 1, 1, 1, 1)
    :monster("mon_march_lord_winter", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MARCH_LORDS_SUMMER", load_mode = "append" }
    :monster("mon_march_lord_spring", 1, 1, 1, 1)
    :monster("mon_march_lord_summer", 3, 1, 1, 1)
    :monster("mon_march_lord_autumn", 1, 1, 1, 1)
    :monster("mon_march_lord_winter", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MARCH_LORDS_AUTUMN", load_mode = "append" }
    :monster("mon_march_lord_spring", 1, 1, 1, 1)
    :monster("mon_march_lord_summer", 1, 1, 1, 1)
    :monster("mon_march_lord_autumn", 3, 1, 1, 1)
    :monster("mon_march_lord_winter", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MARCH_LORDS_WINTER", load_mode = "append" }
    :monster("mon_march_lord_spring", 1, 1, 1, 1)
    :monster("mon_march_lord_summer", 1, 1, 1, 1)
    :monster("mon_march_lord_autumn", 1, 1, 1, 1)
    :monster("mon_march_lord_winter", 3, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_HEDGE_TO_CAUSE_ARMED_MEN", load_mode = "append" }
    :monster("mon_hedge_armed_warrior_sword", 400, 1, 1, 1)
    :monster("mon_hedge_armed_warrior_spear", 400, 1, 1, 1)
    :monster("mon_hedge_armored_warrior_axe", 200, 1, 1, 1)
    :monster("mon_hedge_armored_warrior_mace", 200, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_HOSTS_OF_SAMHAIN", load_mode = "append" }
    :monster("mon_samhain_ghost_mace", 333, 1, 1, 1)
    :monster("mon_samhain_ghost_axe", 333, 1, 1, 1)
    :monster("mon_samhain_ghost_spear", 333, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_monochrome", 30, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_BOOMER_UPGRADE",
    load_mode = "append",
    default_monster = "mon_boomer",
}
    :monster("mon_boomer_monochrome", 50, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_MONOCHROME_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zombie_monochrome",
}
    :monster("mon_zombie_monochrome", 450, 1, 1, 1)
    :monster("mon_zombie_monochrome_2", 225, 1, 1, 1)
    :monster("mon_zombie_monochrome_3", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_XE_MIGO_EVO", load_mode = "append" }
    :monster("mon_mi_go", 1, 1, 1, 1)
    :monster("mon_mi_go_humanoid", 1, 1, 1, 1)
    :monster("mon_mi_go_stalking_warper", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER_CULT", load_mode = "append", default_monster = "mon_blank" }
    :monster("mon_blank", 200, 0, 1, 1)
    :monster("mon_hunting_horror", 150, 0, 1, 1)
    :monster("mon_unseen_hunter", 50, 0, 1, 1, { starts = duration(120, "day") })
    :monster("mon_gelatin", 120, 0, 1, 1)
    :monster("mon_kreck", 210, 0, 1, 1)
    :monster("mon_gozu", 25, 0, 1, 1)
    :monster("mon_nether_huntsman", 15, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TRIFFID", load_mode = "append", default_monster = "mon_triffid" }
    :group("GROUP_TRIFFID_MAGES", 25, 5, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_OUTER",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :group("GROUP_TRIFFID_MAGES", 50, 2, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_HEARTGUARDS",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :group("GROUP_TRIFFID_MAGES", 150, 2, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_MAGES",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :monster("mon_triffid_greenseer", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB", load_mode = "append" }
    :monster("mon_zombie_oa_agent", 50, 5, 1, 1)
    :monster("mon_feral_xe_dreamer", 5, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_SURFACE", load_mode = "append" }
    :monster("mon_zombie_oa_agent", 20, 5, 1, 1)
    :monster("mon_feral_xe_dreamer", 5, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_SECURITY", load_mode = "append" }
    :monster("mon_zombie_oa_agent", 20, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_XE_SPIRE_DEMONS", load_mode = "append" }
    :monster("mon_tentacle_daemon", 20, 1, 1, 1)
    :monster("mon_frozen_daemon", 10, 1, 1, 1)
    :monster("mon_spined_daemon", 2, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_XE_DREAMER_LAB_MONSTERS", load_mode = "append" }
    :monster("mon_xe_flying_shark", 20, 1, 1, 1)
    :monster("mon_shifter_non_player", 20, 1, 1, 1)
    :monster("mon_ophanim_non_player", 5, 5, 1, 1)
    :monster("mon_duplicator_non_player", 10, 1, 1, 1))

-- Includes gunbots, use sparingly
content.add(content.MonsterGroup { id = "GROUP_XE_INVENTOR_LAB_MONSTERS", load_mode = "append" }
    :monster("mon_bitebot_science", 20, 1, 1, 1)
    :monster("mon_meleebot_science", 20, 1, 1, 1)
    :monster("mon_shotgunbot_science", 5, 5, 1, 1)
    :monster("mon_sniperbot_science", 1, 15, 1, 1))
