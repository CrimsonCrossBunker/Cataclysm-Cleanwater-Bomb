local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_robofac_generic_security_worn", kind = "collection" }
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("socks")
    group:item("jumpsuit", 100, "robofac")
    group:item("tac_helmet")
    group:group("military_ballistic_vest_pristine")
    group:group("clothing_watch")
    group:entry {
        distribution = {
            { group = "clothing_glasses" },
            { item = "glasses_bal" },
        },
    }
    group:item("gloves_tactical", 60)
    group:item("boots_combat")
    group:group("clothing_watch")
    group:item("holster")
    group:item("legrig")
    group:item("legrig", 30)
    group:item("tacvest")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "robofac_sec_weapon_mods", kind = "collection" }
    group:entry {
        distribution = {
            { item = "holo_sight", probability = 50 },
            { item = "acog_scope", probability = 30 },
        },
    }
    group:item("shoulder_strap")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_robofac_generic_security_misc", kind = "collection" }
    group:item("grenade_emp", 33)
    group:entry {
        collection = {
            { item = "glock_17", charges = { 22, 22 }, ammo = { item = "9mmP" } },
            { item = "glock17_22", count = { 1, 2 }, charges = { 22, 22 }, ammo = { item = "9mmP" } },
            { item = "9mmP", count = { 1, 2 } },
            { item = "stanag30", count = { 1, 2 }, charges = { 30, 30 }, ammo = { item = "556" } },
            { item = "556", count = { 2, 2 } },
        },
    }
    group:item("grenade", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_robofac_security_weapon", kind = "collection" }
    group:entry {
        group = "h&k416a5_default_or_short",
        charges = { 30, 30 },
        contents = {
            { group = "robofac_sec_weapon_mods" },
        },
    }
    content.add(group)
end
