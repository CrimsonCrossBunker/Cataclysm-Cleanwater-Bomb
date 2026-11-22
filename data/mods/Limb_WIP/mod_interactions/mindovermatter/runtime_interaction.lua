local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local needs = services.needs
local id = services.types.id
local random = services.random

local limbs = {
    { "RIGHT_LEG", "right_leg", function() return services.translate("Your right leg has been restored.") end },
    { "LEFT_LEG", "left_leg", function() return services.translate("Your left leg has been restored.") end },
    { "RIGHT_ARM", "right_arm", function() return services.translate("Your right arm had been restored.") end },
    { "LEFT_ARM", "left_arm", function() return services.translate("Your left arm had been restored.") end },
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function change_vitamin(character, name, delta)
    local vitamin = id("vitamin", name)
    local current = checked(needs.get_vitamin(character, vitamin))
    local amount = math.modf(current + delta)
    checked(needs.set_vitamin(character, vitamin, amount))
end

local function restore_limb(character, trait, storage_key)
    checked(services.mutations.erase(character, id("mutation", "NO_" .. trait)))
    checked(services.variables.remove(character, storage_key, { include_before = false }))
    checked(services.mutations.replace(character, id("mutation", "HAS_" .. trait)))

    -- A single restoration consumes about 2.5 times the resources of a full super heal.
    checked(needs.modify_calories(character, math.modf(-random.native_float(1875, 9375)), true))
    change_vitamin(character, "iron", -random.native_float(1875, 7500))
    change_vitamin(character, "calcium", -random.native_float(3750, 7500))
    change_vitamin(character, "vitC", -random.native_float(750, 3000))
    local sleepiness = checked(needs.get(character)).sleepiness
    checked(needs.set(character, {
        sleepiness = math.modf(sleepiness + random.native_float(75, 375)),
    }))
end

for _, limb in ipairs(limbs) do
    local trait, limb_key, success_message = limb[1], limb[2], limb[3]
    local handler = "restore_" .. limb_key
    local storage_key = "traits_limbs_missing_" .. limb_key

    ccb.runtime.handler(handler, function(activity)
        local character = activity.character
        local die = random.native_int(1, 10)
        local level = checked(services.spells.effective_level(character, "vita_limb_restore"))
        local success = die + random.native_int(math.min(0, level), math.max(0, level)) > 14
        if success then
            if character.subtype == "avatar" then
                services.messages.add(success_message(), "good")
            end
            restore_limb(character, trait, storage_key)
        elseif character.subtype == "avatar" then
            services.messages.add(services.translate("Your healing powers were not great enough, you'll have to try again."),
                "bad")
        end
        change_vitamin(character, "vitamin_psionic_drain", random.native_float(45, 75))
    end, 1)

    content.add(content.ActivityType {
        id = "ACT_VITAKIN_RESTORE_LIMB_" .. trait,
        verb = content.text("meditating"),
        based_on = "time",
        activity_level = 2,
    }:on_finish(handler))
end
