local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local pure_damage = id("damage_type", "pure")
local torso = id("body_part", "torso")

ccb.runtime.handler("crazy_immortal_snail_touch", function(event)
    if event.data.victim_type ~= "mon_immortal_snail" then return end
    local actor = event.actors.speaker or event.actors.attacker or services.characters.avatar()
    if not actor:is_valid() then return end

    local is_avatar = actor.subtype == "avatar"
    local damaged = services.characters.damage(actor, pure_damage, 100000, { body_part = torso })
    if not damaged.ok and damaged.error.code ~= "dead" and damaged.error.code ~= "destroyed" then
        error(damaged.error.message)
    end
    if is_avatar then
        services.messages.add(services.translate("You touch the snail and die instantly."), "neutral")
    end
end)
ccb.runtime.on("game:character_melee_attacks_monster", "crazy_immortal_snail_touch")
