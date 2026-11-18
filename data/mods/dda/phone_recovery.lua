local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local basic_activity = "ACT_PHONE_RECOVERY_BASIC"
local advanced_activity = "ACT_PHONE_RECOVERY_ADVANCED"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function advanced_available(character)
    local tool = id("item", "software_hacking")
    local has_software = checked(services.inventory.has_software(character, tool, 20, id("item", "laptop")))
        or checked(services.inventory.has_software(character, tool, 20, id("item", "laptop_screen_lit")))
    return has_software and checked(services.skills.level(character, "computer")) >= 4
end

ccb.runtime.handler("start_phone_recovery", function(use)
    local character = use.character
    if not character then
        return 0
    end
    local choice = services.interaction.choose({
        {
            id = "basic",
            label = ccb.services.translate("Simple recovery"),
            description = ccb.services.translate("Reset the smartphone completely, erasing all the data inside, but allowing to use it without restrictions."),
        },
        {
            id = "advanced",
            label = ccb.services.translate("Advanced recovery"),
            description = ccb.services.translate("Use your computer knowledge, computer, and hackPRO, to bypass the restrictions while preserving the data inside.  Requires computer skill 4, copy of hackPRO, and laptop with at least 10 charges."),
            enabled = advanced_available(character),
        },
    }, {
        title = ccb.services.translate("Pick the recovery type"),
        allow_cancel = true,
        highlight_disabled = true,
        show_descriptions = true,
    })
    if not choice.accepted then
        return 0
    end
    local phones = checked(services.inventory.resources(character, id("item", "smart_phone_locked"), 1)).amount
    if choice.id == "advanced" and not advanced_available(character) then
        return 0
    end
    local advanced = choice.id == "advanced"
    local minutes = advanced and 90 + (phones - 1) * 15 or 15 + (phones - 1) * 5
    local assigned = services.activities.assign_timed(character, id("activity", advanced and advanced_activity or basic_activity),
        services.time.duration(minutes, "minute"))
    if not assigned.ok and assigned.error.code ~= "assignment_rejected" then
        checked(assigned)
    end
    return 0
end, 1)

local function recovery_message(character, recovered, single, multiple)
    if character.subtype == "avatar" then
        services.messages.add(recovered == 1 and single or multiple, "good")
    end
end

ccb.runtime.handler("finish_basic_phone_recovery", function(activity)
    local character = activity.character
    local locked = id("item", "smart_phone_locked")
    local group = id("item_group", "smart_phone_discharged")
    local recovered = 0
    for _, phone in ipairs(checked(services.inventory.items_of_type(character, locked))) do
        if phone:is_valid() then
            checked(services.inventory.consume_by_type(character, locked, 1, 0))
            checked(services.inventory.receive_group(character, group))
            recovered = recovered + 1
        end
    end
    recovery_message(character, recovered, ccb.services.translate("You recovered the locked smartphone."),
        ccb.services.translate("You recovered all the smartphones you had."))
end, 1)

ccb.runtime.handler("finish_advanced_phone_recovery", function(activity)
    local character = activity.character
    local recovered = 0
    local unlocked = id("item", "smart_phone")
    for _, phone in ipairs(checked(services.inventory.items_of_type(character, id("item", "smart_phone_locked")))) do
        if phone:is_valid() then
            checked(services.items.transform(phone, unlocked, { carrier = character, active = false }))
            recovered = recovered + 1
        end
    end
    local laptops = checked(services.inventory.items_of_type(character, id("item", "laptop"), true))
    if #laptops > 0 then
        checked(services.items.modify_battery_charges(laptops[#laptops], -20))
    end
    recovery_message(character, recovered, ccb.services.translate("You recovered the locked smartphone and the data inside of it."),
        ccb.services.translate("You recovered all the smartphones you had and the data inside of them."))
end, 1)

content.add(content.ActivityType {
    id = basic_activity,
    verb = ccb.content.text("recovering"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
}:on_finish("finish_basic_phone_recovery"))

content.add(content.ActivityType {
    id = advanced_activity,
    verb = ccb.content.text("recovering"),
    based_on = "time",
    activity_level = 1,
    can_resume = false,
}:on_finish("finish_advanced_phone_recovery"))

content.add(content.ItemGroup {
    id = "smart_phone_discharged",
    kind = "distribution",
}:entry { item = "smart_phone", charges = { 3, 11 } })

-- The locked phone's inherited hardware and other actions come from its existing definition.
local phone = content.Item { id = "smart_phone_locked", copy_from = "smart_phone_locked" }
phone:on_use("start_phone_recovery", ccb.content.text("Recover"),
    ccb.content.text("You can reset the smartphone to be able to use all its functions."))
content.replace(phone)
