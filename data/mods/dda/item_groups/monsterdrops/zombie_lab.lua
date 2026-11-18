local content = require("ccb").content

do
    local group = content.ItemGroup { id = "security_gear", kind = "collection" }
    group:entry {
        distribution = {
            { group = "full_1st_aid" },
            { group = "full_ipok" },
        },
        probability = 30,
    }
    group:entry { item = "heavy_flashlight", charges = { 0, 100 }, probability = 50 }
    group:entry { item = "two_way_radio", charges = { 0, 100 } }
    group:item("whistle")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "security_armor", kind = "distribution" }
    group:entry {
        collection = {
            { item = "tacvest" },
            { item = "kevlar" },
        },
    }
    group:item("soft_3a_vest", 100, "security_armor_vest")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_labsecurity_death_drops", kind = "collection" }
    group:group("default_zombie_items_pockets")
    group:entry { group = "security_armor", damage = { 0, 4 } }
    group:group("security_gear")
    group:entry { group = "cop_gloves", damage = { 0, 4 }, probability = 40 }
    group:entry { item = "throat_guard_cut_resistant", damage = { 0, 4 }, probability = 5 }
    group:entry {
        collection = {
            { item = "pants", damage = { 0, 4 }, variant = "pants_black" },
            {
                distribution = {
                    { item = "leather_belt", damage = { 0, 4 } },
                    {
                        item = "webbing_belt",
                        damage = { 0, 4 },
                        contents = {
                            { item = "dump_pouch" },
                        },
                    },
                },
            },
        },
    }
    group:entry { group = "security_shoes", damage = { 0, 4 } }
    group:entry { item = "dress_shirt", damage = { 0, 4 } }
    group:item("dog_tag", 20)
    group:entry {
        collection = {
            { item = "tazer", charges = { 250, 500 }, damage = { 0, 4 } },
            {
                distribution = {
                    {
                        collection = {
                            { item = "holster", damage = { 0, 4 } },
                            { item = "m9", charges = { 0, 15 }, damage = { 0, 4 } },
                            { item = "m9mag", count = { 1, 2 }, charges = { 0, 15 }, damage = { 0, 4 } },
                        },
                    },
                    {
                        distribution = {
                            { item = "baton-extended", damage = { 0, 4 } },
                            { item = "PR24-extended", damage = { 0, 4 } },
                        },
                    },
                },
            },
        },
        probability = 90,
    }
    group:entry { group = "underwear", damage = { 0, 4 } }
    group:entry { group = "socks_unisex", damage = { 0, 4 } }
    group:entry { group = "clothing_glasses", damage = { 0, 4 } }
    group:entry { group = "clothing_watch", damage = { 0, 4 } }
    group:entry { group = "wallets", damage = { 0, 4 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_devourer_lab_sec_death_drops", kind = "collection" }
    group:entry { group = "mon_zombie_labsecurity_death_drops", count = { 4, 6 } }
    group:item("id_science_security_black")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "phase_zombie_death_drops", kind = "collection" }
    group:entry {
        distribution = {
            { item = "broken_dimensional_anchor", count = { 1, 1 }, charges = { 0, 1500 }, damage = { 1, 4 }, probability = 19 },
            { item = "dimensional_anchor", count = { 1, 1 }, probability = 1 },
        },
    }
    group:entry { item = "xedra_enviro_suit", damage = { 1, 4 } }
    content.add(group)
end
