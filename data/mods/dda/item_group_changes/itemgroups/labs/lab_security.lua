local content = require("ccb").content

do
    local group = content.ItemGroup { id = "SUS_electromagnetic_loot", kind = "distribution" }
    group:group("SUS_hk_g80", 60)
    content.add(group)
end

do
    -- This group is for rare spawns of rivetech matched sets.
    local group = content.ItemGroup { id = "SUS_rivtech_loot", kind = "distribution" }
    group:group("SUS_rivtech_8x40", 80)
    group:group("SUS_rivtech_40mm", 60)
    group:group("SUS_rivtech_misc", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_rivtech_8x40_mag", kind = "distribution" }
    group:item("8x40_100_mag", 10)
    group:item("8x40_10_mag", 80)
    group:item("8x40_25_mag", 60)
    group:item("8x40_50_mag", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_rivtech_8x40_rm", kind = "distribution" }
    group:item("rm103a_pistol", 80)
    group:item("rm11b_sniper_rifle", 10)
    group:item("rm51_assault_rifle", 30)
    group:item("rm2000_smg", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "SUS_rivtech_40mm_rm", kind = "distribution" }
    group:entry { item = "rm451_flamethrower", charges = { 100, 1000 }, probability = 20 }
    content.add(group)
end
