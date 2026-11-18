local content = require("ccb").content

do
    local group = content.ItemGroup { id = "survivor_bashing", kind = "distribution" }
    group:item("bat_metal", 5)
    group:item("bwirebat", 20)
    group:item("crowbar", 5)
    group:item("nailboard", 25)
    group:item("makeshift_crowbar", 35)
    group:item("nailbat", 25)
    group:item("pipe", 10)
    group:item("spear_rebar", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_cutting", kind = "distribution" }
    group:item("ax", 5)
    group:item("hatchet", 5)
    group:item("machete", 5)
    group:item("makeshift_halberd", 5)
    group:item("makeshift_machete", 15)
    content.add(group)
end

do
    -- Survivor piercing weapons other than knives
    local group = content.ItemGroup { id = "survivor_stabbing", kind = "distribution" }
    group:item("spear_copper", 1)
    group:item("spear_steel", 1)
    group:item("spear_knife", 15)
    group:item("spear_pipe", 10)
    group:item("spear_spike", 15)
    group:item("spear_stone", 15)
    group:item("spear_rebar", 10)
    group:item("spear_wood", 20)
    group:item("spear_homemade_halfpike", 15)
    content.add(group)
end
