local content = require("ccb").content

content.add(content.ItemMigration {
    from = {
        "warpheal_stone",
        "warpstat_stone",
        "warp_portalstorm_ender",
        "warpdifficulty_stone",
    },
    to = "rock",
})

content.add(content.Blacklist { kind = "item" }:entry("flyer_evac"))
