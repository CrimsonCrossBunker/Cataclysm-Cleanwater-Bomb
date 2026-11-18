local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NPC_ROBOFAC_MERC_PAT_worn", kind = "collection" }
    group:item("boxer_shorts")
    group:item("tshirt")
    group:item("hat_ball")
    group:item("jacket_evac")
    group:item("socks")
    group:item("robofac_enviro_suit_casual")
    group:item("smart_watch_adv")
    group:item("ar_glasses_advanced")
    group:entry { item = "colt_python", container = "XL_holster" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NPC_ROBOFAC_MERC_PAT_carry", kind = "collection" }
    group:entry { item = "RobofacCoin", count = { 15, 18 } }
    group:group("charged_smart_phone")
    content.add(group)
end
