local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local id = services.types.id
local checked = state.checked

local function expand(ctx, text)
    local point = ctx.position
    local position = services.coords.tripoint_abs_ms(point.x, point.y, point.z)
    return checked(services.text.expand_for(text, ctx.character, nil, nil,
        { this = ctx.furniture_id, pos = position }, true))
end

local function has_deposit(actor, key)
    return checked(services.variables.get(actor, key)).value ~= nil
end

local function can_deposit(actor, entry)
    if entry.count then
        if not checked(services.inventory.has_items(actor, id("item", entry.item), entry.count, 0)) then
            return false
        end
    else
        local available = checked(services.inventory.resources(actor, id("item", entry.item), 1))
        if not available.has_amount and available.charges <= 0 then
            return false
        end
    end
    return not has_deposit(actor, entry.key)
end

local function build_room(actor, room)
    local update = room.update
    if room.prior_room and state.number(room.prior_room) == 1 then
        update = room.alternate_update
    end
    local origin = state.position(actor):project_to("omt")
    local safehouse = services.overmap.find_target(origin, "labyrinth_safehouse"):project_to("ms")
    local position = services.world.find_location(safehouse).position
    checked(services.variables.set_global("LS_SAFEHOUSE_1", position, { include_before = false }))
    state.update_map(position, update)
    state.set(room.placed, 1)
end

local function register_obelisk(handler, room)
    ccb.runtime.handler(handler, function(ctx)
        local actor = ctx.character
        local title = expand(ctx, ccb.services.translate(
            "You see before you a floor to ceiling, shining column.\n\nA massive face with a gaping jaw is cast upon it.\n\nInside the mouth are several pre-fabricated slots.\n\nThe slots are clearly labeled:"))
        local choices = {}
        for index, entry in ipairs(room.entries) do
            choices[index] = {
                id = entry.key,
                enabled = can_deposit(actor, entry),
                label = expand(ctx, entry.label()),
                description = expand(ctx, entry.description()),
            }
        end
        local selection = services.interaction.choose(choices, {
            title = title,
            allow_cancel = true,
            show_descriptions = true,
        })
        local entry = selection.index and room.entries[selection.index]
        if not entry or not can_deposit(actor, entry) then
            return
        end
        checked(services.inventory.consume_by_type(actor, id("item", entry.item), entry.count or 1, 0))
        services.variables.set_string_notifying(actor, entry.key, "yes")
        for _, requirement in ipairs(room.entries) do
            if not has_deposit(actor, requirement.key) then
                return
            end
        end
        state.message(actor, expand(ctx, room.complete()), "neutral", true)
        build_room(actor, room)
    end)
end

register_obelisk("examine_t_nl_obelisk_mission_utility_space", {
    prior_room = "nl_autodoc_placed",
    alternate_update = "labyrinth_safehouse_utility_space_if_autodoc_first",
    placed = "nl_utility_space_placed",
    update = "labyrinth_safehouse_utility_space",
    complete = function()
        return ccb.services.translate(
            "The jaw on the stele snaps shut and suddenly dissolves into fractal patterns, which quickly reorganize into a door.")
    end,
    entries = {
        {
            item = "hacksaw",
            key = "safehouse_utility_space_deposited_hacksaw",
            label = function()
                return ccb.services.translate("Insert a <color_white>hacksaw</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard hacksaw will fit.")
            end,
        },
        {
            item = "screwdriver",
            key = "safehouse_utility_space_deposited_screwdriver",
            label = function()
                return ccb.services.translate("Insert a <color_white>screwdriver</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard screwdriver will fit.")
            end,
        },
        {
            item = "nl_grav_aware_jig",
            key = "safehouse_utility_space_deposited_gaj",
            label = function()
                return ccb.services.translate("Insert a <color_yellow>gravimetrically aware jig</color>?")
            end,
            description = function()
                return ccb.services.translate("You don't know what a gravimetrically aware jig is, but maybe you can find one in the labyrinthine structures?")
            end,
        },
        {
            item = "wrench",
            key = "safehouse_utility_space_deposited_wrench",
            label = function()
                return ccb.services.translate("Insert an <color_white>adjustable wrench</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard wrench will fit.")
            end,
        },
        {
            item = "extension_cable",
            key = "safehouse_utility_space_deposited_cord",
            label = function()
                return ccb.services.translate("Insert an <color_white>extension cord</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard extension cord will fit.")
            end,
        },
        {
            item = "nuts_bolts",
            key = "safehouse_utility_space_deposited_nutbolt",
            label = function()
                return ccb.services.translate("Insert a <color_white>nut and bolt</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard nut and bolt will fit.")
            end,
        },
        {
            item = "sheet_metal",
            key = "safehouse_utility_space_deposited_sheetmetal",
            label = function()
                return ccb.services.translate("Insert a piece of <color_white>sheet metal</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard piece of sheet metal will fit.")
            end,
        },
    },
})

register_obelisk("examine_t_nl_obelisk_mission_living_space_1", {
    placed = "nl_living_space_1_placed",
    update = "labyrinth_safehouse_living_space_1",
    complete = function()
        return ccb.services.translate(
            "The jaw on the stele snaps shut and suddenly dissolves into fractal patterns, which quickly reorganize themselves into an opening.")
    end,
    entries = {
        {
            item = "hammer",
            key = "safehouse_living_space_1_deposited_hammer",
            label = function()
                return ccb.services.translate("Insert a <color_white>hammer</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard hammer will fit.")
            end,
        },
        {
            item = "hinge",
            key = "safehouse_living_space_1_deposited_hinge",
            label = function()
                return ccb.services.translate("Insert a <color_white>hinge</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard hinge will fit.")
            end,
        },
        {
            item = "lc_wire",
            key = "safehouse_living_space_1_deposited_wire",
            label = function()
                return ccb.services.translate("Insert a <color_white>steel wire</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a length of thin, relatively stiff steel wire will fit.")
            end,
        },
        {
            item = "nl_laser_mass_indexer",
            key = "safehouse_living_space_1_deposited_lami",
            label = function()
                return ccb.services.translate("Insert an <color_yellow>laser-assisted mass indexer</color>?")
            end,
            description = function()
                return ccb.services.translate("You don't know what a laser-assisted mass indexer is, but maybe you can find one in the labyrinthine structures?")
            end,
        },
        {
            item = "tape_measure",
            key = "safehouse_living_space_1_deposited_tape_measure",
            label = function()
                return ccb.services.translate("Insert a <color_white>tape measure</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard tape measure will fit.")
            end,
        },
        {
            item = "pipe",
            key = "safehouse_living_space_1_deposited_pipe",
            label = function()
                return ccb.services.translate("Insert an <color_white>pipe</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard pipe will fit.")
            end,
        },
    },
})

register_obelisk("examine_t_nl_obelisk_mission_autodoc", {
    prior_room = "nl_utility_space_placed",
    alternate_update = "labyrinth_safehouse_autodoc_if_utility_first",
    placed = "nl_autodoc_placed",
    update = "labyrinth_safehouse_autodoc",
    complete = function()
        return ccb.services.translate(
            "The jaw on the stele snaps shut and suddenly dissolves into fractal patterns, which quickly reorganize themselves into an opening.")
    end,
    entries = {
        {
            item = "bandages",
            key = "safehouse_living_space_1_deposited_bandage",
            label = function()
                return ccb.services.translate("Insert a <color_white>bandage</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a standard bandage will fit, if rolled neatly.")
            end,
        },
        {
            item = "disinfectant",
            key = "safehouse_living_space_1_deposited_disinfectant",
            count = 40,
            label = function()
                return ccb.services.translate("Pour in <color_white>40 units of antiseptic</color>.")
            end,
            description = function()
                return ccb.services.translate("Looks like a it would hold about 40 units of antiseptic.")
            end,
        },
        {
            item = "nl_robo_surg_app",
            key = "safehouse_living_space_1_deposited_nl_robo_surg_app",
            label = function()
                return ccb.services.translate("Insert a <color_yellow>robotic surgical apparatus</color>?")
            end,
            description = function()
                return ccb.services.translate("You don't know what a robotic surgical apparatus looks like, but maybe you can find one in the labyrinthine structures?")
            end,
        },
        {
            item = "nl_surg_int_unit",
            key = "safehouse_living_space_1_deposited_nl_surg_int_unit",
            label = function()
                return ccb.services.translate("Insert a <color_yellow>surgical intelligence unit</color>?")
            end,
            description = function()
                return ccb.services.translate("You don't know what a surgical intelligence unit looks like, but maybe you can find one in the labyrinthine structures?")
            end,
        },
    },
})

local function water_remaining(actor)
    local result = services.variables.get_number(actor, "nl_safehouse_water_stock", { strict = true })
    if not result.ok and result.error.code == "variable_type_mismatch" then
        return nil
    end
    return checked(result).value or 0
end

ccb.runtime.handler("examine_f_nl_water_cooler", function(ctx)
    local actor = ctx.character
    local title = expand(ctx, ccb.services.translate(
        "You see a seven-segment LED display and a circular button.  The display reads: <u_val:nl_safehouse_water_stock>"))
    local press = expand(ctx, ccb.services.translate("Press the button."))
    local choice = services.interaction.choose({
        { id = "dispense", label = press, description = press, enabled = (water_remaining(actor) or 0) > 0 },
    }, {
        title = title,
        allow_cancel = true,
        show_descriptions = true,
    })
    if not choice.accepted then
        return
    end
    if (water_remaining(actor) or 0) <= 0 then
        state.message(actor, ccb.services.translate("Nothing happens."))
        return
    end
    state.message(actor, ccb.services.translate("Kathunk.  The water dispenser dispenses a water bottle."))
    checked(services.inventory.receive_item(actor, id("item", "water_clean"), 6, {
        container = id("item", "nl_water_bottle"),
    }))
    -- Read after delivery so any native item callback changes are retained.
    local remaining = water_remaining(actor)
    if remaining ~= nil then
        checked(services.variables.set(actor, "nl_safehouse_water_stock", remaining - 1, { include_before = false }))
    end
end)

local function leave_chasm(actor)
    local visited_safehouse =
        checked(services.variables.get_string(actor, "traveled_to_labyrinth_safehouse")).value == "yes"
    local dimension, success
    if visited_safehouse then
        state.message(actor, ccb.services.translate(
            "As you fall into the chasm, you see a multitude of stars, spots, and other shapes.  It's like you're sinking ever further into quicksand, yet falling through the air at the same time.  Your head throbs with pain as the pressure increases.  You black out.  When you come to, you're back in your home away from home: disoriented but unharmed."),
            "neutral", true)
        dimension = "netherum_labyrinth_safehouse"
        success = ccb.services.translate("Your surroundings warp and fold into a familiar place.")
    else
        state.message(actor, ccb.services.translate(
            "As you fall into the chasm, you see a multitude of stars, spots, and other shapes.  It's like you're sinking ever further into quicksand, yet falling through the air at the same time.  Your head throbs with pain as the pressure increases.  You black out.  When you come to, you're back in a place that seems familiar: disoriented but unharmed."),
            "neutral", true)
        dimension = "default"
        success = ccb.services.translate("Your surroundings warp and fold into the recesses of the world you know.")
    end
    local result = checked(services.relocation.travel_to_dimension(dimension, {
        npc_travel_radius = 0,
        npc_travel_filter = "none",
        item_travel_radius = -1,
    }))
    state.message(actor, result.accepted and success
        or ccb.services.translate("You feel a prickle at the edge of your senses."))
    if visited_safehouse then
        local destination = checked(
            services.variables.get_tripoint(actor, "player_location_safehouse_before_labyrinth")).value
            or services.coords.tripoint_abs_ms(0, 0, 0)
        checked(services.relocation.teleport_character(actor, destination, { force = true }))
    end
    services.gameplay.environment.clear_saved_dimension("netherum_labyrinth")
    services.gameplay.environment.clear_saved_dimension("netherum_labyrinth2")
end

ccb.runtime.handler("examine_labyrinth_chasm", function(ctx)
    local title = expand(ctx, ccb.services.translate("There is a ledge here.  What do you want to do?"))
    local choice = services.interaction.choose({
        {
            id = "peek",
            label = expand(ctx, ccb.services.translate("Peek down.")),
            description = expand(ctx, ccb.services.translate("What do you see down there?")),
        },
        {
            id = "fall",
            label = expand(ctx, ccb.services.translate("Fall down.")),
            description = expand(ctx, ccb.services.translate("Jump into the darkness.")),
        },
    }, {
        title = title,
        allow_cancel = true,
        show_descriptions = true,
    })
    if choice.id == "peek" then
        state.message(ctx.character, ccb.services.translate(
            "At a glance this just looks like darkness.  Then, gazing deeper, you think it might be full of stars.  Still deeper, perhaps those stars are eyes?"))
    elseif choice.id == "fall" then
        leave_chasm(ctx.character)
    end
end)

ccb.runtime.handler("trigger_labyrinth_chasm", function(ctx)
    if not ctx.creature then
        return true
    end
    leave_chasm(ctx.creature)
    return false
end)

local function can_leave(actor)
    return not checked(services.inventory.has_worn_flag(actor, id("json_flag", "DIMENSIONAL_ANCHOR")))
        and not checked(services.characters.snapshot(actor, 0)).movement.driving
end

local function string_value(actor, key)
    return checked(services.variables.get_string(actor, key)).value or ""
end

local function set_var(actor, key, value)
    checked(services.variables.set(actor, key, value, { include_before = false }))
end

local function finish_mission(actor, name)
    local offset = 0
    repeat
        local page = services.missions.active(actor, { offset = offset, limit = 256 })
        for _, mission in ipairs(page.items) do
            if mission.id.value == name then
                checked(services.missions.finish(actor, mission.token))
                return
            end
        end
        offset = offset + page.returned
    until not page.has_more
end

local function confirm_obelisk_touch(ctx, title, description)
    local choice = services.interaction.choose({
        {
            id = "touch",
            label = expand(ctx, ccb.services.translate("Place your hand upon the obelisk.")),
            description = expand(ctx, description),
        },
    }, {
        title = expand(ctx, title),
        allow_cancel = true,
        show_descriptions = true,
    })
    return choice.id == "touch"
end

local function travel_to_safehouse()
    return checked(services.relocation.travel_to_dimension("netherum_labyrinth_safehouse", {
        npc_travel_radius = 0,
        npc_travel_filter = "none",
        item_travel_radius = -1,
    }))
end

local function teleport_to_safehouse_portal(actor)
    if checked(services.variables.get(actor, "safehouse_floor_portal_enclosure")).value == nil then
        local origin = state.position(actor)
        local om_target = services.overmap.find_target(origin:project_to("omt"), "labyrinth_safehouse", {
            special = id("overmap_special", "labyrinth_safehouse"),
            create_special = true,
        })
        local location = services.world.find_location(om_target:project_to("ms"), {
            kind = "furniture",
            id = id("furniture", "f_exodii_floor_portal_enclosure"),
        }, {
            target_max_radius = 250,
            distance_origin = origin,
        })
        if location.position then
            set_var(actor, "safehouse_floor_portal_enclosure", location.position)
        end
    end
    local destination = checked(services.variables.get_tripoint(actor, "safehouse_floor_portal_enclosure")).value
        or services.coords.tripoint_abs_ms(0, 0, 0)
    checked(services.relocation.teleport_character(actor, destination))
end

ccb.runtime.handler("examine_t_nl_obelisk_scarlet", function(ctx)
    local actor = ctx.character
    if not confirm_obelisk_touch(ctx,
        ccb.services.translate(
            "As you approach the massive obelisk,\nits surface starts to warp,\nlike sand in the wind.\nA depression quickly forms.\nIn the shape of your hand."),
        ccb.services.translate("It looks like a perfect fit for you.")) then
        return
    end
    if not can_leave(actor) then
        state.message(actor, ccb.services.translate("You feel a prickle at the edge of your senses."))
        return
    end
    local visited = string_value(actor, "traveled_to_labyrinth_safehouse") == "yes"
    local trapped = string_value(actor, "scenario_trapped_in_labyrinth") == "yes"
    local arrival_text
    if visited then
        arrival_text = "Zwoink."
    elseif trapped then
        arrival_text = "As you place your hand in the depression the scarlet light fades in a dizzying pinch of your senses.  Then the world itself folds inward - pop - your senses go black, as if you've entered a deep sleep.\n\nYou awake to three soft chimes and a stiff neck.  You find yourself standing in a metal ring.  The air around you is clean, and where the obelisk once stood is now a tall, bulbous computer screen, slightly too tall to comfortably look at without craning your neck.  It's certainly more home-like than the place you just came from, but alien in its own right.  Text starts to populate the screen."
    else
        arrival_text = "As you place your hand in the depression the scarlet light fades in a dizzying pinch of your senses.  Then the world itself folds inward - pop.\n\nSuddenly, you hear three soft chimes.  You find yourself standing in a metal ring.  The air around you is clean, and where the obelisk once stood is now a tall, bulbous computer screen, slightly too tall to comfortably look at without craning your neck.  It's certainly more home-like than the place you just came from, but alien in its own right.  Text starts to populate the screen."
    end
    state.message(actor, ccb.services.translate(arrival_text), "neutral", true)
    set_var(actor, "player_location_scarlet_before_labyrinth", state.position(actor))
    set_var(actor, "traveled_scarlet_to_labyrinth", "yes")
    travel_to_safehouse()
    teleport_to_safehouse_portal(actor)
    if not visited then
        if trapped then
            checked(services.bionics.grant(actor, id("bionic", "bio_nl_collar")))
            checked(services.mutations.replace(actor, id("mutation", "NL_CBM_Interface")))
            finish_mission(actor, "MISSION_FIND_LABYRINTH_SPIRE")
            checked(services.characters.open_topic(actor,
                "COMP_labyrinthine_safehouse_computer_meeting_scenario_trapped_in_labyrinth"))
        else
            checked(services.characters.open_topic(actor, "COMP_labyrinthine_safehouse_computer_meeting"))
        end
    end
end)

local green_obelisk_title =
    "As you approach the massive obelisk,\nits surface starts to warp,\nand a sound slips free:\nlike a whisper, beckoning.\nA depression quickly forms.\nIn the shape of your hand."
local green_obelisk_description =
    "How strange.  It looks like a perfect fit for you.  You have a bad feeling in the pit of your stomach."

ccb.runtime.handler("examine_t_nl_obelisk_earth", function(ctx)
    local actor = ctx.character
    if not confirm_obelisk_touch(ctx, ccb.services.translate(green_obelisk_title),
        ccb.services.translate(green_obelisk_description)) then
        return
    end
    if not can_leave(actor) then
        state.message(actor, ccb.services.translate("You feel a prickle at the edge of your senses."))
        return
    end
    checked(services.world.transform_radius(state.position(actor), 20,
        id("terrain_furniture_transform", "transform_LS_teleport_default_dimension_spire_to_safehouse")))
    local visited = string_value(actor, "traveled_to_labyrinth_safehouse") == "yes"
    if not visited then
        state.message(actor, ccb.services.translate(
            "As you place your hand in the depression the world you know fades in a dizzying pinch of your senses.  Then everything folds inward - pop - your senses go black.\n\nYou hear three soft chimes.  You find yourself standing in a metal ring.  Where the obelisk once stood is now a tall, bulbous computer screen, slightly too tall to comfortably look at without craning your neck.  Text starts to populate the screen."),
            "neutral", true)
    else
        state.message(actor, ccb.services.translate("Zwoink."), "neutral", true)
    end
    set_var(actor, "player_location_home_before_labyrinth", state.position(actor))
    set_var(actor, "traveled_home_to_labyrinth", "yes")
    travel_to_safehouse()
    teleport_to_safehouse_portal(actor)
    if not visited then
        checked(services.characters.open_topic(actor, "COMP_labyrinthine_safehouse_computer_meeting"))
    end
end)

ccb.runtime.handler("examine_t_nl2_obelisk_altaros", function(ctx)
    local actor = ctx.character
    if not confirm_obelisk_touch(ctx, ccb.services.translate(green_obelisk_title),
        ccb.services.translate(green_obelisk_description)) then
        return
    end
    if not can_leave(actor) then
        state.message(actor, ccb.services.translate("You feel a prickle at the edge of your senses."))
        return
    end
    if string_value(actor, "traveled_safehouse_to_labyrinth") == "yes" then
        state.message(actor, ccb.services.translate("Zworunk."), "neutral", true)
        local result = travel_to_safehouse()
        state.message(actor, result.accepted
            and ccb.services.translate("Your surroundings warp and fold into a familiar place.")
            or ccb.services.translate("You feel a prickle at the edge of your senses."))
        local destination = checked(services.variables.get_tripoint(actor,
            "player_location_safehouse_before_labyrinth")).value
            or services.coords.tripoint_abs_ms(0, 0, 0)
        checked(services.relocation.teleport_character(actor, destination, { force = true }))
        services.gameplay.environment.clear_saved_dimension("netherum_labyrinth")
        services.gameplay.environment.clear_saved_dimension("netherum_labyrinth2")
    else
        travel_to_safehouse()
        teleport_to_safehouse_portal(actor)
        state.message(actor, ccb.services.translate(
            "The maze around you folds in on itself - zwoink.  Then, you hear three soft chimes, and find yourself standing in a metal ring.  A tall, bulbous computer screen looms before you, slightly too tall to comfortably look at without craning your neck.  Text starts to populate the screen."),
            "neutral", true)
        checked(services.characters.open_topic(actor, "COMP_labyrinthine_safehouse_computer_meeting"))
    end
end)
