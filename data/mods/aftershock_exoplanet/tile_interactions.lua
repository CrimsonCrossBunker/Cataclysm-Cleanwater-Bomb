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
