local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_XEDRA_FIELD_AGENT_MORGANTOWN_worn", kind = "collection" }
    group:entry { item = "under_armor_shorts", damage = { 0, 2 } }
    group:entry {
        item = "xedra_enviro_suit",
        damage = { 1, 2 },
        contents = {
            { item = "medium_battery_cell" },
        },
    }
    group:entry { item = "glasses_safety", damage = { 0, 2 } }
    group:entry { item = "basic_papr_helmet", damage = { 0, 3 } }
    group:entry {
        item = "molle_papr_blower_off",
        damage = { 0, 3 },
        contents = {
            { item = "heavy_battery_cell" },
        },
    }
    group:entry { item = "modular_papr_strap", damage = { 0, 3 } }
    group:entry { item = "hk_mp5sd", damage = { 0, 3 } }
    group:entry { item = "fbi_armor_vest", damage = { 0, 3 } }
    group:group("field_mp5")
    content.add(group)
end
