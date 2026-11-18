local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local returning = require("raid_return")
local healing = require("raid_healing")
local id = services.types.id

ccb.runtime.handler("sky_return_home_due", function(payload)
    returning.home(payload.character)
end)

ccb.runtime.handler("sky_prevent_death", function(hook)
    local character = hook.character
    if hook.results.allowed == false or not state.checked(services.creatures.snapshot(character)).dead then return end
    if state.checked(services.inventory.has_items(character, id("item", "warphome"), 1, 0)) then
        state.checked(services.characters.prevent_death(character))
        returning.home(character)
        healing.full(character)
        state.message(character, ccb.services.translate("Moments before your last breath leaves your body, the mote of warp essence on you jolts with a brilliant energy.  Its thin filament immediately snaps tight, reeling you home faster than you can process what it was that just saved your life.  The mote is spent, but you arrive home alive and well."), "neutral", true)
    elseif not state.has_trait(character, "awayfromhome") then
        state.checked(services.characters.prevent_death(character))
        state.add_effect(character, "downed", 1)
        state.add_effect(character, "incorporeal", 500)
        healing.death(character)
        state.message(character, ccb.services.translate("You died at home?  What's the matter with you?  Stop this.  You are restored.  The powers that be have made you temporarily incorporeal, in case you were stuck in a deadly loop."), "neutral", true)
    else
        state.checked(services.characters.prevent_death(character))
        state.add_effect(character, "incorporeal", 1)
        state.add_effect(character, "downed", 1)
        healing.death(character)
        state.checked(services.inventory.receive_item(character, id("item", "corpse_painful"), 1))
        state.set("raidslost", state.number("raidslost") + 1)
        if services.gameplay.mods.is_loaded("bombastic_perks") then
            services.gameplay.environment.clear_saved_dimension("dimension_perk_closetland")
        end
        ccb.tasks.after_character_turn(character, 1, "sky_return_home_due")
        state.message(character, ccb.services.translate("You feel the icy grip of death begin to take you, and the world whirls and rushes past.  Reality bends and at the peak of your last mortal moment, something snags you and hauls you through space and time.  Your mind has been preserved, at cost, and your body is not far behind."), "neutral", true)
    end
    -- A still-fatal rescue must remain available to the other native death rules.
    if state.checked(services.creatures.snapshot(character)).dead then return end
    return false
end)
-- Existing rescues, including FCL's blood brain, run before the Island's fallback.
ccb.runtime.hook("on_avatar_fatal", "sky_prevent_death", { priority = -1 })
