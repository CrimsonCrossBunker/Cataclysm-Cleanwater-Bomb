local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local pile_on = id("effect", "effect_zombie_pile_on")

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

ccb.runtime.handler("examine_f_bulletin_evac_classic", function(ctx)
    local actor = ctx.character
    local senses = checked(services.characters.snapshot(actor)).senses
    local can_read = senses.can_see
        and (checked(services.creatures.has_flag_text(actor, "READ_IN_DARKNESS"))
            or senses.fine_detail_vision_legacy <= 4)
    if actor.subtype ~= "avatar" then return end
    if can_read then
        services.messages.add(
            services.translate("You study the board.  It only bears minutia you no longer need trouble yourself with now that society has collapsed, like 'operating hours' and 'acceptable forms of ID' along with various numbers that wouldn't help much with the power down even if there was anyone left to pick up on the other end."),
            "neutral")
    else
        services.messages.add(services.translate("It's too dark to read."), "neutral")
    end
end)

ccb.runtime.handler("classic_remove_zombie_pile_on", function()
    local avatar = services.characters.avatar()
    if avatar:is_valid() and checked(services.effects.has(avatar, pile_on)) then
        checked(services.effects.remove(avatar, pile_on))
    end
end)
ccb.runtime.on("game:avatar_moves", "classic_remove_zombie_pile_on")
