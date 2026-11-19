local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "AFS_GROUP_DM", load_mode = "append" }
    :monster("mon_moxie_scavenger_dm", 350, 1, 1, 1)
    :monster("mon_moxie_regenerator_dm", 200, 1, 1, 1)
    :monster("mon_moxie_grabby_dm", 100, 1, 1, 1)
    :monster("mon_human_biomachine_dm", 50, 1, 1, 1)
    :monster("afs_titanis_dm", 350, 0, 1, 1)
    :monster("afs_venandi_dm", 250, 0, 1, 1)
    :monster("afs_mon_boatman_dm", 200, 0, 1, 1)
    :monster("mon_zombie_upliftedbear_dm", 3, 10, 1, 1)
    :monster("mon_uplifted_ape_zed_dm", 5, 10, 1, 1)
    :monster("mon_zombie_upliftedoctopus_dm", 1, 10, 1, 1))
