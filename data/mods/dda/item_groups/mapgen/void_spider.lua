local content = require("ccb").content

do
    local group = content.ItemGroup { id = "void_spider_nest", kind = "distribution" }
    group:entry { item = "egg_void_spider", count = { 1, 6 } }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "void_spider_corpse_mayor_loot",
        kind = "collection",
        with_ammo = 100,
        with_magazine = 100,
        container = "corpse_void_mummified",
        overflow = "spill",
    }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "grenade_emp", count = { 1, 3 } },
                    { item = "hk_g80" },
                    { item = "hk_g80mag", count = { 1, 3 } },
                    { item = "12mm", count = { 3, 6 } },
                    { item = "UPS_OFF" },
                    { item = "rm13_armor" },
                },
                probability = 10,
            },
            {
                collection = {
                    { item = "holo_cloak" },
                    { item = "standard_template_construct" },
                    {
                        item = "exodii_plasma_projectile",
                        contents = {
                            { item = "condenser_pristine" },
                        },
                    },
                },
                probability = 10,
            },
            {
                collection = {
                    { item = "jade_nagamaki", damage = { 0, 2 } },
                    { item = "greatbow_meteor", damage = { 0, 1 } },
                    { item = "armor_star_samurai", damage = { 0, 1 } },
                    { item = "armor_star_samurai_mask", damage = { 0, 1 } },
                    { item = "armor_star_samurai_torso", damage = { 0, 1 } },
                    { item = "armor_star_samurai_shoulder", damage = { 0, 1 } },
                    { item = "armor_star_samurai_shoulder", damage = { 0, 1 } },
                    { item = "armor_star_samurai_legs", damage = { 0, 1 } },
                    { item = "armor_star_samurai_helmet_destroyed" },
                    { item = "arrow_meteor", count = { 1, 2 }, probability = 40 },
                },
                probability = 10,
            },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "void_spider_corpse_minor_loot",
        kind = "distribution",
        container = "corpse_void_mummified",
        overflow = "spill",
    }
    group:item("longrifle_flintlock", 10, "leadworks_longrifle_flintlock")
    group:item("helmet_kettle", 10, "morion")
    group:item("golden_hat", 10)
    group:item("towel", 10)
    group:item("tattered_garment", 10)
    group:entry {
        group = "amigara_items",
        artifact = { preset = "cult", power_level = 1250, max_attributes = 4, max_negative_power = -1000, resonant = true },
        probability = 15,
    }
    group:entry {
        group = "ps_artifacts",
        artifact = {
            preset = "netherum_tunnels",
            power_level = 750,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
        probability = 15,
    }
    group:item("altered_exposed_wiring_prototype", 10)
    group:item("bead_bracelet", 10)
    group:item("cape_sci_fi", 10)
    content.add(group)
end
