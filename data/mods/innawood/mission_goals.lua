local ccb = require("ccb")
local services = ccb.services

local function has_item(character, item)
    return services.inventory.has_type(character, services.types.id("item", item)).value
end

ccb.runtime.handler("complete_mission_get_antibiotics_cattail_jelly", function(context)
    return has_item(context.speaker, "cattail_jelly")
end)

ccb.runtime.handler("complete_mission_get_inhaler_spurge_tea", function(context)
    return has_item(context.speaker, "spurge_tea")
end)

ccb.runtime.handler("complete_mission_learn_about_cattail_jelly_backpack_leather", function(context)
    return has_item(context.speaker, "backpack_leather")
        and services.inventory.has_items(context.speaker, services.types.id("item", "cattail_stalk"), 80, 0).value
        and services.skills.level(context.speaker, "survival").value >= 1
end)
