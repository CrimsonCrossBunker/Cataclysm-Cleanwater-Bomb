local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local variables = services.variables
local environment = services.gameplay.environment

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function strength()
    return checked(variables.get_global_number("ps_str")).value or 0
end

local function spend_ire(character, amount)
    local current = checked(variables.get_number(character, "ire")).value or 0
    checked(variables.set(character, "ire", current - amount, { include_before = false }))
end

local function message(character, text)
    if character.subtype == "avatar" then services.messages.add(services.translate(text), "bad") end
end

ccb.content.add(ccb.content.ActivityType {
    id = "ACT_PSI_PORTAL_STUN",
    verb = "preparing",
    based_on = "time",
    activity_level = 1,
    interruptable = false,
    interruptable_with_keyboard = false,
    can_resume = false,
    auto_needs = false,
})

ccb.runtime.handler("portal_active_consciousness", function(character)
    if services.random.native_int(0, 14) ~= 0 then return end
    local duration = services.time.duration(math.floor(math.min(strength() * 0.1, 5) + 1), "turn")
    checked(services.effects.add(character, id("effect", "psi_stunned"), duration, { intensity = 0 }))
    checked(services.activities.assign_timed(character, id("activity", "ACT_PSI_PORTAL_STUN"), duration))
    spend_ire(character, 3)
    message(character, "Your head tingles and the world suddenly lurches!")
end)

ccb.runtime.handler("portal_active_blink", function(character)
    if not checked(services.creatures.snapshot(character)).outside
        or services.random.native_int(0, 19) ~= 0
        or checked(services.creatures.has_flag_text(character, "TELEPORT_LOCK"))
        or checked(services.creatures.has_flag_text(character, "TELESTOP"))
        or checked(services.inventory.has_worn_flag(character, id("json_flag", "PORTAL_PROOF"))) then return end
    checked(services.characters.cast_spell(character, id("spell", "teleport_blink_monster"),
        { min_level = math.tointeger(math.modf(strength() / 2)) }))
    spend_ire(character, 2)
    message(character, "The world shifts around you!")
end)

ccb.runtime.handler("portal_active_tears", function(character)
    if services.random.native_int(0, 9) ~= 0 then return end
    local origin = checked(services.creatures.snapshot(character)).position
    local result = services.world.find_location(origin, nil,
        { min_radius = 2, max_radius = 12, outdoor_only = true })
    if result.found then services.messages.add(services.translate("The nearby air cracks."), "bad") end
    environment.add_field_area(result.position or services.coords.tripoint_abs_ms(0, 0, 0),
        "fd_tear_in_reality_temporary", { radius = 0, intensity = 3, outdoor_only = true })
    spend_ire(character, 5)
end)

ccb.runtime.handler("portal_active_choose", function(character)
    local names = {
        "stuck_start", "pain", "dimension", "hallucinator", "smoke", "yrax", "swarm", "taunt",
        "shifting_mass", "artifact", "consciousness", "blink", "tears",
    }
    local choice = services.random.weighted_index({ 2, 2, 1, 2, 2, 1, 2, 1, 1, 1, 1, 2, 1 })
    ccb.runtime.call_character("portal_active_" .. names[choice], character)
end)
