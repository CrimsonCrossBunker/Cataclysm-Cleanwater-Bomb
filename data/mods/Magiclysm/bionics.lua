local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local LEY_TAP_TOKEN_KEY = "magiclysm_mana_to_bionic_power_gen"

ccb.runtime.handler("magiclysm_mana_to_bionic_power_tick", function(context)
    local character = context.character
    if not character then
        return
    end
    local token = context.data and context.data.token
    local current_token = value(services.variables.get_number(character, LEY_TAP_TOKEN_KEY)).value or 0
    if token == nil or current_token ~= token then
        return
    end
    local effect_id = services.types.id("effect", "effect_bio_mana_to_bionic_power")
    if not value(services.effects.has(character, effect_id)) then
        return
    end
    local mana = value(services.spells.mana(character)).current
    if mana > 0 then
        value(services.spells.set_mana_raw(character, mana - 1))
        local current_power = value(services.bionics.summary(character)).power
        value(services.bionics.set_power(
            character,
            current_power:add(services.units.new("energy", 35000, "millijoule"))
        ))
    end
    ccb.tasks.after_character_turn(character, 10, "magiclysm_mana_to_bionic_power_tick", { token = token })
end, 1)

ccb.runtime.handler("magiclysm_bionic_activated", function(payload)
    if payload.bionic.value ~= "bio_mana_to_bionic_power" then
        return
    end
    local character = payload.character
    value(services.effects.add(
        character,
        services.types.id("effect", "effect_bio_mana_to_bionic_power"),
        services.time.duration(1),
        { permanent = true }
    ))
    local next_token = (value(services.variables.get_number(character, LEY_TAP_TOKEN_KEY)).value or 0) + 1
    value(services.variables.set(character, LEY_TAP_TOKEN_KEY, next_token, { include_before = false }))
    ccb.tasks.after_character_turn(character, 10, "magiclysm_mana_to_bionic_power_tick", { token = next_token })
end, 1)
ccb.runtime.hook("on_bionic_activated", "magiclysm_bionic_activated")

ccb.runtime.handler("magiclysm_bionic_deactivated", function(payload)
    if payload.bionic.value ~= "bio_mana_to_bionic_power" then
        return
    end
    value(services.effects.remove(
        payload.character,
        services.types.id("effect", "effect_bio_mana_to_bionic_power")
    ))
end, 1)
ccb.runtime.hook("on_bionic_deactivated", "magiclysm_bionic_deactivated")

-- Native bionic definitions
content.add(content.Bionic {
    id = "bio_fuel_cell_blood",
    name = ccb.content.text("Blood Power Generator"),
    description = ccb.content.text("Embedded into your back and connected to your bionic power supply is a powerful spell focus able to consume blood from dead creatures to produce bionic power.  It can store up to 750 mL of blood."),
    charge_time_turns = 6,
    fuel_efficiency = 0.6,
    exothermic_power_gen = true,
    fuel_options = { "blood", "dragon_blood", "blood_tainted", "hblood" },
    passive_pseudo_items = { "integrated_blood_bank" },
    flags = { "BIONIC_TOGGLED", "BIONIC_POWER_SOURCE" },
    occupied_bodyparts = { { bodypart = "torso", slots = 8 } },
})
content.add(content.Bionic {
    id = "bio_sneeze_beam",
    name = ccb.content.text("Crystallized Mana Nose Replacement"),
    description = ccb.content.text("A large gem made with crystallized mana and some other stabilizing metals.  Comes with a specially designed power pack (installed into the skull) that does not interfere with your mana ley lines.  WARNING: for Technomancer use only.  By using this spell you are waiving all liability of Frikken Laser Beams Inc.  and its subsidiaries."),
    capacity_energy_millijoules = 500000000,
    enchantments = { "ench_bio_sneeze_beam" },
    flags = { "BIONIC_SHOCKPROOF" },
    mutation_conflicts = { "EARTHSHAPER" },
    occupied_bodyparts = { { bodypart = "head", slots = 10 }, { bodypart = "mouth", slots = 1 } },
    learned_spells = { { spell = "overcharge_eyes", level = 4 } },
})
content.add(content.Bionic {
    id = "bio_see_wizards_eyes",
    name = ccb.content.text("Witchfinder Eyes"),
    description = ccb.content.text("Rune-inscribed metal filaments have been implanted around your eyes, allowing you to detect nearby mages.  Activate to turn it on."),
    activation_energy_millijoules = 20000,
    over_time_energy_millijoules = 6000,
    charge_time_turns = 1,
    enchantments = { "ench_bio_see_wizards_eye" },
    flags = { "BIONIC_TOGGLED" },
    mutation_conflicts = { "COMPOUND_EYES", "CEPH_VISION", "CEPH_EYES", "EYEBULGE", "EYESTALKS1", "EYESTALKS2" },
    occupied_bodyparts = { { bodypart = "eyes", slots = 2 } },
})
content.add(content.Bionic {
    id = "bio_ley_energy_blaster",
    name = ccb.content.text("Levinbolt Projector"),
    description = ccb.content.text("Implants in your arm's ley lines allow you to project bolts of magical energy from your hands.  This draws on your personal mana stores, not your bionic power."),
    activated_close_ui = true,
    activation_spell = { id = "bio_ley_energy_blaster_spell" },
    occupied_bodyparts = { { bodypart = "arm_l", slots = 2 }, { bodypart = "arm_r", slots = 2 }, { bodypart = "hand_l", slots = 1 }, { bodypart = "hand_r", slots = 1 } },
})
content.add(content.Bionic {
    id = "bio_mana_to_bionic_power",
    name = ccb.content.text("Corporeal Ley Tap"),
    description = ccb.content.text("Tiny bits of orichalcum have been implanted at important intersections in your ley lines, allowing you to turn your mana into bionic power.  Activate to begin the conversion process."),
    occupied_bodyparts = { { bodypart = "head", slots = 1 }, { bodypart = "torso", slots = 1 }, { bodypart = "arm_l", slots = 1 }, { bodypart = "arm_r", slots = 1 }, { bodypart = "leg_l", slots = 1 }, { bodypart = "leg_r", slots = 1 } },
    mutation_conflicts = { "EARTHSHAPER" },
    flags = { "BIONIC_TOGGLED", "BIONIC_POWER_SOURCE" },
})
