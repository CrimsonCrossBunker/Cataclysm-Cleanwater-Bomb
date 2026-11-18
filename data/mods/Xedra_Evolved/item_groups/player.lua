local content = require("ccb").content

do
    local group = content.ItemGroup { id = "diazepam_scrip", kind = "collection" }
    group:entry { item = "diazepam", count = { 20, 20 }, wrapper = "bottle_plastic_pill_prescription", container = "null" }
    content.add(group)
end

do
    -- This item group gives a random cryptid map and the associated notes when starting as a cryptid hunter.  The probabilities are intended to be equal with each other.
    local group = content.ItemGroup { id = "random_cryptid_map", kind = "distribution" }
    group:group("deathworm_map", 50)
    group:group("sevenoclock_map", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "deathworm_map", kind = "collection" }
    group:item("deathworm_map")
    group:item("deathworm_note")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sevenoclock_map", kind = "collection" }
    group:item("sevenoclock_map")
    group:item("sevenoclock_note")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quiver_crossbow_low_vampire_hunter", kind = "collection" }
    group:entry { item = "bolt_steel", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quiver_crossbow_vampire_hunter", kind = "collection" }
    group:entry { item = "bolt_cf", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "suppressed_fn57", kind = "collection" }
    group:entry { item = "fn57mag", charges = { 20, 20 }, ammo = { item = "57mm_ss" } }
    group:entry { item = "fn57mag", charges = { 20, 20 }, ammo = { item = "57mm_ss" } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "torso_grenade_bandolier_jotunn", kind = "collection" }
    group:entry { item = "torso_bandolier_grenade", charges = { 3, 3 }, ammo = { item = "40x46mm_m576" } }
    content.add(group)
end
