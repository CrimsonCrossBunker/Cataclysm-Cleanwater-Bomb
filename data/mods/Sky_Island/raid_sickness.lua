local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local id = services.types.id
local M = {}

function M.tick(character)
    if not state.has_trait(character, "awayfromhome") then return end
    state.set("timeawayfromhome", state.number("timeawayfromhome") + 1)
    state.set("readablepulsesleft", 9 - state.number("timeawayfromhome"))
    state.set("readablesicknessintervals", state.number("currentpulselength") / 60)
    local pulses = state.number("timeawayfromhome")
    if pulses <= 7 then
        state.add_effect(character, "warpsickness", 1, 6, true)
        state.checked(services.effects.remove(character, id("effect", "warpdisintegration")))
        state.message(character, services.translate("Your body shivers slightly as a warp pulse passes through it.  Another pulse will hit in <global_val:readablesicknessintervals> minutes.  Warp sickness won't set in for another <global_val:readablepulsesleft> pulses."), "neutral", false)
    elseif pulses <= 8 then
        state.add_effect(character, "warpsickness", 1, 6, true)
        state.checked(services.effects.remove(character, id("effect", "warpdisintegration")))
        state.checked(services.effects.remove(character, id("effect", "sleep")))
        state.message(character, services.translate("Goosebumps cover your skin as a warp pulse passes through you.  You're only one warp pulse from your deadline."), "neutral", true)
    elseif pulses <= 9 then
        state.checked(services.effects.remove(character, id("effect", "warpdisintegration")))
        state.add_effect(character, "warpsickness", 1, 5, true)
        state.message(character, services.translate("A warp pulse passing through you twists your blood inside your veins and your eyes pulse in pain.  You've overstayed your welcome and need to get home."), "bad", true)
    elseif pulses <= 10 then
        state.checked(services.effects.remove(character, id("effect", "warpdisintegration")))
        state.add_effect(character, "warpsickness", 1, 4, true)
        state.message(character, services.translate("A warp pulse shudders through your head like a localized earthquake and your extremities surge with pain like they're peeling open.  You need to get home as soon as possible."), "bad", true)
    elseif pulses <= 11 then
        state.checked(services.effects.remove(character, id("effect", "warpdisintegration")))
        state.add_effect(character, "warpsickness", 1, 3, true)
        state.message(character, services.translate("Another warp pulse rocks through you and your organs wrench themselves over.  Existence is fracturing.  You need to get home immediately."), "mixed", true)
    elseif pulses <= 12 then
        state.add_effect(character, "warpsickness", 1, 2, true)
        state.checked(services.effects.remove(character, id("effect", "warpdisintegration")))
        state.message(character, services.translate("A sickening wet sound rips through you as another warp pulse hits.  You can feel your whole body trying to pull itself apart, and if you wait any longer, it just might.  If you want to live, you need to get home NOW!"), "mixed", true)
    else
        state.add_effect(character, "warpsickness", 1, 1, true)
        state.add_effect(character, "warpdisintegration", 1, 1, true)
        state.message(character, services.translate("As the warp pulse hits, you realize there are no words to describe how much trouble you're in.  Your body is crumbling to wet paste and your blood is twisting into a viny tangle.  All you know is pain.\nYou're not just dying, you're dying horribly.\nIf escape is already near you may survive against all odds, but oblivion is only moments away."), "mixed", true)
    end
end

function M.bonus(character)
    state.set("timeawayfromhome", state.number("timeawayfromhome") - 2)
    M.tick(character)
end

return M
