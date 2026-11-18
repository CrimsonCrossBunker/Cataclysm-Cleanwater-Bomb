local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local variables = services.variables
local id = services.types.id
local sky_island = content.is_mod_active("skyisland")

local progress = "lilin_amount_of_ruach_spent_for_powers"
local increase = progress .. "_increaser"

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(character, key)
    return value(variables.get_number(character, key)).value or 0
end

local function tell_player(character, text)
    if character.subtype == "avatar" then services.messages.add(text, "bad") end
end

ccb.runtime.handler("lilin_commit_ruach", function(context)
    local character = context.character
    local vitamin = id("vitamin", "lilin_ruach_vitamin")
    local stored = value(services.needs.get_vitamin(character, vitamin))
    if stored < 240 then
        tell_player(character, services.translate("You don't have enough ruach to dedicate any to increasing your powers!"))
        return
    end
    if sky_island and value(services.effects.has(character, id("effect", "effect_si_lilin_no_ruach_upgrades"))) then
        tell_player(character, services.translate("Your spirit is still fragile after your brush with death.  You have no ruach to spare."))
        return
    end
    value(services.needs.set_vitamin(character, vitamin, stored - 240))
    local increment = number(character, increase) + 0.75
    value(variables.set(character, increase, increment, { include_before = false }))
    value(variables.set(character, progress, number(character, progress) + increment, { include_before = false }))
end)

local lilin = content.Mutation {
    id = "LILIN_TRAITS",
    name = content.text("Lilit"),
    description = content.text("You are one of the lilin, a hunter in the night, driven to feed on the spiritual essence (some might say the soul) of your prey.  Probably you were born that way, but maybe it happened to due to a malediction, or some artifact you found in a place best forgotten.  Regardless, it is your gift and your curse now, and you must use your powers to survive.\n\nYou may activate this trait to spend some ruach toward increasing your power.  You must be outside under the moonlight to have a chance of gaining new lilin powers."),
    points = 2,
    mixed_effect = true,
    valid = false,
    starting_trait = false,
    purifiable = false,
    active = true,
    on_activate = "lilin_commit_ruach",
    activation_message = content.text("You dedicate some ruach to increasing your power."),
    categories = { "LILIN" },
    types = { "HERITAGE" },
    flags = { "HERITAGE" },
}
lilin:relationship("allowed_category", "LILIN")
lilin:relationship("cancel", "DREAMER")
lilin:relationship("cancel", "DREAMSMITH")
lilin:relationship("cancel", "EATER")
lilin:relationship("cancel", "INVENTOR")
lilin:relationship("cancel", "CHAOTIC")
lilin:relationship("cancel", "CHAOTIC_BAD")
lilin:relationship("enchantment", "INLINE_ENCH_LILIN_TRAITS_0")
lilin:integer_value("anger_relation", "VAMPIRE", -40)
lilin:integer_value("anger_relation", "HOMULLUS", 30)
content.add(lilin)
