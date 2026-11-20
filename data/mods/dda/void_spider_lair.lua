local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local state = require("portal_storm_state")
local portals = require("trap_portals")

local function enter(actor)
    if state.number("void_spider_killed") == 1 then return end
    portals.travel(actor, "spider_dimension", ccb.services.translate("The abyss opens up around you."), ccb.services.translate("Nothing happens."))
    local floor = portals.destination(actor, "void_spider_lair", { z = -1 }, "terrain", "t_nether_glass_floor_basalt", 26)
    actor = portals.teleport(actor, floor)
    if actor.subtype == "avatar" or actor.subtype == "npc" then
        ccb.tasks.after_character_turn(actor, 1, "void_spider_lair_tick")
    end
end
portals.trap("enter_void_spider_lair", enter)

local function count(actor, monster)
    return state.checked(services.monsters.count_nearby(state.position(actor), { id("monster", monster) }))
end

local function has_effect(actor, effect)
    return state.checked(services.effects.has(actor, id("effect", effect)))
end

local function try_summon(actor, chance)
    if services.random.native_int(0, chance - 1) == 0 and count(actor, "mon_void_spider") < 1
        and state.number("void_spider_killed") ~= 1 then
        state.message(actor, ccb.services.translate("The emptiness shifts unnervingly, something is nearby."), "neutral", true)
        state.checked(services.characters.cast_spell(actor, id("spell", "place_void_spider"), { hit_self = true }))
    end
end

ccb.runtime.handler("void_spider_lair_tick", function(payload)
    local actor = payload.character
    if not services.overmap.matches_location(state.position(actor):project_to("omt"), "void_spider_lair") then return end
    ccb.tasks.after_character_turn(actor, 1, "void_spider_lair_tick")
    if has_effect(actor, "webbed") then try_summon(actor, 6) end
    try_summon(actor, 120)
    if (has_effect(actor, "webbed") or has_effect(actor, "grabbed")) and count(actor, "mon_void_spider") == 1
        and count(actor, "mon_void_spider_maw") < 4 then
        state.checked(services.spawns.population(id("monster", "mon_void_spider_maw"), state.position(actor), {
            min_radius = 2, max_radius = 4,
            lifespan = { minimum = services.time.duration(15, "second"), maximum = services.time.duration(25, "second") },
        }))
    end
end)

ccb.runtime.handler("touch_void_weaver_effigy", function(ctx)
    state.set("void_spider_killed", 0)
    state.set("void_spider_nest_eggs_spawned", 0)
    state.set("void_spider_nest_corpses_spawned", 0)
    if ctx.character then enter(ctx.character) end
    return 0
end)
local effigy = ccb.content.Item {
    id = "void_spider_test_item", name = ccb.content.plural_text("void weaver effigy", "void weaver effigy"),
    description = ccb.content.text("The severed leg of a void weaver, turned into some macabre ornament."),
    mass_grams = 1, volume_ml = 250, price_cents = 3000, price_postapoc_cents = 10000, symbol = "!", color = "light_red",
}
effigy:tool({})
effigy:on_use("touch_void_weaver_effigy", ccb.content.text("Activate"), ccb.content.text("Touch the effigy."))
ccb.content.add(effigy)
