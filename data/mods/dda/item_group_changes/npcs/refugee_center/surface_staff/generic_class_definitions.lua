local content = require("ccb").content

do
    -- Initially the ref center guards indoors stick to melee weapons, as most of these folks aren't trained to use guns.
    local group = content.ItemGroup { id = "NC_FREE_MERCH_GUARD_wield_phase1", kind = "distribution" }
    group:item("spear_knife_proper", 40)
    group:item("spear_pipe", 40)
    group:item("spear_homemade_halfpike", 20)
    group:item("makeshift_glaive", 20)
    group:item("machete", 10)
    group:item("knife_meat_cleaver", 10)
    group:item("hatchet", 10)
    group:item("bat", 10)
    group:item("pipe", 10)
    content.add(group)
end
