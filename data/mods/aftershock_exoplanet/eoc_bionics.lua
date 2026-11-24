local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

local EOC = E.run
local COND = E.cond
EOC["bio_shield_weak_activate"] = function(ctx)
    H.run_eoc("EOC_bio_start_shield", ctx, { ["shield_max_hp"] = 120, ["shield_regen"] = 1, ["shield_regen_rate"] = 2, ["success_message"] = "The shield activates.", ["failure_message"] = "Your implant vibrates uncomfortably as the shield fails to activate." }, nil, nil)
    return true
end
ccb.runtime.handler("eoc:" .. "bio_shield_weak_activate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["bio_shield_weak_activate"](H.ctx_new(u, npc, vars))
end)
EOC["bio_shield_medium_activate"] = function(ctx)
    H.run_eoc("EOC_bio_start_shield", ctx, { ["shield_max_hp"] = 550, ["shield_regen"] = 2, ["shield_regen_rate"] = 1, ["success_message"] = "The shield activates.", ["failure_message"] = "Your implant vibrates uncomfortably as the shield fails to activate." }, nil, nil)
    return true
end
ccb.runtime.handler("eoc:" .. "bio_shield_medium_activate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["bio_shield_medium_activate"](H.ctx_new(u, npc, vars))
end)
EOC["bio_shield_heavy_activate"] = function(ctx)
    H.run_eoc("EOC_bio_start_shield", ctx, { ["shield_max_hp"] = 10000, ["shield_regen"] = 20, ["shield_regen_rate"] = 1, ["success_message"] = "All surrounding noise is muted as the barrier coalesces.", ["failure_message"] = "Your implant vibrates uncomfortably as the shield fails to activate." }, nil, nil)
    return true
end
ccb.runtime.handler("eoc:" .. "bio_shield_heavy_activate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["bio_shield_heavy_activate"](H.ctx_new(u, npc, vars))
end)

ccb.content.add(ccb.content.Bionic {
    id = "afs_bio_chemical_enhancement_rig",
    name = "Chemical Enhancement Rig and computer",
    description = "An implanted AI module and medication dispenser calculates the optimal chemical mix to keep you on your toes and ready for combat.  This bionic must be active to function and while it functions your body is at a heightened performance but if it turns off it will take you several days to get back to normal.  There are a significant number of baseline bonuses granted by this setup but people around will notice your junkie behavior.  This bionic must be active to function.",
    activation_energy_millijoules = 100000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 60,
    occupied_bodyparts = {
        { bodypart = "head", slots = 5 },
        { bodypart = "torso", slots = 10 },
        { bodypart = "arm_l", slots = 3 },
        { bodypart = "arm_r", slots = 3 },
        { bodypart = "leg_l", slots = 3 },
        { bodypart = "leg_r", slots = 3 },
    },
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "heightened_performance" },
    included_bionics = { "afs_speed_injection", "afs_healing_injection", "afs_strength_injection" },
    activated_on_install = true,
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_speed_injection",
    name = "Speed Injection System",
    description = "The chemical injection system and microcomputer that when activated greatly enhances your reaction times and overall speed.  Upon deactivation, the user may experience dizziness, heart palpitations and ravenous appetites.",
    activation_energy_millijoules = 100000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 60,
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_afs_speed_injection_0" },
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_healing_injection",
    name = "Pain Suppression Injection System",
    description = "The chemical injection system and microcomputer that when activated gives a burst of chemicals that allows your blood to work a little harder at stabilizing the body and then flushes your system with a powerful anesthetic that allows you to continue operating at high capacity.  Upon deactivation, the user may experience extreme lethargy, sudden loss of consciousness, among other symptoms that may prove potentially fatal if not in a safe location.",
    activation_energy_millijoules = 100000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 60,
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_afs_healing_injection_0" },
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_strength_injection",
    name = "Strength Injection System",
    description = "The chemical injection system and microcomputer that, when activated, provides a steroid burst, significantly enhancing strength and stamina while accelerating metabolism.  Upon deactivation, the user may experience sleepiness and feel worn down.",
    activation_energy_millijoules = 100000,
    over_time_energy_millijoules = 20000,
    charge_time_turns = 60,
    flags = { "BIONIC_TOGGLED" },
    enchantments = { "BIONIC_ENCH_afs_strength_injection_0" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_shield_weak",
    name = "HawkingCorps Mark I Shield",
    description = "Imagine a computer inside your body playing pong against the universe.  The paddles are made of -color glass condensate- and any and all of their specific functions are the intellectual property of the Hawking Corporation and/or its local subsidiaries.\n-From the owners manual of HawkingCorps Mark I Shield.\n\nActivating the shield will create an energy shield capable of negating a modest amount of damage from weak or improvised weapons.",
    activation_energy_millijoules = 10000000,
    over_time_energy_millijoules = 1000000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 8 },
    },
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "BIO_SHIELD_ACTIVE" },
    available_upgrades = { "bio_shield_medium", "bio_shield_heavy" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_shield_medium",
    name = "HawkingCorps Mark V Shield",
    description = "Powerful and covert, the Mark V Shield is a military-grade shielding system developed for use within UICA's special service branches.  Although much more effective than anything that could be conceived with current technology, it remains a pale imitation of the Hyperspace Age systems it was reverse-engineered from.\n\nActivating the shield will create an energy barrier capable of withstanding a modest amount of melee and ranged damage.",
    activation_energy_millijoules = 10000000,
    over_time_energy_millijoules = 2000000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 12 },
    },
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "BIO_SHIELD_ACTIVE" },
    upgraded_bionic = "bio_shield_weak",
    available_upgrades = { "bio_shield_heavy" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_shield_heavy",
    name = "Kinetic Annulment System",
    description = "A powerful shielding system salvaged from a pre-Discontinuity robotic warframe, crudely adapted for compatibility with biological hosts.  Powerful enough to withstand prolonged assault from anti-vehicle weaponry.",
    activation_energy_millijoules = 1500000000,
    over_time_energy_millijoules = 100000000,
    charge_time_turns = 1,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 14 },
    },
    flags = { "BIONIC_TOGGLED" },
    active_flags = { "BIO_SHIELD_ACTIVE" },
    enchantments = { "BIONIC_ENCH_bio_shield_heavy_0" },
    upgraded_bionic = "bio_shield_medium",
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_bio_blade_fire",
    name = "Bioweapon Thermal Conduits",
    description = "An improved ulnar sheath equipped with thermal inductors allows for the super heating of all types of implanted bladed weaponry.  While this bionic is active, any deployed bionic blades will deal additional fire damage to targets.",
    activation_energy_millijoules = 1500000,
    over_time_energy_millijoules = 250000,
    occupied_bodyparts = {
        { bodypart = "arm_r", slots = 7 },
    },
    encumbrance = {
        { bodypart = "arm_r", amount = 2 },
    },
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    enchantments = { "BIONIC_ENCH_afs_bio_blade_fire_0" },
})
ccb.content.add(ccb.content.Bionic {
    id = "afs_bio_blade_electric",
    name = "Bioweapon Superconductive Channels",
    description = "Paired capacitor banks maintain implanted bladed weaponry under constant electrical charge.  While this bionic is active, any deployed bionic blades will deal additional electric damage with a chance of the damage arcing to other nearby targets.",
    activation_energy_millijoules = 1500000,
    over_time_energy_millijoules = 1000000,
    occupied_bodyparts = {
        { bodypart = "arm_r", slots = 7 },
    },
    encumbrance = {
        { bodypart = "arm_r", amount = 2 },
    },
    flags = { "BIONIC_TOGGLED", "BIONIC_NPC_USABLE" },
    enchantments = { "BIONIC_ENCH_afs_bio_blade_electric_0" },
})
ccb.runtime.handler("w16b_aftershock_exoplanet_on_bionic_activated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "afs_bio_chemical_enhancement_rig" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chembaseline", ctx)
    elseif bid == "afs_speed_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chemspeed", ctx)
    elseif bid == "afs_healing_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chemhealing", ctx)
    elseif bid == "afs_strength_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chemstrength", ctx)
    elseif bid == "bio_shield_weak" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_shield_weak_activate", ctx)
    elseif bid == "bio_shield_medium" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_shield_medium_activate", ctx)
    elseif bid == "bio_shield_heavy" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("bio_shield_heavy_activate", ctx)
    elseif bid == "afs_bio_blade_fire" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("eoc_bio_superheater_on", ctx)
    elseif bid == "afs_bio_blade_electric" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("eoc_bio_blade_electric_on", ctx)
    end
end)
ccb.runtime.hook("on_bionic_activated", "w16b_aftershock_exoplanet_on_bionic_activated")
ccb.runtime.handler("w16b_aftershock_exoplanet_on_bionic_deactivated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "afs_bio_chemical_enhancement_rig" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_hangover_baseline", ctx)
    elseif bid == "afs_speed_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_hangover_speed", ctx)
    elseif bid == "afs_healing_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_hangover_healing", ctx)
    elseif bid == "afs_strength_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_hangover_strength", ctx)
    elseif bid == "bio_shield_weak" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_stop_shield", ctx)
    elseif bid == "bio_shield_medium" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_stop_shield", ctx)
    elseif bid == "bio_shield_heavy" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_stop_shield", ctx)
    elseif bid == "afs_bio_blade_fire" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("eoc_bio_superheater_off", ctx)
    elseif bid == "afs_bio_blade_electric" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("eoc_bio_blade_electric_off", ctx)
    end
end)
ccb.runtime.hook("on_bionic_deactivated", "w16b_aftershock_exoplanet_on_bionic_deactivated")
ccb.runtime.handler("w16b_aftershock_exoplanet_on_bionic_processed", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "afs_healing_injection" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("afs_eoc_chemhealing_pkill", ctx)
    elseif bid == "bio_shield_weak" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_update_ui", ctx)
    elseif bid == "bio_shield_medium" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_update_ui", ctx)
    elseif bid == "bio_shield_heavy" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_update_ui", ctx)
    end
end)
ccb.runtime.hook("on_bionic_processed", "w16b_aftershock_exoplanet_on_bionic_processed")
