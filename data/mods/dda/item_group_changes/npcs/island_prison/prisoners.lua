local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_THUG_PRISONER_worn", kind = "collection" }
    group:group("male_underwear")
    group:entry {
        distribution = {
            { group = "clothing_prisoner_shoes" },
            { group = "cop_shoes" },
        },
    }
    group:entry {
        distribution = {
            { item = "buttonshirt", variant = "striped" },
            { group = "cop_torso" },
        },
    }
    group:entry {
        distribution = {
            { item = "striped_pants" },
            { group = "cop_pants" },
        },
    }
    group:entry {
        distribution = {
            { item = "tacvest" },
            { item = "kevlar" },
        },
        probability = 15,
    }
    group:group("socks_unisex")
    group:group("cop_gloves", 20)
    group:entry {
        distribution = {
            { item = "bandana" },
            { group = "cop_helmet" },
        },
        probability = 50,
    }
    group:group("clothing_glasses", 20)
    group:group("clothing_watch", 20)
    group:item("police_belt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_THUG_PRISONER_wield", kind = "distribution" }
    group:item("baton-extended", 50)
    group:item("PR24-retracted", 50)
    group:item("knife_small", 30, "knife_steak")
    group:item("knife_large", 30, "knife_chef")
    group:item("knife_small", 30, "knife_paring")
    group:item("knife_huge", 30, "knife_butcher")
    group:item("knife_cleaver", 30, "knife_meat_cleaver")
    group:item("knife_large", 30, "knife_carving")
    group:item("pointy_stick", 30)
    group:item("cudgel", 20)
    group:item("knuckle_nail", 20)
    group:item("spear_spike", 20)
    group:item("spear_knife", 15)
    group:item("makeshift_sap", 15)
    group:item("makeshift_knife", 15)
    group:item("nailboard", 15)
    group:item("sword_wood", 10)
    group:item("glass_shiv", 5)
    group:item("rock_sock", 5)
    group:item("sharp_toothbrush", 5)
    group:item("chisel", 5)
    group:item("scissors", 5)
    group:item("screwdriver", 5)
    group:item("knife_small", 5, "knife_steak")
    group:item("knuckle_brass", 3)
    group:item("knuckle_steel_forged", 2)
    group:item("switchblade", 5)
    group:item("throwing_knife", 5)
    group:entry {
        distribution = {
            {
                group = "longguns_cop",
                contents = {
                    { item = "shoulder_strap" },
                },
                probability = 20,
            },
            { group = "sidearms_cop", probability = 80 },
        },
        probability = 50,
    }
    content.add(group)
end
