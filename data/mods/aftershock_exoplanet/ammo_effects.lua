local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("vahagn_follow_up", function(impact)
    local shooter = impact.source
    if not shooter or shooter.subtype == "monster" then
        return
    end
    local fired_at = id("effect", "vahagan_fired_at")
    if value(services.effects.has(shooter, fired_at)) then
        return
    end
    local one_turn = services.time.duration(1, "turn")
    value(services.effects.add(shooter, fired_at, one_turn))
    value(services.characters.cast_spell(shooter, id("spell", "spell_vahagn"), { target = impact.absolute_position }))

    local shooter_position = value(services.creatures.snapshot(shooter)).position
    local marked = id("effect", "smart_targeted")
    local remaining = 5
    for _, target in ipairs(services.monsters.seeing_position(shooter_position, 45)) do
        if target:is_valid() and value(services.effects.has(target, marked))
            and value(services.creatures.snapshot(target)).hp > 1
            and not value(services.effects.has(target, fired_at)) then
            value(services.effects.add(target, fired_at, one_turn))
            value(services.effects.remove(target, marked))
            local current_shooter = value(services.creatures.at(shooter_position))
            value(services.characters.ranged_attack(current_shooter, target))
            remaining = remaining - 1
            if remaining == 0 then
                break
            end
        end
    end
end)

content.add(content.AmmoEffect { id = "VAHAGN" }
    :impact_policy("vahagn_follow_up"))

-- Applies foamcrete effect on hit.
content.add(content.AmmoEffect { id = "FOAMCRETE" }
    :foamcrete())

content.add(content.AmmoEffect { id = "LOW_RANGE_VAPORIZATION" }
    :explosion{ power = 12000, distance_factor = 0.2, max_noise = 25 })

content.add(content.AmmoEffect { id = "PUMP_LASER" }
    :field_burst{ field = "fd_fire", intensity_min = 1, intensity_max = 1, radius = 3, chance = 50, footprint = 4 }
    :explosion{ power = 5000, distance_factor = 0.5, max_noise = 35 })

content.add(content.AmmoEffect { id = "FRAG_25mm" }
    :explosion{ power = 40, distance_factor = 0.75 }
    :shrapnel{ casing_mass = 15, fragment_mass = 0.08 })

content.add(content.AmmoEffect { id = "ELECTRO_ANOMALY" }
    :field_burst{ field = "fd_elect_anomaly", intensity_min = 2, intensity_max = 3, radius = 0 })

content.add(content.AmmoEffect { id = "SMALL_ELECTRIC_BURST" }
    :field_burst{ field = "fd_electricity", intensity_min = 1, intensity_max = 2, radius = 1, chance = 10 })

content.add(content.AmmoEffect { id = "TACTICAL_LASER_EXPLOSION", trigger_chance = 20 }
    :explosion{ power = 500, distance_factor = 0.2, max_noise = 35 })

content.add(content.AmmoEffect { id = "DAZZLE_BEAM" }
    :trail{ field = "fd_dazzling", intensity_min = 1, intensity_max = 1 })

content.add(content.AmmoEffect { id = "SEISMIC_MAPPING" }
    :field_burst{ field = "fd_clairvoyant", intensity_min = 10, intensity_max = 10 })

content.add(content.AmmoEffect { id = "TOXIC_FOAM" }
    :field_burst{ field = "fd_toxic_foam", intensity_min = 1, intensity_max = 4, radius = 1, chance = 70 })

content.add(content.AmmoEffect { id = "ELECTRIC_CHAIN" }
    :cast_spells_on_miss(true)
    :spell("spell_electric_chain"))

content.add(content.AmmoEffect { id = "FUSION_FAN" }
    :cast_spells_on_miss(true)
    :spell("spell_fusion_fan"))
