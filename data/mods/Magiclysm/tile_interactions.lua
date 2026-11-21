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

ccb.runtime.handler("examine_f_magus_permanent_light", function(ctx)
    local actor = ctx.character
    if not ask(actor, ccb.services.translate("Dismiss the imperishable light?"), false) then
        return
    end
    local origin = checked(services.creatures.snapshot(actor)).position
    for _, tile in ipairs(services.world.points_nearby(origin, { max_radius = 1 }).items) do
        if services.gameplay.environment.furniture_id(tile.position) == "f_magus_permanent_light" then
            checked(services.characters.cast_spell(actor, id("spell", "magus_permanent_light"),
                { target = tile.position }))
            return
        end
    end
    if actor.subtype == "avatar" then
        services.messages.add(ccb.services.translate("There is no nearby light to dismiss."), "bad")
    end
end)
