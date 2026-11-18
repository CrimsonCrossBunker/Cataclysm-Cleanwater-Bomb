local content = require("ccb").content

do
    -- expansions of vanilla clothing groups in this file.
    -- replace helmet full carbide's below with body armors once those are made.
    local group = content.ItemGroup { id = "mil_armor", kind = "distribution" }
    group:item("helmet_full_carbide", 2)
    group:item("tac_fullhelmet_uicas", 2)
    group:item("tac_helmet_uicas", 5)
    group:item("nanomesh_vest", 1)
    group:item("carbide_cuirass", 1)
    group:item("afs_military_vestxl", 9)
    group:item("xlboots_combat", 15)
    group:item("xlgloves_tactical", 10)
    group:item("tripaw_xlgloves_tactical", 8)
    content.extend_item_group(group)
end
