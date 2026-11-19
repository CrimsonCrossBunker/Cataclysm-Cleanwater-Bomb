local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function assign_mission(actor, mission)
    local reserved = checked(services.missions.reserve(id("mission", mission)))
    checked(services.missions.assign(actor, reserved.token))
end

local function has_item(actor, item)
    local resources = checked(services.inventory.resources(actor, id("item", item), 1))
    return resources.charges > 0 or resources.has_amount
end

local function message(ctx, text, severity, show_popup)
    if ctx.character.subtype ~= "avatar" then
        return
    end
    local point = ctx.position
    local position = services.coords.tripoint_abs_ms(point.x, point.y, point.z)
    text = checked(services.text.expand_for(text, ctx.character, nil, nil,
        { this = ctx.furniture_id, pos = position }, true))
    if show_popup then
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
    end
    services.messages.add(text, severity)
end

local function number_value(actor, key)
    local result = services.variables.get_number(actor, key, { strict = true })
    if not result.ok and result.error.code == "variable_type_mismatch" then
        return nil
    end
    return checked(result).value or 0
end

local function string_value(actor, key)
    return checked(services.variables.get_string(actor, key)).value or ""
end

local function transform_radius(actor, radius, transform)
    local point = checked(services.creatures.snapshot(actor)).position
    checked(services.world.transform_radius(point, radius, id("terrain_furniture_transform", transform)))
end

ccb.runtime.handler("examine_f_exodii_signpost", function(ctx)
    local actor = ctx.character
    if checked(services.missions.has_active(actor, id("mission", "directions_exodii_signpost"))) then
        message(ctx,
            ccb.services.translate("You study the signpost.  It shows a similar set of directions to the ones you already have.  You cross-reference them and don't learn anything new."), "neutral", true)
    end
    if not (checked(services.missions.has_active(actor, id("mission", "directions_exodii_signpost")))) then
        message(ctx,
            ccb.services.translate("You study the signpost.  It shows simply-drawn pictograms of a pair of hands holding out an object, and another pair taking the object and offering a pouch in return.  Beneath the pictures there's a crude but understandable map with arrows pointing to what looks like some kind of castle.  You do your best to relate those to landmarks you know about, and mark the likely location on your map."), "neutral", true)
        assign_mission(actor, "directions_exodii_signpost")
    end
end)

ccb.runtime.handler("examine_f_exodii_locator_antenna", function(ctx)
    local actor = ctx.character
    if number_value(actor, "rebooted_locator") == 1 then
        message(ctx, ccb.services.translate("The locator is already active"), "neutral", false)
    end
    if (not (has_item(actor, "warehouse_rebooter")) and number_value(actor, "rebooted_locator") == 0) then
        message(ctx, ccb.services.translate("You don't have anything that could reactivate this device"), "neutral",
            false)
    end
    if (has_item(actor, "warehouse_rebooter") and number_value(actor, "rebooted_locator") == 0) then
        message(ctx,
            ccb.services.translate("You plug the rebooter in the locator.\n<color_light_green>The locator reactivates.</color>"), "neutral", false)
        checked(services.inventory.consume_by_type(actor, id("item", "warehouse_rebooter"), 1, 0))
        checked(services.variables.set(actor, "rebooted_locator", 1, { include_before = false }))
    end
end)

ccb.runtime.handler("examine_f_impaled_officer", function(ctx)
    local actor = ctx.character
    services.interaction.open_topic(actor, "TALK_XEDRA_MERC_MAIN")
end)

ccb.runtime.handler("examine_f_empty_spike", function(ctx)
    message(ctx, ccb.services.translate("The body is gone but it can't have gone far, you need to destroy it."),
        "neutral", false)
end)

ccb.runtime.handler("examine_f_vitrified_doll", function(ctx)
    local actor = ctx.character
    if not (has_item(actor, "imperfect_doll_complete")) then
        services.interaction.open_topic(actor, "vitrified_doll_talk_main")
    end
end)

ccb.runtime.handler("examine_f_vitrified_bookcase_talker", function(ctx)
    local actor = ctx.character
    if not (has_item(actor, "imperfect_doll_features")) then
        services.interaction.open_topic(actor, "vitrified_bookcase_talk_main")
    else
        message(ctx, ccb.services.translate("This bookshelf is complete, now."), "good", false)
    end
end)

ccb.runtime.handler("examine_t_nl_obelisk_0", function(ctx)
    local actor = ctx.character
    if checked(services.mutations.has(actor, id("mutation", "LS_Passcode_0"))) then
        message(ctx, ccb.services.translate("You already know the Thief's Pass.  The obelisk is inert."), "neutral",
            false)
    end
    if ("yes" == string_value(actor, "ls_had_a_passcode") and not (checked(services.mutations.has(actor, id("mutation",
        "LS_Passcode_0"))))) then
        message(ctx,
            ccb.services.translate("You see a tall, olive green, metallic pillar covered in swirling patterns.  As you focus on it, you feel a burning sensation on your skin.  You have learned the Thief's Passcode."), "neutral", true)
        checked(services.mutations.replace(actor, id("mutation", "LS_Passcode_0")))
    end
    if not ("yes" == string_value(actor, "ls_had_a_passcode")) then
        message(ctx,
            ccb.services.translate("You see a tall, olive green, metallic pillar covered in swirling patterns.  As you focus on it, you feel a burning sensation on your skin.  <ls_obelisk_firsttime1> a tattoo of your own face, smirking; it's the 'Thief's Passcode'."), "neutral", true)
        checked(services.mutations.replace(actor, id("mutation", "LS_Passcode_0")))
        services.variables.set_string_notifying(actor, "ls_had_a_passcode", "yes")
    end
end)

ccb.runtime.handler("examine_t_nl_obelisk_1", function(ctx)
    local actor = ctx.character
    if checked(services.mutations.has(actor, id("mutation", "LS_Passcode_1"))) then
        message(ctx, ccb.services.translate("You already know the Circle of Wings Passcode.  The obelisk is inert."),
            "neutral", false)
    end
    if ("yes" == string_value(actor, "ls_had_a_passcode") and not (checked(services.mutations.has(actor, id("mutation",
        "LS_Passcode_1"))))) then
        message(ctx,
            ccb.services.translate("You see a squat, angry-looking, indigo metallic pillar covered carved in relief with the image of flying birds.  As you focus on it, you feel a burning sensation on your skin.  You have learned the Circle of Wings Passcode."), "neutral", true)
        checked(services.mutations.replace(actor, id("mutation", "LS_Passcode_1")))
    end
    if not ("yes" == string_value(actor, "ls_had_a_passcode")) then
        message(ctx,
            ccb.services.translate("You see a squat, angry-looking, indigo metallic pillar covered carved in relief with the image of flying birds.  As your eyes are drawn to it, you feel a burning sensation on your skin.  <ls_obelisk_firsttime1> a tattoo of wings in a circle, running into themselves like an ouroboros; it's the 'Circle of Wings Passcode'."), "neutral", true)
        checked(services.mutations.replace(actor, id("mutation", "LS_Passcode_1")))
        services.variables.set_string_notifying(actor, "ls_had_a_passcode", "yes")
    end
end)

ccb.runtime.handler("examine_t_nl_obelisk_2", function(ctx)
    local actor = ctx.character
    if checked(services.mutations.has(actor, id("mutation", "LS_Passcode_2"))) then
        message(ctx, ccb.services.translate("You already know the Hard Nails Passcode.  The obelisk is inert."),
            "neutral", false)
    end
    if ("yes" == string_value(actor, "ls_had_a_passcode") and not (checked(services.mutations.has(actor, id("mutation",
        "LS_Passcode_2"))))) then
        message(ctx,
            ccb.services.translate("You see a thick, powerful, gold-burnished pillar covered in what look like deep fingernail scratches.  As you focus on it, you feel a burning sensation on your skin.  You have learned the Hard Nails Passcode."), "neutral", true)
        checked(services.mutations.replace(actor, id("mutation", "LS_Passcode_2")))
    end
    if not ("yes" == string_value(actor, "ls_had_a_passcode")) then
        message(ctx,
            ccb.services.translate("You see a thick, powerful, gold-burnished pillar covered in what look like deep fingernail scratches.  As your eyes are drawn to it, you feel a burning sensation on your skin.  <ls_obelisk_firsttime1> a tattoo of a hand clawing down a sheet of metal; it's the 'Hard Nails Passcode'."), "neutral", true)
        checked(services.mutations.replace(actor, id("mutation", "LS_Passcode_2")))
        services.variables.set_string_notifying(actor, "ls_had_a_passcode", "yes")
    end
end)

ccb.runtime.handler("examine_t_nl_obelisk_3", function(ctx)
    local actor = ctx.character
    if checked(services.mutations.has(actor, id("mutation", "LS_Passcode_3"))) then
        message(ctx, ccb.services.translate("You already know the Laughing Man Passcode.  The obelisk is inert."),
            "neutral", false)
    end
    if ("yes" == string_value(actor, "ls_had_a_passcode") and not (checked(services.mutations.has(actor, id("mutation",
        "LS_Passcode_3"))))) then
        message(ctx,
            ccb.services.translate("You see a beautiful pillar the color of roses or blood, absolutely perfect in its proportions.  As your eyes are drawn to it, you feel a burning sensation on your skin.  You have learned the Laughing Man Passcode."), "neutral", true)
        checked(services.mutations.replace(actor, id("mutation", "LS_Passcode_3")))
    end
    if not ("yes" == string_value(actor, "ls_had_a_passcode")) then
        message(ctx,
            ccb.services.translate("You see a beautiful pillar the color of roses or blood, absolutely perfect in its proportions.  As your eyes are drawn to it, you feel a burning sensation on your skin.  <ls_obelisk_firsttime1> a tattoo of a handsome man laughing.  At first glance it appears charming and friendly, but the longer you examine it, the more it appears to be inhumanly cold and cruel; it's the 'Laughing Man Passcode'."), "neutral", true)
        checked(services.mutations.replace(actor, id("mutation", "LS_Passcode_3")))
        services.variables.set_string_notifying(actor, "ls_had_a_passcode", "yes")
    end
end)

ccb.runtime.handler("examine_t_nl_obelisk_mission_boiler", function(ctx)
    local actor = ctx.character
    if checked(services.missions.has_active(actor, id("mission", "MISSION_nl_boiler"))) then
        message(ctx, ccb.services.translate("The obelisk is inert."), "neutral", false)
    end
    if not (checked(services.missions.has_active(actor, id("mission", "MISSION_nl_boiler")))) then
        message(ctx,
            ccb.services.translate("You see a tall, drab grey, metallic pillar covered in swirling patterns.  As you focus on it, the patterns take the shape of a face, its features clouded by fractal overlays.  It speaks to you, booming loudly as if from some distant place:\n\n Hear this: a source of power was found in this place.\n Seek it out.  Retrieve it.\n Its power will be YOURS.\n A terminal marks its location.\n The terminal will anchor the rhythm of the object.\n Activate the terminal.\n And you,\n and that which will then be bound to you,\n will be carried home."), "neutral", true)
        assign_mission(actor, "MISSION_nl_boiler")
    end
end)

ccb.runtime.handler("examine_t_nl_obelisk_mission_water_cooler", function(ctx)
    local actor = ctx.character
    if checked(services.missions.has_active(actor, id("mission", "MISSION_nl_water_cooler"))) then
        message(ctx, ccb.services.translate("The obelisk is inert."), "neutral", false)
    end
    if not (checked(services.missions.has_active(actor, id("mission", "MISSION_nl_water_cooler")))) then
        message(ctx,
            ccb.services.translate("You see a tall, drab grey, metallic pillar covered in swirling patterns.  As you focus on it, the patterns take the shape of a face, its features clouded by fractal overlays.  It speaks to you, booming loudly as if from some distant place:\n\n Hear this: a source of HUMAN lifeblood is here.\n But it is hidden to me.\n Seek it out.  Feed it,\n and it will be YOURS.\n Your blood will anchor the rhythm of the object.\n And you,\n and that which will then be bound to you,\n will be carried home."), "neutral", true)
        assign_mission(actor, "MISSION_nl_water_cooler")
    end
end)

ccb.runtime.handler("examine_t_nl_mission_water_cooler", function(ctx)
    local actor = ctx.character
    services.interaction.open_topic(actor, "COMP_LS_Water_Cooler_Exit_Controls")
end)

ccb.runtime.handler("examine_t_nl_obelisk_earth_broken", function(ctx)
    message(ctx,
        ccb.services.translate("The obelisk has broken in your absence.\nIt stands there.\nStaring at you.\nCrooked and silent."), "neutral", true)
end)

ccb.runtime.handler("examine_t_fault", function(ctx)
    message(ctx,
        ccb.services.translate("This wall is perfectly vertical.  Odd, twisted holes are set in it, leading as far back into the solid rock as you can see.  The holes are humanoid in shape, but with long, twisted, distended limbs."), "neutral", true)
end)

ccb.runtime.handler("examine_t_vitrified_pool_talker", function(ctx)
    local actor = ctx.character
    if not (has_item(actor, "imperfect_doll_legs")) then
        services.interaction.open_topic(actor, "vitrified_pool_talk_main")
    else
        message(ctx, ccb.services.translate("The sailboat drifts in slow circles through the sand."), "good", false)
    end
end)

ccb.runtime.handler("examine_t_vitrified_soil_talker", function(ctx)
    local actor = ctx.character
    if not (has_item(actor, "imperfect_doll_arms")) then
        services.interaction.open_topic(actor, "vitrified_soil_talk_main")
    else
        message(ctx, ccb.services.translate("A tiny glass sprout has begun to grow here."), "good", false)
    end
end)

ccb.runtime.handler("examine_t_door_metal_elocked_xedra3", function(ctx)
    local actor = ctx.character
    if "yes" == string_value(actor, "knows_xedra_field_station_3_passcode") then
        transform_radius(actor, 2, "unlock_elock_xedra3")
    else
        message(ctx, ccb.services.translate("You press four random buttons and nothing happens."), "neutral", true)
    end
end)
