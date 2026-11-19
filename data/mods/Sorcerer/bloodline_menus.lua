local ccb = require("ccb")
local state = require("spell_state")
local progression = require("xp_progression")

local bloodlines = {
    {
        id = "TALK_SORCERER_GAIN_BLOODLINE_STANDARD",
        name = "STANDARD",
        power_source = "intelligence",
        dynamic_line = "You're a fairly standard sorcerer.  You gain no special strengths or weaknesses.\nYour caster level is boosted by your intelligence.\nYou can pick one spell to be your favoured spell.  This boosts the starting level of that spell to 3.  This does not stack with spell level increases gained from leveling up as a sorcerer.\nIs this your bloodline?",
        dynamic_line_translation = {},
    },
    {
        id = "TALK_SORCERER_GAIN_BLOODLINE_BLOODRAGER",
        name = "BLOODRAGER",
        power_source = "strength",
        dynamic_line = "Magic is in the blood of every sorcerer, but for you it's more literal.  Your magical powers surges as your blood does.\nYour caster level bonus is based off of strength instead of intelligence.  You get an extra boost during adrenaline rushes, but you take a penalty if you lose too  much blood.\nIs this your bloodline?",
        dynamic_line_translation = {},
    },
    {
        id = "TALK_SORCERER_GAIN_BLOODLINE_SPELLDANCER",
        name = "SPELLDANCER",
        power_source = "dodge",
        dynamic_line = "As a Spelldancer, you empower your magic through dance and acrobatics.  The elegance of your movements is matched only by the power of your spells.\nYour caster level bonus is based off of effective dodge instead of intelligence.\nIs this your bloodline?",
        dynamic_line_translation = {},
    },
}

local function set_bloodline_value(character, key, value)
    -- The old single-choice native assignment consumes one game RNG draw.
    ccb.services.random.native_int(0, 0)
    state.set(character, key, value)
    ccb.services.native_events.emit("u_var_changed", { key, value })
end

for _, bloodline in ipairs(bloodlines) do
    ccb.dialogue.register_topic {
        id = bloodline.id,
        dynamic_line = bloodline.dynamic_line,
        dynamic_line_translation = bloodline.dynamic_line_translation,
        responses = {
            {
                text = "Choose this bloodline",
                text_translation = {},
                topic = "TALK_SORCERER_MENU_MAIN",
                on_action = function(ctx)
                    local speaker = ctx:speaker()
                    progression.level_up(speaker)
                    if bloodline.name == "STANDARD" then
                        state.set(speaker, "available_favorite_spells", 1)
                    end
                    set_bloodline_value(speaker, "power_source", bloodline.power_source)
                    set_bloodline_value(speaker, "bloodline", bloodline.name)
                end,
            },
            { text = "Back", text_translation = {}, topic = "TALK_SORCERER_PICK_BLOODLINE" },
            { text = "Quit.", text_translation = {}, topic = "TALK_DONE" },
        },
    }
end
