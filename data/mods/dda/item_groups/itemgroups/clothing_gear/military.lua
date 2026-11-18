local content = require("ccb").content

do
    -- Base clothing entries for Navy personnel like sailors, Marines, SEALs, etc. Leaving out entries for boots and pants in order to define them in the individual drops for the monsters themselves, so as to give the appropriate type of boots and army pants pattern to the appropriate types of personnel.
    local group = content.ItemGroup { id = "clothing_navy", kind = "collection" }
    group:group("clothing_soldier_shirt")
    group:entry {
        distribution = {
            { item = "jacket_army_modern", probability = 50 },
            { item = "combat_shirt", probability = 50 },
        },
    }
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
        },
    }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "sports_bra" },
                    { item = "boy_shorts" },
                },
            },
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
        },
    }
    content.add(group)
end

do
    -- Base clothing entries for Navy officers.
    local group = content.ItemGroup { id = "clothing_navy_officer", kind = "collection" }
    group:entry { item = "boots", damage = { 0, 4 } }
    group:entry { item = "hat_navy", damage = { 0, 4 } }
    group:entry { item = "officer_uniform", damage = { 0, 4 } }
    group:entry {
        distribution = {
            { item = "socks", probability = 30 },
            { item = "nomex_socks", probability = 70 },
        },
    }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "sports_bra" },
                    { item = "boy_shorts" },
                },
            },
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
        },
    }
    content.add(group)
end

do
    -- Standard (non-winter) set of clothes worn by soldiers and paramilitary forces.
    local group = content.ItemGroup { id = "clothing_military", kind = "collection" }
    group:group("clothing_soldier_shirt")
    group:entry {
        distribution = {
            { item = "jacket_army_modern", probability = 50 },
            { item = "combat_shirt", probability = 50 },
        },
    }
    group:item("pants_army")
    group:group("loaded_webbing_belt")
    group:entry {
        distribution = {
            { item = "socks", probability = 95 },
            { item = "socks_wool", probability = 5 },
        },
    }
    group:item("boots_combat")
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "sports_bra" },
                    { item = "boy_shorts" },
                },
            },
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
        },
    }
    content.add(group)
end

do
    -- todo: when #57228 would be closed, change this one to copy-from `clothing_military`
    local group = content.ItemGroup { id = "clothing_military_distribution", kind = "distribution" }
    group:group("clothing_soldier_shirt")
    group:entry {
        distribution = {
            { item = "jacket_army_modern", probability = 50 },
            { item = "combat_shirt", probability = 50 },
        },
    }
    group:item("pants_army")
    group:group("loaded_webbing_belt")
    group:entry {
        distribution = {
            { item = "socks", probability = 95 },
            { item = "socks_wool", probability = 5 },
        },
    }
    group:item("boots_combat")
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "sports_bra" },
                    { item = "boy_shorts" },
                },
            },
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
        },
    }
    content.add(group)
end

do
    -- Winter set of clothes worn by soldiers and paramilitary forces.
    local group = content.ItemGroup { id = "clothing_military_winter", kind = "collection" }
    group:group("clothing_soldier_shirt")
    group:item("winter_jacket_army")
    group:item("winter_pants_army")
    group:group("loaded_webbing_belt")
    group:entry {
        distribution = {
            { item = "socks", probability = 10 },
            { item = "socks_wool", probability = 90 },
        },
    }
    group:item("boots_combat")
    group:entry {
        collection = {
            {
                distribution = {
                    { item = "balclava", variant = "black", probability = 90 },
                    { item = "balaclava_cut_resistant", probability = 10 },
                },
            },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "sports_bra" },
                    { item = "boy_shorts" },
                },
            },
            {
                distribution = {
                    { item = "briefs" },
                    { item = "boxer_briefs" },
                    { item = "boxer_shorts" },
                },
            },
        },
    }
    content.add(group)
end

do
    -- Standard (non-winter) set of clothes and combat gear worn by soldiers and paramilitary forces.
    local group = content.ItemGroup { id = "clothing_soldier_set_pristine", kind = "collection" }
    group:group("clothing_military")
    group:item("elbow_pads", 10)
    group:item("knee_pads", 85)
    group:entry {
        distribution = {
            { group = "army_helmet_nvg", probability = 20 },
            { item = "helmet_army", probability = 80 },
        },
        probability = 80,
    }
    group:item("gloves_tactical", 60)
    group:group("military_ballistic_vest_pristine", 90)
    group:group("molle_backpacks_and_accessories", 85)
    group:group("clothing_tactical_leg", 15)
    group:entry {
        distribution = {
            { group = "clothing_glasses", probability = 60 },
            { item = "glasses_bal", probability = 30 },
        },
        probability = 20,
    }
    group:group("clothing_watch", 5)
    content.add(group)
end

do
    -- Set of clothes and combat gear worn by heavier soldiers and paramilitary forces including IOTV armor.
    local group = content.ItemGroup { id = "clothing_soldier_heavy_set", kind = "collection" }
    group:group("clothing_military")
    group:item("elbow_pads", 10)
    group:item("knee_pads", 85)
    group:entry {
        distribution = {
            { group = "army_helmet_nvg", probability = 20 },
            { item = "helmet_army", probability = 80 },
        },
        probability = 80,
    }
    group:item("gloves_tactical", 60)
    group:group("military_ballistic_vest_heavy", 90)
    group:group("molle_backpacks_and_accessories", 85)
    group:group("clothing_tactical_leg", 15)
    group:entry {
        distribution = {
            { group = "clothing_glasses", probability = 60 },
            { item = "glasses_bal", probability = 30 },
        },
        probability = 20,
    }
    group:group("clothing_watch", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clothing_soldier_shirt", kind = "distribution" }
    group:item("tshirt")
    content.add(group)
end

do
    -- Standard set of hats worn by a uniformed soldier.
    local group = content.ItemGroup { id = "clothing_military_headwear", kind = "distribution" }
    group:item("beret", 40)
    group:item("hat_field", 35)
    group:item("hat_boonie", 23)
    group:item("turban", 1)
    group:item("headscarf", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "eod_armor", kind = "distribution" }
    group:entry {
        collection = {
            { item = "helmet_eod", charges = { 0, 500 } },
            { item = "jacket_eod" },
            { item = "trousers_eod" },
            { item = "foot_protectors_eod" },
            { item = "gloves_eod", probability = 20 },
        },
    }
    group:entry {
        collection = {
            { item = "jacket_eod_light" },
            { item = "face_shield_eod" },
            { item = "trousers_eod_light" },
        },
        probability = 20,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mil_armor_pants", kind = "distribution" }
    group:item("pants_army", 10)
    group:item("winter_pants_army", 40)
    group:item("pants", 75)
    group:item("pants_cargo", 70)
    group:item("legrig", 10)
    group:item("knee_pads", 20)
    content.add(group)
end
