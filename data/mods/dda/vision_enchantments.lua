local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_target_radiates_heat", function(ctx)
    local target = ctx.target_inputs
    return target.line_of_sight and target.warm
end)

local thermal_descriptions = {}
for size, description in ipairs({
    { "tiny", ".", "You see a tiny figure radiating heat." },
    { "small", ",", "You see a small figure radiating heat." },
    { "medium", "o", "You see a medium figure radiating heat." },
    { "large", "O", "You see a large figure radiating heat." },
    { "huge", "&", "You see a huge figure radiating heat." },
}) do
    local handler = "enchantment_thermal_target_" .. description[1]
    ccb.runtime.handler(handler, function(ctx)
        return ctx.target_inputs.size == size
    end)
    thermal_descriptions[size] = {
        id = "infrared_creature_" .. description[1],
        symbol = description[2],
        text = content.text(description[3]),
        condition_handler = handler,
        target_inputs = { size = true },
    }
end

local thermal_vision = {
    distance = 60,
    precise = true,
    condition_handler = "enchantment_target_radiates_heat",
    target_inputs = { line_of_sight = true, warm = true },
    descriptions = thermal_descriptions,
}
content.add(content.Enchantment {
    id = "THERMAL_VISION_GOOD", has = "WORN", condition = "ACTIVE",
}:vision(thermal_vision))
content.add(content.Enchantment {
    id = "THERMAL_VISION_GOOD_PASSIVE", condition = "ALWAYS",
}:vision(thermal_vision))

ccb.runtime.handler("enchantment_thermal_nostrils_clear", function(ctx)
    local state = ctx.character_inputs
    local effects = state.effects
    return not (state.body_part_effects.mouth.smoke or effects.asthma or effects.tpollen
        or effects.hay_fever or state.environment.divable)
end)

content.add(content.Enchantment {
    id = "THERMAL_VISION_LEAFNOSE",
    condition_handler = "enchantment_thermal_nostrils_clear",
    load_character_inputs = {
        body_part_effects = { mouth = { "smoke" } },
        effects = { "asthma", "tpollen", "hay_fever" },
        environment = { divable = true },
    },
}:vision {
    distance = 10,
    condition_handler = "enchantment_target_radiates_heat",
    target_inputs = { line_of_sight = true, warm = true },
    descriptions = { {
        id = "infrared_creature_medium",
        symbol = "o",
        text = content.text("You sense a creature with your thermal nostrils."),
    } },
})

ccb.runtime.handler("enchantment_target_emits_electricity", function(ctx)
    local target = ctx.target_inputs
    local species, traits = target.species, target.traits
    return species.ROBOT or species.CYBORG or species.ROBOT_FLYING or species.LEECH_PLANT
        or target.flags.ELECTRIC or traits.EXODII_BODY_1 or traits.EXODII_BODY_2 or traits.EXODII_BODY_9
        or target.effects.absorbed_electric
end)
content.add(content.Enchantment {
    id = "ELECTRIC_VISION", condition = "ALWAYS",
}:vision {
    distance = 1000,
    condition_handler = "enchantment_target_emits_electricity",
    target_inputs = {
        species = { "ROBOT", "CYBORG", "ROBOT_FLYING", "LEECH_PLANT" },
        flags = { "ELECTRIC" },
        traits = { "EXODII_BODY_1", "EXODII_BODY_2", "EXODII_BODY_9" },
        effects = { "absorbed_electric" },
    },
    descriptions = { {
        id = "electric_creature_sense", symbol = "?", color = "c_cyan",
        text = content.text("You sense something emitting electricity here."),
    } },
})

ccb.runtime.handler("enchantment_meteor_mask_detects_target", function(ctx)
    local species = ctx.target_inputs.species
    return species.HORROR or species.NETHER or species.nether_player_hate
end)
content.add(content.Enchantment {
    id = "ench_meteor_mask", has = "WORN", condition = "ALWAYS",
    name = content.text("Detect Evil"),
    description = content.text("Your armor lets you detect otherworldly presence with ease."),
}:vision {
    distance = 10,
    condition_handler = "enchantment_meteor_mask_detects_target",
    target_inputs = { species = { "HORROR", "NETHER", "nether_player_hate" } },
    descriptions = { {
        id = "nether_creature_sense", symbol = "?", color = "c_pink",
        text = content.text("You sense an otherworldy danger here."),
    } },
})
