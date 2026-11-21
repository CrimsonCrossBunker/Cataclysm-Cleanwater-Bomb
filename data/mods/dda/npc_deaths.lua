local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function global_number(key)
    return checked(services.variables.get_global_number(key)).value or 0
end

local function set_global(key, value)
    checked(services.variables.set_global(key, value, { include_before = false }))
end

local function fail_mission(avatar, name)
    local offset = 0
    repeat
        local page = services.missions.active(avatar, { offset = offset, limit = 256 })
        for _, mission in ipairs(page.items) do
            if mission.id.value == name and mission.in_progress then
                checked(services.missions.fail(avatar, mission.token))
                return
            end
        end
        offset = offset + page.returned
    until not page.has_more
end

local function run_mapgen_update(origin_omt, terrain_id, update_id)
    local target_omt = services.overmap.find_target(origin_omt, terrain_id)
    local tile = checked(services.overmap.tile_token(target_omt))
    local update = checked(services.mapgen.update_token(id("update_mapgen", update_id)))
    checked(services.mapgen.run_update(tile, update))
end

ccb.runtime.handler("godco_trader_mission_deathfail", function()
    set_global("godco_freemerch_representative_dead", 1)
    local avatar = services.characters.avatar()
    checked(services.variables.remove(avatar, "general_trade_u_think_suspicious_price",
        { include_before = false }))
    fail_mission(avatar, "MISSION_INVESTIGATE_TRADER")
end)

ccb.runtime.handler("isherwood_barry_death", function()
    ccb.tasks.after_avatar_turn(1, "isherwood_barry_death_followup")
end)

ccb.runtime.handler("isherwood_barry_death_followup", function(payload)
    local avatar = payload.character
    fail_mission(avatar, "MISSION_ISHERWOOD_CHRIS_1")
    set_global("is_barry_dead", "true")
    if global_number("isherwood_family_coming") == 1 then
        set_global("isherwood_barry_death_opinion", "blames_themselves")
        local avatar_omt = checked(services.creatures.snapshot(avatar)).position:project_to("omt")
        run_mapgen_update(avatar_omt, "isherwood_barry_rescue_field", "isherwood_rescue_remove_npcs")
        local target_omt = services.overmap.find_target(avatar_omt, "horse_farm_isherwood_13", { z = 0 })
        local origin_ms = target_omt:project_to("ms")
        local located = services.world.find_location(origin_ms,
            { kind = "furniture", id = id("furniture", "f_chair") },
            { target_max_radius = 30, min_radius = 0, max_radius = 0 })
        local dest = (located.found and located.position) or origin_ms
        set_global("isherwood_mission_success_return_map", dest)
        checked(services.relocation.teleport_creature(avatar, dest, { force = true }))
    else
        set_global("isherwood_barry_death_opinion", "blames_you")
    end
end, 1)

ccb.runtime.handler("robofac_chop_shop_scientist_death", function(context)
    set_global("robofac_chop_shop_scientist_1_is_dead", 1)
    if context.killer ~= nil
        and context.killer.subtype == "avatar"
        and global_number("robofac_chop_shop_mercs_spotted") == 1
        and global_number("robofac_chop_shop_scientist_1_kill_orders") ~= 1 then
        checked(services.factions.set_reputation(id("faction", "robofac"),
            { likes = -100, respects = -100, trusts = -100 }))
        local avatar = services.characters.avatar()
        local avatar_omt = checked(services.creatures.snapshot(avatar)).position:project_to("omt")
        run_mapgen_update(avatar_omt, "robofachq_surface_entrance", "remove_robofac_intercom")
        set_global("hub01_intercom_locked", 1)
    end
end)
