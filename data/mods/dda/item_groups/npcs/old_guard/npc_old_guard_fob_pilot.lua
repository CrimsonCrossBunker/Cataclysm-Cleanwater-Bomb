local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_OG_PILOT_misc", kind = "collection" }
    group:item("whistle")
    group:item("matches")
    group:item("flashlight")
    group:entry { item = "handflare", count = { 2, 2 } }
    group:item("glock17_17", 25)
    group:item("goggles_nv")
    group:group("knife_rambo_cont", 85)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OG_PILOT_worn", kind = "collection" }
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
    group:item("mil_flight_suit")
    group:item("flight_helmet")
    group:item("jacket_army", 40)
    group:item("legrig")
    group:item("boots_combat")
    group:entry {
        distribution = {
            { item = "nomex_gloves", probability = 45 },
            { item = "gloves_tactical", probability = 35 },
            { item = "gloves_leather", probability = 20 },
        },
    }
    group:group("clothing_watch", 85)
    group:entry { item = "glock17_17", charges = { 17, 17 }, container = "tacvest", ammo = { item = "9mmfmj" } }
    group:entry { item = "glock_17", charges = { 17, 17 }, container = "holster", ammo = { item = "9mmfmj" } }
    content.add(group)
end
