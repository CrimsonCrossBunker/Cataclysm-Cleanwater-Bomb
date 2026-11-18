local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_XEDRA_FIELD_AGENT_worn", kind = "collection" }
    group:entry { item = "xedra_enviro_suit", damage = { 1, 2 } }
    group:entry {
        item = "basic_papr_belt_off",
        damage = { 0, 2 },
        contents = {
            { item = "medium_battery_cell" },
            { item = "gasfilter_med" },
        },
    }
    group:entry {
        item = "xedra_artifact_cleansuit",
        damage = { 1, 2 },
        contents = {
            { item = "heavy_battery_cell" },
        },
    }
    group:item("inert_glowing_string")
    group:entry { item = "papr_half_mask", damage = { 0, 2 } }
    content.add(group)
end
