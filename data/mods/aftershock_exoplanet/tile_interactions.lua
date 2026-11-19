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
    services.interaction.open_topic(actor, "THI_CONTROL_START")
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
