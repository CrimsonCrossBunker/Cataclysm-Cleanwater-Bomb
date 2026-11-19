local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function assign_mission(actor, mission)
    local reserved = checked(services.missions.reserve(id("mission", mission)))
    checked(services.missions.assign(actor, reserved.token))
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

local function number_value(actor, key)
    local result = services.variables.get_number(actor, key, { strict = true })
    if not result.ok and result.error.code == "variable_type_mismatch" then
        return nil
    end
    return checked(result).value or 0
end

ccb.runtime.handler("examine_f_sevenoclock_track", function(ctx)
    local actor = ctx.character
    if number_value(actor, "tracked_sevenoclock") == 1 then
        message(ctx, ccb.services.translate("You already know where these footprints lead."), "neutral", false)
    end
    if number_value(actor, "tracked_sevenoclock") == 0 then
        message(ctx, ccb.services.translate("You carefully examine the footprints, determining where they lead."),
            "neutral", false)
        assign_mission(actor, "MISSION_SEVENOCLOCK")
        checked(services.variables.set(actor, "tracked_sevenoclock", 1, { include_before = false }))
    end
end)

ccb.runtime.handler("examine_f_deathworm_track", function(ctx)
    local actor = ctx.character
    if number_value(actor, "tracked_deathworm") == 1 then
        message(ctx, ccb.services.translate("You already know where this hole leads."), "neutral", false)
    end
    if number_value(actor, "tracked_deathworm") == 0 then
        message(ctx, ccb.services.translate("You carefully examine the hole, determining where it leads."), "neutral",
            false)
        assign_mission(actor, "MISSION_DEATHWORM")
        checked(services.variables.set(actor, "tracked_deathworm", 1, { include_before = false }))
    end
end)

ccb.runtime.handler("examine_f_hunger_track", function(ctx)
    local actor = ctx.character
    if number_value(actor, "tracked_wendigo") == 1 then
        message(ctx, ccb.services.translate("You already know where these tracks lead."), "neutral", false)
    end
    if number_value(actor, "tracked_wendigo") == 0 then
        message(ctx, ccb.services.translate("You carefully examine the tracks, determining where they lead."),
            "neutral", false)
        assign_mission(actor, "MISSION_DEATHWORM")
        checked(services.variables.set(actor, "tracked_wendigo", 1, { include_before = false }))
    end
end)
