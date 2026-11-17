local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_iso_pain_adjust_value_pain_multiply", function(ctx)
    return ctx.character_inputs.pain > 40 and -1 or -0.4
end)

content.add(content.Enchantment {
    id = "iso_pain_adjust",
    condition = "ALWAYS",
    load_character_inputs = { pain = true },
}
    :value("PAIN", { multiply_handler = "enchantment_iso_pain_adjust_value_pain_multiply" }))
