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
