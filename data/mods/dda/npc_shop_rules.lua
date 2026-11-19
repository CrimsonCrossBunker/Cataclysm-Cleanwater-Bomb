local ccb = require("ccb")
local state = require("portal_storm_state")
local variables = ccb.services.variables

local function has_flag(character, key)
    return state.checked(variables.get_string(character, key)).value == "yes"
end

local function number(character, key)
    return state.checked(variables.get_number(character, key)).value or 0
end

local function intercom_upgraded(context)
    return has_flag(context.customer, "dialogue_intercom_completed_robofac_intercom_3")
end

local function ivas_completed(context)
    return has_flag(context.customer, "dialogue_intercom_completed_robofac_intercom_ivas")
end

local function gun_researched(context)
    return has_flag(context.customer, "dialogue_hub_rnd_u_has_researched_gun")
end

ccb.runtime.handler("shopkeeper_stock_override_enabled", function(context)
    return number(context.shopkeeper, "NEVER") == 1
end)

ccb.runtime.handler("godco_representative_unpaid", function(context)
    return not has_flag(context.shopkeeper, "general_meeting_u_paidoff")
end)

ccb.runtime.handler("ancilla_bionics_unlocked", intercom_upgraded)
ccb.runtime.handler("ancilla_bionics_lenses_unlocked", function(context)
    return intercom_upgraded(context) and ivas_completed(context)
end)

ccb.runtime.handler("hub_armor_stock_unlocked", function(context)
    return number(context.customer, "hub01_good_candidate") == 1
        or number(context.customer, "hub01_completed_missions") >= 2
end)

ccb.runtime.handler("hub_military_stock_unlocked", function(context)
    return state.number("hub01_uhmwpe_researched") == 1
        and not has_flag(context.customer, "dialogue_hub_rnd_u_can_buy_armor")
end)

ccb.runtime.handler("hub_portal_robots_unlocked", function(context)
    return has_flag(context.customer, "dialogue_intercom_completed_robofac_intercom_portal_sm_1")
end)

ccb.runtime.handler("hub_gun_stock_unlocked", gun_researched)
ccb.runtime.handler("hub_exodii_gun_stock_unlocked", function(context)
    return gun_researched(context) and state.number("hub01_hwp_exotic_researched") == 1
end)

ccb.runtime.handler("hub_hm12_stock_unlocked", function(context)
    return has_flag(context.customer, "dialogue_intercom_completed_robofac_intercom_robot_sm_1")
end)

ccb.runtime.handler("hub_envirosuit_stock_unlocked", function(context)
    return state.checked(variables.get_global_string("hub01_intercom_bought_protective_gear")).value == "yes"
        or has_flag(context.shopkeeper, "dialogue_intercom_npc_bought_protective_gear")
        or intercom_upgraded(context)
end)

ccb.runtime.handler("hub_autodoc_exoskeletons_unlocked", function(context)
    return state.number("ancilla_autodoc_placed") == 1 and intercom_upgraded(context)
end)

ccb.runtime.handler("hub_autodoc_lenses_unlocked", function(context)
    return state.number("ancilla_autodoc_placed") == 1 and ivas_completed(context)
end)

ccb.runtime.handler("hub_mvas_stock_unlocked", ivas_completed)
ccb.runtime.handler("scrapper_specialty_metals_unlocked", function(context)
    return has_flag(context.shopkeeper, "dialogue_trade_specific_metal_tradeable")
end)
