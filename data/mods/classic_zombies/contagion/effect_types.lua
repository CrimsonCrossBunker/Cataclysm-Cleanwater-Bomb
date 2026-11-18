local ccb = require("ccb")
local content = ccb.content

-- Deadly Zombie Virus supplies this shared engine effect when enabled.
if not content.is_mod_active("deadly_bites") then
    -- bitten by a zombie
    content.add(content.EffectType {
        id = "zombie_virus",
        apply_memorial_log = "Died of the zombie plague.",
        death_message = ccb.content.text("You succumb to your zombie bite."),
        death_event = "dies_of_infection",
        name = ccb.content.text("Zombie bite"),
        description = ccb.content.text("You've got a painful bite from a zombie.  You know how this ends."),
        apply_message = ccb.content.text("You've been bitten.  It's bad."),
        maximum_intensity = 3,
        intensity_add_value = 1,
        intensity_decay_step = 1,
        intensity_decay_tick = 86400,
        rating = "bad",
        show_intensity = false,
    }
        :name(ccb.content.text("Zombie contagion"))
        :name(ccb.content.text("Zombie contagion"))
        :description(ccb.content.text("The area around your zombie bite is festering and red, and you're feeling hot and cold at once."))
        :description(ccb.content.text("Everything's so dark.  You can feel it, you don't have much time left."))
        :modifier("pain", "chance_numerator", { base = -10, per_intensity = 5.5, resisted_base = -10, resisted_per_intensity = 3.5 })
        :modifier("pain", "chance_denominator", { base = 1000, per_intensity = 1, resisted_base = 10000, resisted_per_intensity = 5 })
        :modifier("pain", "minimum", { base = 1 })
        :modifier("pain", "maximum", { base = 5, resisted_base = 1 })
        :modifier("intelligence", "amount", { resisted_per_intensity = -1 })
        :modifier("perception", "amount", { resisted_per_intensity = -1 })
        :modifier("dexterity", "amount", { per_intensity = -1, resisted_per_intensity = -2 })
        :modifier("strength", "amount", { per_intensity = -1, resisted_per_intensity = -2 })
        :modifier("speed", "amount", { per_intensity = -5, resisted_per_intensity = -25 })
        :death_chance({ numerator = -1, denominator = 1 })
        :death_chance({ numerator = -1, denominator = 1 })
        :death_chance({ numerator = 1, denominator = 100000 }))
end

-- Scratched by a zombie. This effect is not currently functional.
content.add(content.EffectType {
    id = "zombie_virus_scratch",
    apply_memorial_log = "Died of the zombie plague.",
    death_message = ccb.content.text("You succumb to your zombie contagion."),
    death_event = "dies_of_infection",
    name = "",
    description = "",
    apply_message = ccb.content.text("You've been cut by a zombie.  Did it get infected?"),
    maximum_intensity = 5,
    intensity_add_value = 1,
    intensity_decay_step = 1,
    intensity_decay_tick = 86400,
    rating = "bad",
    show_intensity = false,
}
    :name(ccb.content.text("Zombie wound"))
    :name(ccb.content.text("Zombie wound"))
    :name(ccb.content.text("Zombie contagion"))
    :name(ccb.content.text("Zombie contagion"))
    :description(ccb.content.text("The area around your zombie scratch is looking a little red."))
    :description(ccb.content.text("Redness is creeping up from your wound.  You feel weak, and look pale."))
    :description(ccb.content.text("Why is it so cold in here?  And so hot, at the same time?"))
    :description(ccb.content.text("Everything's so dark.  You can feel it, you don't have much time left."))
    :modifier("pain", "chance_numerator", { base = -5, per_intensity = 3.5, resisted_base = -5, resisted_per_intensity = 2.5 })
    :modifier("pain", "chance_denominator", { base = 500, per_intensity = 1, resisted_base = 5000, resisted_per_intensity = 5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 5, resisted_base = 1 })
    :modifier("intelligence", "amount", { resisted_per_intensity = -1 })
    :modifier("perception", "amount", { resisted_per_intensity = -1 })
    :modifier("dexterity", "amount", { resisted_per_intensity = -2 })
    :modifier("strength", "amount", { resisted_per_intensity = -2 })
    :modifier("speed", "amount", { per_intensity = -5, resisted_per_intensity = -15 })
    :death_chance({ numerator = -1, denominator = 1 })
    :death_chance({ numerator = -1, denominator = 1 })
    :death_chance({ numerator = -1, denominator = 1 })
    :death_chance({ numerator = 1, denominator = 864000 })
    :death_chance({ numerator = 1, denominator = 100000 }))
