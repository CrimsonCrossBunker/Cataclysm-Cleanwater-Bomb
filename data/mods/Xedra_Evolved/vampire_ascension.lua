local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local cleanup = require("vampire_power_cleanup")
local remove_drowned_morals = require("vampire_morality")
local weaknesses = require("vampire_weaknesses")

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function advance_potency(character, effect)
    local result = services.effects.add(character, id("effect", effect), services.time.duration(1, "turn"),
        { intensity = 1, permanent = true })
    if not result.ok and result.error.code ~= "rejected" then
        error(result.error.message)
    end
end

local function first_active_mission(character, mission_id)
    local offset = 0
    while true do
        local page = services.missions.active(character, { offset = offset })
        for _, mission in ipairs(page.items) do
            if mission.in_progress and mission.id.value == mission_id then
                return mission.token
            end
        end
        if not page.has_more then
            return nil
        end
        offset = offset + page.returned
    end
end

ccb.runtime.handler("vampire_sacrifice", function(event)
    local character = event.actors.killer or services.characters.avatar()
    if not value(services.mutations.has_id_text(character, "VAMPIRE3")) then
        return
    end
    local mission = first_active_mission(character, "KILL_YOUR_BEST_FRIEND")
    if not mission then
        return
    end
    local ready = services.effects.get(character, id("effect", "about_to_kill_best_friend"), id("body_part", "bp_null"))
    if not ready.ok and ready.error.code == "not_found" then
        return
    end
    value(ready)

    value(services.missions.finish(character, mission))
    value(services.mutations.replace(character, id("mutation", "VAMPIRE4")))
    weaknesses.grant(character, 1)
    value(services.factions.set_reputation(id("faction", "vampire_hunters"),
        { likes = -100, respects = -100, trusts = -100 }))
    cleanup.remove_dream_magic(character)
    cleanup.remove_other_supernatural_powers(character)
    remove_drowned_morals(character)
    advance_potency(character, "vampire_virus_ascendant")
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("Your eyes redden even more as you pass a point of no return."), "mixed")
        services.messages.add(ccb.services.translate("You feel your thirst for blood deepen as you kill someone who fully trusted you."), "mixed")
    end
end)
ccb.runtime.on("game:character_kills_character", "vampire_sacrifice")

ccb.dialogue.register_topic {
    id = "TALK_VAMPIRE_MENTOR_MAKE_TIER_5",
    dynamic_line = function()
        return ccb.services.translate("[Your mentor takes the components and engages in a complex ritual, before passing you a bowl filled with a red liquid].  Drink it, and you'll have completed the process of walking the path.")
    end,
    responses = function()
        return {
            {
                text = ccb.services.translate("[Drink it]"),
                topic = "TALK_VAMPIRE_MENTOR_BECAME_TIER_5",
                on_action = function(context)
                    local character = context:speaker()
                    local mission = first_active_mission(character, "GET_COMPONENTS_FOR_TIER_5")
                    if mission then
                        value(services.missions.finish(character, mission))
                    end
                    value(services.mutations.replace(character, id("mutation", "BLOOD_DRINKER")))
                    remove_drowned_morals(character)
                    weaknesses.grant(character, 2)
                    advance_potency(character, "vampire_virus_post_mortal")
                    if character.subtype == "avatar" then
                        services.messages.add(ccb.services.translate("Your thirst for blood grows, and so does your power, as you reach the final state of vampirism."), "mixed")
                    end
                end,
            },
        }
    end,
}
