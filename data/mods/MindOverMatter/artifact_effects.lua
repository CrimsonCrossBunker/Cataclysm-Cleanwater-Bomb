local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local drain = id("vitamin", "vitamin_psionic_drain")
ccb.runtime.handler("artifact_nether_attunement", function(impact)
    local target = impact.target_creature
    if target and target.subtype ~= "monster" then
        local current = value(services.needs.get_vitamin(target, drain))
        value(services.needs.set_vitamin(target, drain, current + services.random.native_int(0, 25)))
    end
end)

local paralysis_effects = {
    id("effect", "downed"),
    id("effect", "psi_dazed"),
    id("effect", "effect_electrokin_paralysis"),
}
ccb.runtime.handler("artifact_area_paralysis", function(impact)
    local duration = services.time.duration_from_turns(services.random.native_float(10, 32))
    local target = impact.target_creature
    if target then
        for _, effect in ipairs(paralysis_effects) do
            value(services.effects.add(target, effect, duration))
        end
    end
end)

ccb.runtime.handler("artifact_health_change", function(impact)
    local change = math.modf(services.random.native_float(-5, 10))
    local target = impact.target_creature
    if target and target.subtype ~= "monster" then
        value(services.needs.modify_health(target, { lifestyle = change }))
    end
end)

local electrical_zap = id("effect", "effect_mom_artifact_electrical_zap_attack")
ccb.runtime.handler("remove_used_artifact_zap", function(event)
    local attacker = event.actors.attacker or services.characters.avatar()
    if value(services.effects.has(attacker, electrical_zap)) then
        value(services.effects.remove(attacker, electrical_zap))
    end
end, 1)
ccb.runtime.on("game:character_melee_attacks_character", "remove_used_artifact_zap")
ccb.runtime.on("game:character_melee_attacks_monster", "remove_used_artifact_zap")
