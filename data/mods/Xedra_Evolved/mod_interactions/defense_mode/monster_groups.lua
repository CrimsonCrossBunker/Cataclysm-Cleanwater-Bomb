local ccb = require("ccb")
local content = ccb.content

-- A small Exodii hunter/killer unit or party, respecialized for Defense Mode.
content.add(content.MonsterGroup { id = "GROUP_DEFENSE_MODE_EXODII", load_mode = "append" }
    :monster("mon_dm_exodii_quad_jotunn", 20, 1, 1, 1)
    :monster("mon_dm_exodii_quad", 100, 1, 1, 1)
    :monster("mon_dm_exodii_worker", 50, 20, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_DEFENSE_MODE_XEDRA", load_mode = "append" }
    :monster("mon_dm_changeling", 100, 1, 1, 1)
    :monster("mon_dm_fetch_child", 400, 0, 1, 1)
    :monster("mon_dm_fae_wolf", 250, 5, 1, 1)
    :monster("mon_dm_goblin_spider", 100, 1, 1, 1)
    :monster("mon_dm_changeling_bannerman", 100, 1, 1, 1)
    :monster("mon_dm_fetch_daffodil_warrior", 400, 0, 1, 1)
    :monster("mon_dm_pooka_aspirant", 10, 4, 1, 1)
    :monster("mon_dm_redcap_aspirant", 10, 4, 1, 1)
    :monster("mon_dm_vampire_moroi", 25, 1, 1, 1)
    :monster("mon_dm_vampire_strigoi", 15, 1, 1, 1)
    :monster("mon_dm_water_sprite", 40, 0, 1, 1)
    :monster("mon_dm_spitting_lizard", 400, 0, 1, 1)
    :monster("mon_dm_smoke_mephit", 40, 0, 1, 1)
    :monster("mon_dm_skyglass_butterflies", 80, 0, 1, 1)
    :monster("mon_dm_dragonfly_fae", 40, 0, 1, 1)
    :monster("mon_dm_vineling", 40, 0, 1, 1)
    :monster("mon_dm_ratatosk_children", 400, 0, 1, 1)
    :monster("mon_dm_zoomorphic_figure_small", 40, 0, 1, 1)
    :monster("mon_dm_venus_doll", 400, 0, 1, 1))
