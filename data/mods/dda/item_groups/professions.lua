local content = require("ccb").content

do
    local group = content.ItemGroup { id = "holster_glock19_fed", kind = "collection" }
    group:entry {
        item = "glock_19",
        charges = { 15, 15 },
        variant = "glock_19_cop",
        contents = {
            { item = "red_dot_sight" },
            { item = "sights_mount_pistol" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "army_grenades_40x46", kind = "collection" }
    group:entry { item = "40x46mm_m433", charges = { 4, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_cell_phone", kind = "collection" }
    group:entry { item = "cell_phone", charges = { 150, 150 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_laptop", kind = "collection" }
    group:entry { item = "laptop", charges = { 600, 600 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_soldering_iron", kind = "collection" }
    group:entry { item = "soldering_iron_portable", charges = { 150, 150 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_flashlight", kind = "collection" }
    group:entry { item = "flashlight", charges = { 300, 300 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_heavy_flashlight", kind = "collection" }
    group:entry { item = "heavy_flashlight", charges = { 300, 300 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_mp3", kind = "collection" }
    group:entry { item = "mp3", charges = { 150, 150 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_ref_lighter", kind = "collection" }
    group:entry { item = "ref_lighter", charges = { 50, 50 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_cigs", kind = "collection" }
    group:entry { item = "cig", count = { 20, 20 }, wrapper = "box_cigarette", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "rolling_cigs", kind = "collection" }
    group:entry { item = "tobacco", count = { 20, 20 }, wrapper = "bag_plastic", container = "null" }
    group:entry { item = "rolling_paper", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pipe_smoke", kind = "collection" }
    group:entry { item = "tobacco", count = { 20, 20 }, wrapper = "bag_plastic", container = "null" }
    group:item("pipe_tobacco")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "weed_pack", kind = "collection" }
    group:entry { item = "weed", count = { 5, 5 }, wrapper = "bag_zipper", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "can_o_beans", kind = "collection" }
    group:entry { item = "can_beans", count = { 2, 2 }, wrapper = "can_medium", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_aspirin", kind = "collection" }
    group:entry { item = "aspirin", count = { 20, 20 }, wrapper = "bottle_plastic_pill_painkiller", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_antibiotic", kind = "collection" }
    group:entry { item = "antibiotics", count = { 10, 10 }, wrapper = "bottle_plastic_pill_prescription", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "charged_matches", kind = "collection" }
    group:entry { item = "matches", charges = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quiver_modern_archer", kind = "collection" }
    group:entry { item = "arrow_cf", count = { 16, 16 } }
    group:item("bow_sight")
    group:item("bow_stabilizer_set")
    group:item("manual_archery")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_shotgun_hunter", kind = "collection" }
    group:entry { item = "shot_00", charges = { 18, 18 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_rifle_hunter", kind = "collection" }
    group:entry { item = "270win_jsp", charges = { 16, 16 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_swat_cqc1", kind = "collection" }
    group:entry { item = "shot_00", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_swat_cqc2", kind = "collection" }
    group:entry { item = "shot_slug", charges = { 12, 12 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "quiver_naturalist", kind = "collection" }
    group:entry { item = "arrow_wood", count = { 20, 20 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_ww_gunslinger", kind = "collection" }
    group:entry { item = "45colt_jhp", charges = { 18, 18 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bandolier_cowboy", kind = "collection" }
    group:entry { item = "357mag_jhp", charges = { 18, 18 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dog_lover_bag", kind = "collection" }
    group:item("rubber_harness_dog")
    group:item("rubber_harness_dog")
    group:item("dog_whistle")
    group:entry { item = "dogfood_dry", count = { 4, 4 }, wrapper = "bag_plastic", container = "null" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ninja_grenade_pouch", kind = "collection" }
    group:item("flashbang")
    group:item("flashbang")
    group:item("smokebomb")
    group:item("smokebomb")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "leg_sheath6_throwing_knives", kind = "collection" }
    group:item("throwing_knife")
    group:item("throwing_knife")
    group:item("throwing_knife")
    group:item("throwing_knife")
    group:item("throwing_knife")
    group:item("throwing_knife")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "flintlock_pouch_skyfarer", kind = "collection" }
    group:entry { item = "36navy", charges = { 14, 14 } }
    content.add(group)
end
