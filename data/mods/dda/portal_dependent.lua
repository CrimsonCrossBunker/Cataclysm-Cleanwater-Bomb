local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local id = services.types.id
local M = {}

local bad_messages = {
    "PORTAL_DEPENDENT_MESSAGES_VARIED_BAD",
    "PORTAL_DEPENDENT_MESSAGES_STR_BAD",
    "PORTAL_DEPENDENT_MESSAGES_DEX_BAD",
    "PORTAL_DEPENDENT_MESSAGES_PER_BAD",
    "PORTAL_DEPENDENT_MESSAGES_INT_BAD",
}

local function asleep(character)
    return state.checked(services.effects.has(character, id("effect", "sleep")))
end

local function snippet(character, category)
    if state.checked(services.creatures.snapshot(character)).kind ~= "avatar" then return end
    local text = services.snippets.native_random(category) or ""
    text = state.checked(services.text.expand_for(text, character, nil, nil, nil, true))
    services.messages.add(text, "mixed")
end

function M.messages_bad(character)
    if asleep(character) then
        snippet(character, "PORTAL_DEPENDENT_MESSAGES_DREAMS")
        return
    end
    local choice = services.random.weighted_index({ 1, 1, 1, 1, 1 })
    if state.checked(services.characters.snapshot(character)).senses.can_see then
        snippet(character, bad_messages[choice])
    end
end

function M.focus_bad(character)
    if asleep(character) then return end
    state.message(character, services.translate("You try to recall what you were about to do, but you can't focus…"), "bad")
    state.checked(services.characters.adjust(character, { focus = -10 }))
end

function M.damage_constant(character)
    if asleep(character) then return end
    state.message(character, services.translate("Your vision suddenly fills with cold sparks.  You feel so alone…"), "bad")
    state.add_effect(character, "pd_rejection", 15 * 60, 2)
end

return M
