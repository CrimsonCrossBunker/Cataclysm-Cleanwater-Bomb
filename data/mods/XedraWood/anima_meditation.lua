local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local activity = "ACT_XEDRAWOOD_MEDITATE"
local activity_id = id("activity", activity)
local meditation = id("effect", "effect_pattern_tattoo_meditation")
local whole_body = id("body_part", "bp_null")
local full_day = services.time.duration(24, "hour")

local rock = {
    t_rock = true,
    t_rock_floor_no_roof = true,
    t_rock_floor = true,
    t_rock_smooth = true,
    t_coast_rock_surf = true,
    t_shore_boulder = true,
    t_nl_rock_floor = true,
    t_string_dimension_meteoric_rock = true,
    t_string_dimension_meteoric_rock_charred = true,
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("check_anima_meditation", function(activity)
    local character = activity.character
    local energy = checked(services.bionics.summary(character))
    if not energy.has_capacity or energy.power:compare(energy.maximum_power) ~= 0 then
        return
    end
    checked(services.activities.cancel(character))
    checked(services.effects.remove(character, meditation))
    if character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("Replete with anima, you cease your meditations."), "good")
    end
end, 1)

content.add(content.ActivityType {
    id = activity,
    verb = ccb.content.text("meditating"),
    based_on = "time",
    activity_level = 1,
    rooted = true,
}:on_turn("check_anima_meditation"))

ccb.runtime.handler("can_meditate_on_mountain", function(context)
    local creature = checked(services.creatures.snapshot(context.speaker))
    if creature.position.z <= -1 and not creature.outside then return true end
    return rock[services.environment.terrain_id(creature.position)] == true
end)

ccb.runtime.handler("start_mountain_meditation", function(impact)
    local character = impact.target_creature
    local applied = services.effects.add(character, meditation, full_day)
    if not applied.ok and applied.error.code ~= "rejected" then error(applied.error.message) end
    if character.subtype == "avatar" or character.subtype == "npc" or character.subtype == "character" then
        checked(services.activities.assign_timed(character, activity_id, full_day))
    end
end)

ccb.runtime.handler("finish_mountain_meditation", function(event)
    if event.data.activity ~= activity then return end
    local character = event.actors.speaker or event.actors.character or services.characters.avatar()
    if checked(services.effects.has(character, meditation, whole_body, -1)) then
        checked(services.effects.remove(character, meditation, whole_body))
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You cease meditating."), "neutral")
        end
    end
end)
ccb.runtime.on("game:character_finished_activity", "finish_mountain_meditation")

content.add(content.Spell {
    id = "pattern_tattoo_mountain_meditation",
    name = ccb.content.text("Anima Meditations"),
    description = "Meditate to regain anima.",
    message = ccb.content.text("You cast %s!"),
    sound_description = ccb.content.text("an explosion."),
    valid_targets = { "self" },
    max_level = 1,
    flags = { "SILENT", "NO_EXPLOSION_SFX", "NO_FAIL" },
    spell_class = "TATTOOS_BASIC_TRAIT",
    skill = "deduction",
    shape = "blast",
}:caster_when("can_meditate_on_mountain",
    ccb.content.text("You must underground or on the living rock to meditate on the Mountain."))
    :lua_impact("start_mountain_meditation"))
