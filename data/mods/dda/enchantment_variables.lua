local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_ench_dextrous_paws_need_practice_active", function(ctx)
    return (ctx.character_inputs.traits["PAWS_LITTLE"] or ctx.character_inputs.traits["PAWS_RAT"]) and (ctx.character_inputs.character_variables["progress_dextrous_paws_usage"] < 10)
end)

content.add(content.Enchantment {
    id = "ench_dextrous_paws_need_practice",
    condition_handler = "enchantment_ench_dextrous_paws_need_practice_active",
    load_character_inputs = { character_variables = { "progress_dextrous_paws_usage" }, traits = { "PAWS_LITTLE", "PAWS_RAT" } },
}
    :effect("effect_dextrous_paws_no_practice_manipulation_penalty", 1))
