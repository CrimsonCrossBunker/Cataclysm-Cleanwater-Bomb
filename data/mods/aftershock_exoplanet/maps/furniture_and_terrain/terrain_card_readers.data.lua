local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_industrial_card_reader",
    name = ccb.content.text("Old TSKBEM Card Reader"),
    description = ccb.content.text("A smartcard based lock system once fitted to TSKBEM prefab industrial facilities.  While an original key would be impossible to find, the machine is ancient and obsolete, and it can be hacked or masterkeys can be obtained to bypass it."),
    symbol = "6",
    color = "yellow",
    copy_from = "t_card_science_maintenance_yellow",
    looks_like = "t_card_science_maintenance_yellow",
    card_reader = {
        flags = { "OLD_TSKBEM_CARD" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = false,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

ccb.content.define_terrain {
    id = "t_afs_enforcer_card_reader",
    name = ccb.content.text("Old Enforcer Card Reader"),
    description = ccb.content.text("A smartcard based lock system once fitted to corporate police prefab facilities.  While an original key would be impossible to find, the machine is ancient and obsolete, and it can be hacked or masterkeys can be obtained to bypass it."),
    symbol = "6",
    color = "blue",
    copy_from = "t_card_science_maintenance_blue",
    looks_like = "t_card_science_maintenance_blue",
    card_reader = {
        flags = { "OLD_ENFORCER_CARD" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = false,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

ccb.content.define_terrain {
    id = "t_afs_mercurial_card_reader",
    name = ccb.content.text("Old Mercurial Card Reader"),
    description = ccb.content.text("A smartcard based lock system once fitted to corporate Mercurial prefab facilities.  While an original key would be impossible to find, the machine is ancient and obsolete, and it can be hacked or masterkeys can be obtained to bypass it."),
    symbol = "6",
    color = "green",
    copy_from = "t_card_science_maintenance_green",
    looks_like = "t_card_science_maintenance_green",
    card_reader = {
        flags = { "OLD_MERCURIAL_CARD" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = false,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}
