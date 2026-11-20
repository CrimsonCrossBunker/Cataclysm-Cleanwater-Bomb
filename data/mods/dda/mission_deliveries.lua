local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function has_item(character, item)
    return services.inventory.has_type(character, id("item", item)).value
end

local function delivery(goal, collect, items)
    ccb.runtime.handler(goal, function(context)
        return services.inventory.has_items_sum(context.speaker, items).value
    end)
    ccb.runtime.handler(collect, function(context)
        services.inventory.consume_dialogue_sum(context.character, nil, "alpha", items)
    end)
end

ccb.runtime.handler("clear_trait_has_nemesis", function(context)
    services.mutations.erase(context.character, id("mutation", "HAS_NEMESIS"))
end)

ccb.runtime.handler("deliver_angle_grinder_1_items", function(context)
    services.inventory.consume_by_type(context.character, id("item", "angle_grinder"), 1, 0)
end)

ccb.runtime.handler("deliver_hacksaw_1_items", function(context)
    services.inventory.consume_by_type(context.character, id("item", "hacksaw"), 1, 0)
end)

delivery("complete_mission_free_merchants_evac_4", "deliver_mission_free_merchants_evac_4", {
    { item = id("item", "ground_solar_panel_v2"), amount = 5 },
    { item = id("item", "ground_solar_panel"), amount = 10 },
})

delivery("complete_mission_godco_helena_1", "deliver_mission_godco_helena_1", {
    { item = id("item", "pipe_cpvc"), amount = 200 },
    { item = id("item", "pipe"), amount = 200 },
    { item = id("item", "cu_pipe"), amount = 200 },
})

delivery("complete_mission_godco_katherine_1", "deliver_mission_godco_katherine_1", {
    { item = id("item", "can_sardine"), amount = 3 },
    { item = id("item", "can_tuna"), amount = 3 },
    { item = id("item", "can_salmon"), amount = 3 },
})

delivery("complete_mission_godco_russell_trophy2", "deliver_mission_godco_russell_trophy2", {
    { item = id("item", "egg_spider_cellar"), amount = 1 },
    { item = id("item", "egg_spider_jumping"), amount = 1 },
    { item = id("item", "egg_spider_trapdoor"), amount = 1 },
    { item = id("item", "egg_spider_web"), amount = 1 },
    { item = id("item", "egg_spider_widow"), amount = 1 },
    { item = id("item", "egg_spider_wolf"), amount = 1 },
})

delivery("complete_mission_lumbermill_get_6_blankets", "deliver_mission_lumbermill_get_6_blankets", {
    { item = id("item", "blanket"), amount = 6 },
    { item = id("item", "fur_blanket"), amount = 6 },
    { item = id("item", "down_blanket"), amount = 6 },
    { item = id("item", "blanket_weighted"), amount = 6 },
    { item = id("item", "quilt"), amount = 6 },
    { item = id("item", "quilt_patchwork"), amount = 6 },
    { item = id("item", "electric_blanket"), amount = 6 },
})

delivery("complete_mission_ranch_foreman_2", "deliver_mission_ranch_foreman_2", {
    { item = id("item", "blanket"), amount = 25 },
    { item = id("item", "fur_blanket"), amount = 25 },
    { item = id("item", "down_blanket"), amount = 25 },
    { item = id("item", "blanket_weighted"), amount = 25 },
    { item = id("item", "electric_blanket"), amount = 25 },
})

delivery("complete_mission_ranch_scavenger_1", "deliver_mission_ranch_scavenger_1", {
    { item = id("item", "spear_knife"), amount = 12 },
    { item = id("item", "spear_knife_superior"), amount = 12 },
    { item = id("item", "spear_knife_proper"), amount = 12 },
})

ccb.runtime.handler("complete_mission_ranch_scrapper_tools_for_scrap", function(context)
    return has_item(context.speaker, "angle_grinder")
        and has_item(context.speaker, "hacksaw")
end)
