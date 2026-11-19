local ccb = require("ccb")
local services = ccb.services
local creatures = services.creatures
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function effect_intensity(creature, effect, part)
    return checked(services.effects.exact_intensity(creature, id("effect", effect),
        part and id("body_part", part)))
end

ccb.runtime.handler("allow_tec_crane_strike", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and (not (checked(creatures.has_species(combat.target, id("species", "ZOMBIE"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER_EMANATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "LEECH_PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "MIGO"))))
            and not (checked(creatures.has_species(combat.target, id("species", "SLIME"))))
            and not (checked(creatures.has_species(combat.target, id("species", "FUNGUS"))))
            and not (checked(creatures.has_species(combat.target, id("species", "PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ROBOT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "CYBORG"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HALLUCINATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HORROR"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ABERRATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "KRAKEN")))))
end)

ccb.runtime.handler("allow_mma_tec_pokken_sweep", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
        and (not (checked(creatures.has_flag_text(combat.target, "FLIES")))
            or checked(creatures.has_flag_text(combat.target, "DISABLE_FLIGHT")))
end)

ccb.runtime.handler("allow_mma_tec_setting_sun_throw", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                and checked(creatures.has_flag_text(combat.attacker, "GRAB"))
                and services.random.native_int(1, 20) + combat.attacker_strength > combat.target_grab_strength)
            or not ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                    and checked(creatures.has_flag_text(combat.attacker, "GRAB")))))
end)

ccb.runtime.handler("allow_tec_biojutsu_takedown", function(combat)
    return not (effect_intensity(combat.target, "downed") ~= nil)
end)
