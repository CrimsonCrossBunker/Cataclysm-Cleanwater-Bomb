local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local environment = services.gameplay.environment

local unsuitable_terrain = {
    t_vitrified_sand = true,
    t_pit_corpsed = true,
    t_fungus = true,
    t_glassed_sand = true,
    t_rubber_mulch = true,
    t_swater_surf = true,
    t_woodchips = true,
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function near_earth(position)
    if position.z < 0 then
        return true
    end
    local terrain = environment.terrain_id(position)
    return not unsuitable_terrain[terrain] and (terrain == "t_rock_floor"
        or terrain == "t_rock_floor_no_roof" or environment.terrain_has_flag(position, "DIGGABLE"))
end

local function check_earth_sleep(character)
    if not checked(services.mutations.has_id_text(character, "VAMPIRE_WEAKNESS_EARTH_SLEEP")) then
        return
    end
    local position = checked(services.creatures.snapshot(character)).position
    local avatar = character.subtype == "avatar"
    if near_earth(position) then
        if avatar then
            services.messages.add(services.translate(
                "Your sleep has been restful, thanks to the proximity of the earth."), "info")
        end
        return
    end
    checked(services.effects.add(character, id("effect", "effect_earth_sleeper_penalty"),
        services.time.duration(24, "hour"), { intensity = 1 }))
    local sleepiness = checked(services.needs.get(character)).sleepiness
    checked(services.needs.set(character, { sleepiness = sleepiness + 550 }))
    if avatar then
        services.messages.add(services.translate(
            "You struggle to awaken, feeling tired and weakened.  Having slept away from the earth, your sleep wasn't as restful as it should've been."),
            "bad")
    end
end

ccb.runtime.handler("finish_vampire_torpor", function(activity)
    local character = activity.character
    checked(services.needs.set(character, { sleepiness = 0, sleep_deprivation = 0 }))
    check_earth_sleep(character)
end, 1)

ccb.runtime.handler("check_earth_sleep_on_wake", function(event)
    check_earth_sleep(event.actors.character or services.characters.avatar())
end, 1)
ccb.runtime.on("game:character_wakes_up", "check_earth_sleep_on_wake")

content.add(content.ActivityType {
    id = "ACT_VAMPIRE_TORPOR",
    verb = content.text("slumbering"),
    based_on = "time",
    can_resume = false,
    interruptable = false,
    interruptable_with_keyboard = false,
    rooted = true,
}:on_finish("finish_vampire_torpor"))
