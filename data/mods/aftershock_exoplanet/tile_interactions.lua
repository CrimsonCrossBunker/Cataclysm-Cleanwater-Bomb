local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function ask(actor, question, default)
    if actor.subtype == "avatar" then
        return services.interaction.confirm(question)
    end
    return default
end

local function message(ctx, text, severity, show_popup)
    if ctx.character.subtype ~= "avatar" then
        return
    end
    local point = ctx.position
    local position = services.coords.tripoint_abs_ms(point.x, point.y, point.z)
    text = checked(services.text.expand_for(text, ctx.character, nil, nil,
        { this = ctx.furniture_id, pos = position }, true))
    if show_popup then
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
    end
    services.messages.add(text, severity)
end

local function transform_radius(actor, radius, transform)
    local point = checked(services.creatures.snapshot(actor)).position
    checked(services.world.transform_radius(point, radius, id("terrain_furniture_transform", transform)))
end

ccb.runtime.handler("examine_t_afs_starcrane_control", function(ctx)
    local actor = ctx.character
    checked(services.characters.open_topic(actor, "THI_CONTROL_START"))
end)

ccb.runtime.handler("examine_t_afs_gun_ship_engine_console", function(ctx)
    local actor = ctx.character
    if ask(actor, ccb.services.translate("Do you want to overload the ship's drive?"), true) then
        message(ctx, ccb.services.translate("You hear a high pitched whine start and increase in volume."),
            "neutral", true)
        checked(services.characters.cast_spell(actor, id("spell", "gunship_drive_overload")))
        transform_radius(actor, 5, "engine_overload_transform")
    end
end)

ccb.runtime.handler("examine_t_afs_gun_ship_engine_console_burnt", function(ctx)
    local actor = ctx.character
    if ask(actor, ccb.services.translate("Do you want to overload the ship's drive?"), true) then
        message(ctx, ccb.services.translate("The engine is burnt out and worthless."), "neutral", true)
    end
end)

ccb.runtime.handler("examine_t_cell_entrance_console", function(ctx)
    local actor = ctx.character
    if ask(actor, ccb.services.translate("Do you want to open the cell?"), true) then
        message(ctx, ccb.services.translate("The cell grates retract into the floor and ceiling."), "neutral", true)
        transform_radius(actor, 5, "transform_gratings")
    end
end)

local function ship_setting(key)
    return checked(services.variables.get_global_number(key)).value or 0
end

local function store_ship_setting(key, value)
    checked(services.variables.set_global(key, value, { include_before = false }))
end

local function apply_ship_update(position, name)
    local target = checked(services.overmap.tile_token(position:project_to("omt")))
    local update = checked(services.mapgen.update_token(id("update_mapgen", name)))
    checked(services.mapgen.run_update(target, update))
end

ccb.runtime.handler("examine_f_your_ship_panel", function(ctx)
    local actor = ctx.character
    if ship_setting("your_ship_lights_dim") == 1 then
        transform_radius(actor, 40, "your_ship_lights_on")
        message(ctx, ccb.services.translate("The ship's lights brighten."), "neutral", false)
        store_ship_setting("your_ship_lights_dim", 0)
    else
        transform_radius(actor, 40, "your_ship_dim_lights")
        message(ctx, ccb.services.translate("The ship's lights dim to a low glow."), "neutral", false)
        store_ship_setting("your_ship_lights_dim", 1)
    end
end)

ccb.runtime.handler("examine_t_landing_stair_control", function(ctx)
    local actor = ctx.character
    local origin = checked(services.creatures.snapshot(actor)).position
    if services.overmap.matches_location(origin:project_to("omt"), "high_orbit_salus_4tp") then
        message(ctx, ccb.services.translate("You cant deploy the stairs while in space."), "neutral", false)
        return
    end
    local raised = ship_setting("your_ship_stairs_up") == 1
    local position = services.world.find_location(origin).position
    local transform = raised and "your_ship_stairs_down" or "your_ship_stairs_up"
    checked(services.world.transform_radius(position, 20, id("terrain_furniture_transform", transform)))
    local below = position:add(services.coords.tripoint_rel_ms(0, 0, -1))
    if raised then
        apply_ship_update(below, "your_ship_stairs_deployed")
        message(ctx, ccb.services.translate("The boarding stairs descend"), "neutral", false)
        store_ship_setting("your_ship_stairs_up", 0)
    else
        apply_ship_update(below, "your_ship_stairs_retract")
        message(ctx, ccb.services.translate("The boarding stairs retract upward."), "neutral", false)
        store_ship_setting("your_ship_stairs_up", 1)
    end
end)

ccb.runtime.handler("examine_t_bay_ramp_control", function(ctx)
    local actor = ctx.character
    local origin = checked(services.creatures.snapshot(actor)).position
    if services.overmap.matches_location(origin:project_to("omt"), "high_orbit_salus_4tp") then
        message(ctx, ccb.services.translate("You cant deploy the ramp while in space."), "neutral", false)
        return
    end
    local ramp = services.world.find_location(origin).position
    if ship_setting("your_ship_ramp_up") == 1 then
        checked(services.world.transform_radius(ramp, 20, id("terrain_furniture_transform", "your_ship_ramp_down")))
        apply_ship_update(ramp:add(services.coords.tripoint_rel_ms(0, 0, -1)), "your_ship_ramp_deployed")
        message(ctx, ccb.services.translate("The bay ramp hydraulics whine as the ramp extends downwards."),
            "neutral", false)
        store_ship_setting("your_ship_ramp_up", 0)
    else
        apply_ship_update(ramp, "your_ship_ramp_closed")
        local open_bay = services.world.find_location(origin,
            { kind = "terrain", id = id("terrain", "t_open_air_bay") },
            { target_max_radius = 24, distance_origin = origin })
        if open_bay.found then
            message(ctx, ccb.services.translate("You must clear all vehicles near the ramp before raising it"),
                "neutral", false)
        else
            apply_ship_update(ramp:add(services.coords.tripoint_rel_ms(0, 0, -1)), "your_ship_ramp_retract")
            message(ctx, ccb.services.translate("The ramp rises into position, sealing the bay."), "neutral", false)
            store_ship_setting("your_ship_ramp_up", 1)
        end
    end
end)

local function launch_escape_pod(actor)
    local origin = checked(services.creatures.snapshot(actor)).position
    local ship = services.overmap.find_target(origin:project_to("omt"), "crashing_ship_4", { z = -10 })
    local crate = services.world.find_location(ship:project_to("ms"), { kind = "terrain", id = id("terrain", "t_escape_pod_floor") },
        { target_max_radius = 24, distance_origin = origin }).position or services.coords.tripoint_abs_ms(0, 0, 0)
    local function landing_site()
        return checked(services.variables.get_global_tripoint("new_map")).value or services.coords.tripoint_abs_ms(0, 0, 0)
    end
    for _, cargo in ipairs(checked(services.items.on_map(crate, 0, 0))) do
        if cargo:is_valid() then checked(services.relocation.teleport_item(cargo, landing_site())) end
    end
    if actor.subtype == "avatar" then
        local text = ccb.services.translate("You make sure that all equipment is strapped down and loose items are put away to avoid projectiles during launch before you strap yourself into the escape pod seat and press the launch button.  With an incredibly loud roar and a massive acceleration that presses you into the seat, the escape pod fires from the ship, plummeting towards the planet below.")
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        services.messages.add(text)
    end
    checked(services.relocation.teleport_creature(actor, landing_site(), { force = true }))
end

ccb.runtime.handler("launch_escape_pod_from_seat", function(hit)
    if not hit.creature then return true end
    launch_escape_pod(hit.creature)
    return false
end)
ccb.runtime.handler("examine_escape_pod_guidance", function(ctx) launch_escape_pod(ctx.character) end)

local function global_point(key)
    return checked(services.variables.get_global_tripoint(key)).value or services.coords.tripoint_abs_ms(0, 0, 0)
end

local function has_global(key)
    return checked(services.variables.get_global(key)).value ~= nil
end

local function remove_mission(actor, name)
    local offset = 0
    repeat
        local page = services.missions.active(actor, { offset = offset, limit = 256 })
        for _, entry in ipairs(page.items) do
            if entry.id.value == name then
                checked(services.missions.abandon(actor, entry.token))
                return
            end
        end
        offset = offset + page.returned
    until not page.has_more
end

local function validate_port_augustmoon(ctx, actor)
    if has_global("Port_augustmoon") and has_global("Port_augustmoon_cargo")
        and has_global("augustmoon_main_concourse1") and has_global("augustmoon_main_concourse2") then
        return
    end
    message(ctx, ccb.services.translate("MANUALLY FINDING PORT AUGUSTMOON AS A FALLBACK.  (PRESS SPACE)."),
        "neutral", true)
    local origin = checked(services.creatures.snapshot(actor)).position
    local origin_omt = origin:project_to("omt")
    local docking_omt = services.overmap.find_target(origin_omt, "augustmoon_docking_arm", { z = -9 })
    local docking_ms = docking_omt:project_to("ms")
    local start_loc = services.world.find_location(docking_ms, { kind = "zone", id = id("zone", "ZONE_START_POINT") },
        { target_max_radius = 30, distance_origin = origin })
    if start_loc.position then
        store_ship_setting("Port_augustmoon", start_loc.position)
    end
    local cargo_loc = services.world.find_location(docking_ms,
        { kind = "terrain", id = id("terrain", "t_intermodal_crate_scripted_destination") },
        { target_max_radius = 26, distance_origin = origin })
    if cargo_loc.position then
        store_ship_setting("Port_augustmoon_cargo", cargo_loc.position)
    end
    local concourse1 = services.world.find_location(
        services.overmap.find_target(origin_omt, "augustmoon_main_concourse1", { z = -9 }):project_to("ms")).position
    if concourse1 then
        store_ship_setting("augustmoon_main_concourse1", concourse1)
    end
    local concourse2 = services.world.find_location(
        services.overmap.find_target(origin_omt, "augustmoon_main_concourse2", { z = -9 }):project_to("ms")).position
    if concourse2 then
        store_ship_setting("augustmoon_main_concourse2", concourse2)
    end
end

ccb.runtime.handler("afs_augustmoon_shuttle_recall_due", function()
    local avatar = services.characters.avatar()
    local origin = checked(services.creatures.snapshot(avatar)).position
    if services.overmap.matches_location_near(origin:project_to("omt"), "afs_landed_shuttle", 4) then
        ccb.tasks.after_avatar_turn(10, "afs_augustmoon_shuttle_recall_due")
    else
        store_ship_setting("augustmoon_shuttle_inprogress", 0)
        remove_mission(avatar, "MISSION_REACH_AUGUSTMOON_SHUTTLE")
        apply_ship_update(global_point("landing_site"), "augustmoon_shuttle_ground_left")
    end
end)

ccb.runtime.handler("afs_augustmoon_reroll_vending_due", function()
    apply_ship_update(global_point("augustmoon_main_concourse1"), "augustmoon_concourse_vending1")
    apply_ship_update(global_point("augustmoon_main_concourse2"), "augustmoon_concourse_vending2")
end)

ccb.runtime.handler("examine_t_augustmoon_shuttle_console", function(ctx)
    local actor = ctx.character
    store_ship_setting("augustmoon_shuttle_inprogress", 0)
    validate_port_augustmoon(ctx, actor)
    ccb.tasks.after_avatar_turn(1, "afs_augustmoon_shuttle_recall_due")
    ccb.tasks.after_avatar_turn(1, "afs_augustmoon_reroll_vending_due")
    local origin = checked(services.creatures.snapshot(actor)).position
    local crate = services.world.find_location(origin,
        { kind = "terrain", id = id("terrain", "t_intermodal_crate_scripted_source") },
        { target_max_radius = 24, distance_origin = origin }).position or services.coords.tripoint_abs_ms(0, 0, 0)
    local cargo_dest = global_point("Port_augustmoon_cargo")
    for _, cargo in ipairs(checked(services.items.on_map(crate, 0, 0))) do
        if cargo:is_valid() then
            checked(services.relocation.teleport_item(cargo, cargo_dest))
        end
    end
    local port_dest = global_point("Port_augustmoon")
    for _, npc in ipairs(checked(services.npcs.loaded())) do
        if checked(services.npcs.get(npc)).following then
            checked(services.relocation.teleport_character(npc, port_dest))
        end
    end
    message(ctx,
        ccb.services.translate("The shuttle's ascent is a little rough, but you're soon on your way to Port Augustmoon."),
        "neutral", true)
    checked(services.relocation.teleport_character(actor, port_dest))
end)
