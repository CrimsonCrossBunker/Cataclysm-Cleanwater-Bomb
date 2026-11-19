local ccb = require("ccb")
local state = require("spell_state")
local catalog = require("spell_catalog")

local main_topic = "TALK_SORCERER_MENU_MAIN"
local learn_topic = "TALK_SORCERER_LEARN_SPELL"
local forget_topic = "TALK_SORCERER_FORGET_SPELL"
local favorite_topic = "TALK_SORCERER_PICK_FAV_SPELL"

local back = { text = "Go Back.", text_translation = {}, topic = main_topic }
local quit = { text = "Quit.", text_translation = {}, topic = "TALK_DONE" }
local learn, forget, favorite = { back, quit }, { back, quit }, { back, quit }

local function choose(label, topic, condition, on_action)
    return {
        text = label.text,
        text_translation = label.text_translation,
        topic = topic,
        condition = condition,
        on_action = on_action,
    }
end

for _, spell in ipairs(catalog) do
    local id = spell.id
    local slot = state.slot_key(id)
    local preview_topic = learn_topic .. "_" .. id
    local function is_known(ctx)
        return state.number(ctx:speaker(), slot) > 0
    end

    learn[#learn + 1] = choose(spell.learn, preview_topic, function(ctx)
        local speaker = ctx:speaker()
        return state.number(speaker, slot) == 0 and state.number(speaker, "picked_level") >= spell.tier
    end)
    ccb.dialogue.register_topic {
        id = preview_topic,
        dynamic_line = "<spell_name:" .. id .. ">: <spell_description:" .. id .. ">",
        dynamic_line_translation = {},
        responses = {
            {
                text = "Select Spell.",
                text_translation = {},
                topic = main_topic,
                on_action = function(ctx)
                    local speaker = ctx:speaker()
                    state.set_spell_level(speaker, id, state.number(speaker, "current_sorcerer_level"))
                    state.set(speaker, slot, state.number(speaker, "picked_level"))
                    state.adjust_known_count(speaker, state.number(speaker, "picked_level"), 1)
                end,
            },
            back,
            quit,
        },
    }

    forget[#forget + 1] = choose(spell.forget, main_topic, is_known, function(ctx)
        local speaker = ctx:speaker()
        state.set_spell_level(speaker, id, -1)
        state.adjust_known_count(speaker, state.number(speaker, slot), -1)
        state.set(speaker, slot, 0)
        state.set(speaker, "sorcerer_forget_spell_charge", state.number(speaker, "sorcerer_forget_spell_charge") - 1)
    end)

    if spell.favorite then
        favorite[#favorite + 1] = choose(spell.favorite, main_topic, is_known, function(ctx)
            local speaker = ctx:speaker()
            local level = state.checked(ccb.services.spells.effective_level(speaker, id))
            state.set_spell_level(speaker, id, math.max(3, level))
            state.set(speaker, "available_favorite_spells", state.number(speaker, "available_favorite_spells") - 1)
        end)
    end
end

ccb.dialogue.register_topic {
    id = learn_topic,
    dynamic_line = "<u_val:sorcerer_level_x_spells_known> / <u_val:sorcerer_level_x_spells_known_slots> level <u_val:picked_level> spells known.",
    dynamic_line_translation = {},
    responses = learn,
}

ccb.dialogue.register_topic {
    id = forget_topic,
    dynamic_line = "Pick a spell to forget",
    dynamic_line_translation = {},
    responses = forget,
}

ccb.dialogue.register_topic {
    id = favorite_topic,
    dynamic_line = "Pick a spell you have a special affinity for to gain a small boost in caster level for said spell.  The boost will quickly become obsolete, but will help you get started on your journey.",
    dynamic_line_translation = {},
    responses = favorite,
}

local main_responses = {
    {
        text = "Replace a known spell",
        text_translation = {},
        topic = forget_topic,
        condition = function(ctx)
            return state.number(ctx:speaker(), "sorcerer_forget_spell_charge") >= 1
        end,
    },
}
local tier_labels = {
    [0] = { text = "Learn a level 0 spell", text_translation = {} },
    { text = "Learn a level 1 spell", text_translation = {} },
    { text = "Learn a level 2 spell", text_translation = {} },
    { text = "Learn a level 3 spell", text_translation = {} },
    { text = "Learn a level 4 spell", text_translation = {} },
    { text = "Learn a level 5 spell", text_translation = {} },
    { text = "Learn a level 6 spell", text_translation = {} },
    { text = "Learn a level 7 spell", text_translation = {} },
    { text = "Learn a level 8 spell", text_translation = {} },
    { text = "Learn a level 9 spell", text_translation = {} },
}
for tier = 9, 0, -1 do
    local known = state.known_count_key(tier)
    local slots = known .. "_slots"
    main_responses[#main_responses + 1] = choose(tier_labels[tier], learn_topic, function(ctx)
        local speaker = ctx:speaker()
        return state.number(speaker, slots) > state.number(speaker, known)
    end, function(ctx)
        local speaker = ctx:speaker()
        state.set(speaker, "sorcerer_level_x_spells_known", state.number(speaker, known))
        state.set(speaker, "sorcerer_level_x_spells_known_slots", state.number(speaker, slots))
        -- A cantrip occupies a positive reservation in the legacy save slot.
        state.set(speaker, "picked_level", tier == 0 and 0.5 or tier)
    end)
end
main_responses[#main_responses + 1] = {
    text = "Pick a bloodline",
    text_translation = {},
    topic = "TALK_SORCERER_PICK_BLOODLINE",
    condition = function(ctx)
        return state.number(ctx:speaker(), "current_sorcerer_level") == 0
    end,
}
main_responses[#main_responses + 1] = {
    text = "Pick a favorite spell",
    text_translation = {},
    topic = favorite_topic,
    condition = function(ctx)
        return state.number(ctx:speaker(), "available_favorite_spells") > 0
    end,
}
main_responses[#main_responses + 1] = quit

ccb.dialogue.register_topic {
    id = main_topic,
    dynamic_line = "Level <u_val:current_sorcerer_level> Sorcerer.\nCurrent EXP: <u_val:available_exp_sorcerer>.\nEXP to next level: <u_val:exp_to_sorcerer_level>.",
    dynamic_line_translation = {},
    responses = main_responses,
}
