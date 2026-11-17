local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("has_effect_effect_perk_vengeful", function(ctx)
    return ctx.character_inputs.effects["effect_perk_vengeful"]
end)

content.add(content.Enchantment {
    id = "perk_ench_vengeful",
    name = content.text("Vengeful"),
    description = content.text("Oh, you aren't getting away with that."),
    condition_handler = "has_effect_effect_perk_vengeful",
    load_character_inputs = { effects = { "effect_perk_vengeful" } },
}
    :value("MELEE_DAMAGE", { multiply = 0.15 })
    :value("RANGED_DAMAGE", { multiply = 0.15 }))
