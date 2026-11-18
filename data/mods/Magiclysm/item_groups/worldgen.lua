local content = require("ccb").content

do
    -- stuff the goblins are storing in their racks, weapons, utils and such
    local group = content.ItemGroup { id = "orc_village_storage", kind = "distribution" }
    group:entry { group = "orc_village_foodstuffs", count = { 0, 3 }, probability = 70 }
    group:item("spell_scroll_bio_bonespear", 1)
    group:entry { item = "arrow_wood_heavy", count = { 0, 5 }, probability = 40 }
    group:item("bone_knife", 40)
    group:item("bowl_skull", 30)
    group:item("bowl_wood", 60)
    group:item("skewer_bone", 20)
    group:item("copper_ax", 10)
    group:entry { item = "throwing_axe", count = { 2, 8 }, probability = 10 }
    group:item("spear_wood", 10)
    group:item("spear_copper", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "balrog_mine_weapons", kind = "distribution" }
    group:item("longsword")
    group:item("arming_sword")
    group:item("zweihander")
    group:item("broadsword")
    group:item("spear_knife_superior")
    group:item("spear_copper")
    group:item("spear_steel")
    group:item("halberd")
    group:item("glaive")
    group:item("pike")
    group:item("pike_copper")
    group:item("poleaxe")
    group:item("2h_flail_steel")
    group:item("battleaxe")
    group:item("lucern_hammer")
    group:item("mace")
    group:item("morningstar")
    group:item("warhammer")
    content.add(group)
end

do
    -- stuff the goblins 'eat', mostly there for flavor, pun intended
    local group = content.ItemGroup {
        id = "orc_village_foodstuffs",
        kind = "collection",
        container = "bag_canvas",
        overflow = "spill",
    }
    group:item("skull_human", 10)
    group:item("human_tallow", 2)
    group:item("bone_human", 20)
    group:item("human_tallow", 15)
    group:entry { item = "wastebread", count = { 0, 8 }, probability = 70 }
    group:entry { item = "dry_fruit", count = { 0, 8 }, probability = 70 }
    group:entry { item = "dry_veggy", count = { 0, 8 }, probability = 70 }
    group:entry {
        item = "meat_salted",
        count = { 0, 3 },
        components = {
            "human_flesh",
            "salt",
        },
        probability = 50,
    }
    group:entry { item = "meat_salted", count = { 0, 8 }, probability = 50 }
    group:entry {
        item = "meat_smoked",
        count = { 0, 3 },
        components = {
            "human_flesh",
        },
        probability = 70,
    }
    group:entry { item = "meat_smoked", count = { 0, 8 }, probability = 50 }
    content.add(group)
end
