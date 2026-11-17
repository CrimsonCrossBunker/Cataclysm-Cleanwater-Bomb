local ccb = require("ccb")
local content = ccb.content

local function school_damage_resistance(school, damage_type)
    local handler = "enchantment_" .. school .. "_incoming_damage"
    ccb.runtime.handler(handler, function(ctx)
        return ctx.character_inputs.spell_school_levels[school] / -6
    end)
    content.add(content.Enchantment {
        id = school,
        load_character_inputs = { spell_school_levels = { school } },
    }:incoming_damage(damage_type, { add_handler = handler }))
end

school_damage_resistance("KELVINIST", "heat")
school_damage_resistance("STORMSHAPER", "electric")
