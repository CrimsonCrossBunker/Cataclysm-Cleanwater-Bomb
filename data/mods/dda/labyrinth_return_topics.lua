local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local id = services.types.id

local function yes(context, key)
    return context:speaker_variable_string(key) == "yes"
end

local function all_upgrades()
    for _, key in ipairs {
        "nl_boiler_placed", "nl_utility_space_obelisk_placed", "nl_water_cooler_placed",
        "nl_living_space_1_obelisk_placed", "nl_autodoc_obelisk_placed",
    } do
        if state.number(key) ~= 1 then return false end
    end
    return true
end

local function has_bionic(context, name)
    local character = context:speaker()
    if not character or (character.subtype ~= "avatar" and character.subtype ~= "npc"
        and character.subtype ~= "character") then return false end
    return state.checked(services.bionics.has(character, id("bionic", name)))
end

local function has_trait(context, name)
    local character = context:speaker()
    if not character or (character.subtype ~= "avatar" and character.subtype ~= "npc"
        and character.subtype ~= "character") then return false end
    return state.checked(services.mutations.has_id_text(character, name))
end

local function recalibration_base(context)
    return yes(context, "scenario_trapped_in_labyrinth") and has_bionic(context, "bio_nl_collar")
        and not yes(context, "traveled_home_to_labyrinth")
end

local function no_longer_stuck(character)
    services.random.native_int(0, 0)
    state.checked(services.variables.set(character, "stuck_in_labyrinth", "no", { include_before = false }))
    services.native_events.emit("u_var_changed", { "stuck_in_labyrinth", "no" })
end

ccb.dialogue.register_topic {
    id = "COMP_LS_Exit_Controls2_home",
    dynamic_line = "&<color_light_green> @User > skill -EXIT -@User\n<color_light_green>Really exit?  You will not be able to return to the same place.",
    dynamic_line_translation = {},
    responses = {
        {
            text = "Yes.", text_translation = {},
            topic = "TALK_DONE",
            on_action = function(context)
                local character = context:speaker()
                no_longer_stuck(character)
                ccb.runtime.call_character("labyrinth_return_home", character)
            end,
        },
        {
            text = "No.", text_translation = {},
            topic = "TALK_DONE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "COMP_LS_Exit_Controls2_string_dimension",
    dynamic_line = "&<color_light_green> @User > skill -EXIT -@User\n<color_light_green>Really exit?  You will not be able to return to the same place.",
    dynamic_line_translation = {},
    responses = {
        {
            text = "Yes.", text_translation = {},
            topic = "TALK_DONE",
            on_action = function(context)
                local character = context:speaker()
                no_longer_stuck(character)
                ccb.runtime.call_character("labyrinth_return_to_string", character)
            end,
        },
        {
            text = "No.", text_translation = {},
            topic = "TALK_DONE",
        },
    },
}

ccb.dialogue.register_topic {
    id = "COMP_labyrinthine_safehouse_computer",
    dynamic_line = "& █████╗ ██╗  ████████╗ █████╗ ██████╗      ██████╗ ███████╗\n██╔══██╗██║  ╚══██╔══╝██╔══██╗██╔══██╗    ██╔═══██╗██╔════╝\n███████║██║     ██║   ███████║██████╔╝    ██║   ██║███████╗\n██╔══██║██║     ██║   ██╔══██║██╔══██╗    ██║   ██║╚════██║\n██║  ██║███████╗██║   ██║  ██║██║  ██║    ╚██████╔╝███████║\n╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝     ╚═════╝ ╚══════╝\n\nᵖˡᵉᵃˢᵉ select a program\n\n<color_light_green> @User > _</color>",
    dynamic_line_translation = {},
    responses = {
        {
            text = "<color_light_green>Activate entry protocol", text_translation = {},
            topic = "COMP_labyrinthine_safehouse_computer_blood_tax",
            condition = function(context) return not yes(context, "stuck_in_labyrinth") end,
        },
        {
            text = "<color_light_green>Activate entry protocol", text_translation = {},
            topic = "COMP_labyrinthine_safehouse_computer_blood_tax_reenter",
            condition = function(context) return yes(context, "stuck_in_labyrinth") end,
        },
        {
            text = "<color_light_green>Check for updates", text_translation = {},
            topic = "COMP_labyrinthine_safehouse_missions_list",
            condition = function(context) return not all_upgrades() end,
        },
        {
            text = "<color_light_green>Check for updates", text_translation = {},
            topic = "COMP_labyrinthine_safehouse_missions_none",
            condition = function(context) return all_upgrades() end,
        },
        {
            text = "<color_light_green>Activate dimensional recalibration protocol", text_translation = {},
            topic = "COMP_labyrinthine_safehouse_earth_jaunt",
            condition = function(context) return recalibration_base(context) and not yes(context, "stuck_in_labyrinth") end,
        },
        {
            text = "<color_yellow>ERROR002: Cannot dimensionally recalibrate", text_translation = {},
            topic = "COMP_labyrinthine_safehouse_computer_stuck_in_labyrinth_help_2",
            condition = function(context) return recalibration_base(context) and yes(context, "stuck_in_labyrinth") end,
        },
        {
            text = "<color_red>Activate exit protocol: Earth gate", text_translation = {},
            topic = "TALK_DONE",
            condition = function(context) return yes(context, "traveled_home_to_labyrinth") and not yes(context, "stuck_in_labyrinth") end,
            on_action = function(context)
                local character = context:speaker()
                ccb.runtime.call_character("labyrinth_return_home", character)
            end,
        },
        {
            text = "<color_light_green>ERROR001: No contact with Earth gate", text_translation = {},
            topic = "COMP_labyrinthine_safehouse_computer_stuck_in_labyrinth_help",
            condition = function(context) return yes(context, "traveled_home_to_labyrinth") and yes(context, "stuck_in_labyrinth") end,
        },
        {
            text = "<color_red>Enter passcode: KÁ", text_translation = {},
            topic = "COMP_labyrinthine_safehouse_string_dimension_tunnel",
            condition = function(context) return not yes(context, "traveled_string_dimension_to_labyrinth") and has_trait(context, "LS_Passcode_string_dimension") end,
        },
        {
            text = "<color_red>Activate exit protocol: KÁ gate", text_translation = {},
            topic = "TALK_DONE",
            condition = function(context) return yes(context, "traveled_string_dimension_to_labyrinth") and not yes(context, "stuck_in_labyrinth") end,
            on_action = function(context)
                local character = context:speaker()
                ccb.runtime.call_character("labyrinth_return_to_string", character)
            end,
        },
        {
            text = "<color_light_green>ERROR001: No contact with KÁ gate", text_translation = {},
            topic = "COMP_labyrinthine_safehouse_computer_stuck_in_labyrinth_help",
            condition = function(context) return yes(context, "traveled_string_dimension_to_labyrinth") and yes(context, "stuck_in_labyrinth") end,
        },
        {
            text = "<color_red>Activate exit protocol: Scarlet Sea", text_translation = {},
            topic = "TALK_DONE",
            condition = function(context) return yes(context, "traveled_scarlet_to_labyrinth") end,
            on_action = function(context)
                local character = context:speaker()
                ccb.runtime.call_character("labyrinth_return_to_scarlet", character)
            end,
        },
        {
            text = "<color_yellow>Log off", text_translation = {},
            topic = "TALK_DONE",
        },
    },
}
