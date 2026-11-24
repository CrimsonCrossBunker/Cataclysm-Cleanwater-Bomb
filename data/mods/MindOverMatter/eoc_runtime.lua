local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }
require("ccb_runtime_helpers").attach(H, E)

H._jm_concentration_calculations = function(ctx)
    return ((((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) / 4) + H.var_num(H.u(ctx), "bonus_concentration_powers")) + H._jm_concentration_trait_bonuses(ctx))
end
H._jm_concentration_nether_attunement_influences = function(ctx)
    return ((((((H._jm_concentration_calculations(ctx) > 1)) and (H._jm_concentration_calculations(ctx)) or (1)) * ((H.truthy((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value) == true) and 1 or 0))) and (0.9) or (1))) + ((H.truthy((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value) == true) and 1 or 0))) and (0.9) or (1))) + ((H.truthy((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value) == true) and 1 or 0))) and (0.8) or (1)))
end
H._jm_concentration_trait_bonuses = function(ctx)
    return ((((((((((((((((((((((((((((((((H.char_has_trait(H.u(ctx), "CONCENTRATION_GOOD") + ((H.truthy(H.char_has_trait(H.u(ctx), "CONCENTRATION_BAD"))) and ((-1)) or (0))) + H.char_has_trait(H.u(ctx), "INT_ALPHA")) + ((H.truthy(H.char_has_trait(H.u(ctx), "NOMAD2"))) and ((-1)) or (0))) + ((H.truthy(H.char_has_trait(H.u(ctx), "NOMAD3"))) and ((-1)) or (0))) + ((H.truthy(H.char_has_trait(H.u(ctx), "PER_SLIME"))) and ((-15)) or (0))) + ((H.truthy(H.char_has_trait(H.u(ctx), "PER_INTERSTICE"))) and (2) or (0))) + ((H.truthy(H.char_has_trait(H.u(ctx), "CONCENTRATION_DEBUG"))) and (50) or (0))) + (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value) == true) and 1 or 0)) + (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value) == true) and 1 or 0)) + ((((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value) == true) and 1 or 0) * 2)) + (((H.creature_effect_intensity(H.u(ctx), "effect_disease_psionic_drain") > 4)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "effect_disease_psionic_drain") > 10)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "effect_psi_studying_power") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "effect_psi_learning_new_power") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "hallu") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "winded") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "nausea") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "nausea") > 3)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "cold") > 1)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "hot") > 1)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "asthma") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "datura") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "dazed") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "psi_dazed") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "psi_dazed_zap") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "downed") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "boomered") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "conjunctivitis") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "teargas") > 0)) and ((-3)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "smoke_eyes") > 0)) and ((-1)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "smoke_lungs") > 0)) and ((-2)) or (0))) + (((H.creature_effect_intensity(H.u(ctx), "effect_whispering_amalgamation_whispers") > 0)) and ((-2)) or (0)))
end
H._jm_nether_attune_difficulty_scaler = function(ctx, _a0)
    return (_a0 * _a0)
end
H._jm_nether_attune_torrential_channeling_influence = function(ctx)
    return (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") * ((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), 0, 50) + H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 100), 0, 100)) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 200) * 2), 0, 100)))
end
H._jm_psionic_power_experience_formula = function(ctx)
    return (((((((((H.char_snap(H.u(ctx)) or {}).needs or {}).effective_focus or 0) / 100) * 80) * (((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20)) * math.min((0.5 + (H.char_skill(H.u(ctx), "metaphysics") / 20)), 1)) * H.var_num(H.u(ctx), "nether_attunement_power_scaling")) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0))
end
H._jm_psionic_power_modifiers = function(ctx)
    return ((H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)) * H.var_num(H.u(ctx), "nether_attunement_power_scaling")) * H._jm_weariness_power_scaling(ctx))
end
H._jm_psionics_kcal_cost = function(ctx, _a0)
    return (((((4 * _a0) * services.random.native_float(0.3, 1.7)) * H.var_num(H.u(ctx), "nether_attunement_power_scaling")) * (((H.creature_effect_intensity(H.u(ctx), "effect_nether_attunement_extra_kcal") > 0)) and (3) or (1))) + ((1 * H.char_has_trait(H.u(ctx), "SCEN_HEART_OF_FIRE")) * 0.5))
end
H._jm_scaling_factor = function(ctx, _a0)
    return ((_a0 + 10) / 20)
end
H._jm_weariness_power_scaling = function(ctx)
    return ((((((((H.creature_effect_intensity(H.u(ctx), "weary_1") > (-1))) and (0.9) or (1)) * (((H.creature_effect_intensity(H.u(ctx), "weary_2") > (-1))) and (0.75) or (1))) * (((H.creature_effect_intensity(H.u(ctx), "weary_3") > (-1))) and (0.6) or (1))) * (((H.creature_effect_intensity(H.u(ctx), "weary_4") > (-1))) and (0.45) or (1))) * (((H.creature_effect_intensity(H.u(ctx), "weary_5") > (-1))) and (0.25) or (1))) * (((H.creature_effect_intensity(H.u(ctx), "weary_6") > (-1))) and (0.25) or (1)))
end

require("eoc_handlers_01")(E, H)
require("eoc_handlers_02")(E, H)
require("eoc_handlers_03")(E, H)
require("eoc_handlers_04")(E, H)
require("eoc_handlers_05")(E, H)
require("eoc_handlers_06")(E, H)
require("eoc_handlers_07")(E, H)
require("eoc_handlers_08")(E, H)
require("eoc_handlers_09")(E, H)
require("eoc_handlers_10")(E, H)
require("eoc_handlers_11")(E, H)
require("eoc_handlers_12")(E, H)
require("eoc_handlers_13")(E, H)
require("eoc_handlers_14")(E, H)

-- Generic EOC runtime handlers for cross-mod & scheduled calls
for eid, fn in pairs(E.run) do
    ccb.runtime.handler("eoc:" .. eid, function(payload)
        local p = type(payload) == "table" and payload or nil
        local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
        local npc = p and p.npc or nil
        local vars = (p and p.vars) or {}
        fn(H.ctx_new(u, npc, vars))
    end)
end
for eid, cfn in pairs(E.cond) do
    ccb.runtime.handler("eoc_test:" .. eid, function(payload)
        local p = type(payload) == "table" and payload or nil
        local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
        local npc = p and p.npc or nil
        local vars = (p and p.vars) or {}
        return cfn(H.ctx_new(u, npc, vars)) == true
    end)
end

-- EVENT triggers
ccb.runtime.handler("eoc_ev:avatar_enters_omt", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MOM_PREMONITION_QUIET_FARMSTEAD_WARNING", ctx)
    H.run_eoc("EOC_ELECTROKIN_HACKING_INTERFACE_UPDATER", ctx)
end)
ccb.runtime.on("game:avatar_enters_omt", "eoc_ev:avatar_enters_omt")
ccb.runtime.handler("eoc_ev:avatar_moves", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_BIOKIN_HURRICANE_BLOWS_MOVE_CANCEL", ctx)
    H.run_eoc("EOC_PHOTOKIN_INVISIBILITY_CANCEL_WALK", ctx)
    H.run_eoc("EOC_PHOTOKIN_INVISIBILITY_CANCEL_RUN", ctx)
    H.run_eoc("EOC_PERFECTED_MOTION_WATER_RUN", ctx)
    H.run_eoc("EOC_CLAIR_ASTRAL_PROJECTION_MOVEMENT_STAMINA", ctx)
    H.run_eoc("EOC_CLAIR_ASTRAL_PROJECTION_NO_STAMINA_RETURN", ctx)
    H.run_eoc("EOC_TELEPORT_EPHEMERAL_WALK_ADDITIONAL_STAMINA_COST", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:character_casts_spell", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_TELEPORTER_THE_HOUNDS_FOLLOW_GATEWAY", ctx)
end)
ccb.runtime.on("game:character_casts_spell", "eoc_ev:character_casts_spell")
ccb.runtime.handler("eoc_ev:character_finished_activity", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_CLAIR_CRAFTING_REMOVE_BLINDNESS_WHEN_DONE_CRAFTING", ctx)
    H.run_eoc("ECO_TELEPORTER_CANCELLING_ATTUNING_CANCELS_ATTUNE", ctx)
end)
ccb.runtime.on("game:character_finished_activity", "eoc_ev:character_finished_activity")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PSI_GAIN_NETHER_ATTUNEMENT_ACHIEVEMENT", ctx)
    H.run_eoc("EOC_DRINKING_NETHER_WATER_NIGHTMARES_GAIN", ctx)
    H.run_eoc("EOC_MOM_DIMENSIONAL_ANCHOR_WILL_CANCEL_POWERS", ctx)
    H.run_eoc("EOC_PSIONICS_PSI_NEUTRALIZED_ENDS_ALL_POWERS", ctx)
    H.run_eoc("EOC_PSIONICS_CONCENTRATION_EFFECT_GAIN_CHECK", ctx)
    H.run_eoc("EOC_MOM_XE_TORPOR_ENDS_POWERS", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_loses_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MOM_CASCADE_STONE_WEAR_OFF", ctx)
    H.run_eoc("EOC_BIOKIN_LOSES_GUIDED_EVOLUTION_BACKFIRE", ctx)
end)
ccb.runtime.on("game:character_loses_effect", "eoc_ev:character_loses_effect")
ccb.runtime.handler("eoc_ev:character_melee_attacks_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PHOTOKIN_REMOVE_INVISIBILITY_MELEE_CHARACTER", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_character", "eoc_ev:character_melee_attacks_character")
ccb.runtime.handler("eoc_ev:character_melee_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PHOTOKIN_REMOVE_INVISIBILITY_MELEE_MONSTER", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_monster", "eoc_ev:character_melee_attacks_monster")
ccb.runtime.handler("eoc_ev:character_starts_activity", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_CLAIR_CRAFTING_ADD_BLINDNESS_WHEN_CRAFTING", ctx)
    H.run_eoc("EOC_CLAIR_ASTRAL_PROJECTION_CANT_DO_THAT", ctx)
end)
ccb.runtime.on("game:character_starts_activity", "eoc_ev:character_starts_activity")
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PSI_NO_COMBAT_POWER_CHARACTER_DAMAGE_CHECK", ctx)
    H.run_eoc("EOC_PHOTOKIN_DODGE_CANCEL_ATTACKED", ctx)
    H.run_eoc("EOC_PERK_MIND_CRY_TAKE_DAMAGE", ctx)
    H.run_eoc("EOC_TELEPATH_MESMERISM_REMOVAL_CHARACTER", ctx)
    H.run_eoc("EOC_TELEPATH_OBSCURITY_REMOVAL_CHARACTER", ctx)
    H.run_eoc("EOC_VITAKINESIS_RETURN_FROM_DEATH_DAMAGE_TRACKER", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")
ccb.runtime.handler("eoc_ev:character_wakes_up", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_DRINKING_NETHER_WATER_NIGHTMARES_OCCUR", ctx)
    H.run_eoc("EOC_NETHER_ATTENTION_NIGHTMARES", ctx)
end)
ccb.runtime.on("game:character_wakes_up", "eoc_ev:character_wakes_up")
ccb.runtime.handler("eoc_ev:gains_mutation", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_BIOKIN_GUIDED_EVOLUTION_NETHER_ATTUNEMENT_BACKFIRE", ctx)
end)
ccb.runtime.on("game:gains_mutation", "eoc_ev:gains_mutation")
ccb.runtime.handler("eoc_ev:monster_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PSI_NO_COMBAT_POWER_MONSTER_DAMAGE_CHECK", ctx)
    H.run_eoc("EOC_TELEPATH_MESMERISM_REMOVAL_MONSTER", ctx)
    H.run_eoc("EOC_TELEPATH_OBSCURITY_REMOVAL_MONSTER", ctx)
end)
ccb.runtime.on("game:monster_takes_damage", "eoc_ev:monster_takes_damage")
ccb.runtime.handler("eoc_ev:opens_spellbook", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PSIONICS_SET_NETHER_ATTUNEMENT_BOOST", ctx)
    H.run_eoc("EOC_BIOKIN_MATRIX_BOOST", ctx)
    H.run_eoc("EOC_CLAIR_MATRIX_BOOST", ctx)
    H.run_eoc("EOC_ELECTRO_MATRIX_BOOST", ctx)
    H.run_eoc("EOC_PHOTO_MATRIX_BOOST", ctx)
    H.run_eoc("EOC_PYRO_MATRIX_BOOST", ctx)
    H.run_eoc("EOC_TELEKIN_MATRIX_BOOST", ctx)
    H.run_eoc("EOC_TEEP_MATRIX_BOOST", ctx)
    H.run_eoc("EOC_TELEPORT_MATRIX_BOOST", ctx)
    H.run_eoc("EOC_VITAKIN_MATRIX_BOOST", ctx)
    H.run_eoc("EOC_YOU_ARE_NEAR_NETHER_POWER_BOOST", ctx)
    H.run_eoc("EOC_YOU_ARE_IN_NETHER_POWER_BOOST", ctx)
    H.run_eoc("EOC_INTERSTICE_MOM_PHYSIOLOGY_REDUCES_POWER_COST", ctx)
    H.run_eoc("EOC_MOM_CASCADE_STONE_POWER_BOOST", ctx)
    H.run_eoc("EOC_PSI_EXTENDED_CHANNELING", ctx)
    H.run_eoc("EOC_NETHER_ATTUNEMENT_BOOST", ctx)
    H.run_eoc("EOC_PERK_IN_THE_ZONE_ACTUAL_COST_ADJUSTMENT", ctx)
    H.run_eoc("EOC_PERK_PHOENIX_RISING", ctx)
    H.run_eoc("EOC_MOM_SI_PRE_TELEPORT_LOCATION_CHECKING", ctx)
    H.run_eoc("EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_CHECK", ctx)
end)
ccb.runtime.on("game:opens_spellbook", "eoc_ev:opens_spellbook")
ccb.runtime.handler("eoc_ev:phase_move", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MOM_TELEPORTING_PHASING_IN_PORTAL_STORM_DUNGEON", ctx)
end)
ccb.runtime.on("game:phase_move", "eoc_ev:phase_move")
ccb.runtime.handler("eoc_ev:spellcasting_finish", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PSIONICS_METAPHYSICS_SKILL_EXP_SUCCESS", ctx)
    H.run_eoc("EOC_PSIONICS_METAPHYSICS_SKILL_EXP_FAILURE", ctx)
    H.run_eoc("EOC_NETHER_CONDUIT_VALUE_INCREASER", ctx)
    H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT", ctx)
    H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_TORRENTIAL_active", ctx)
    H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES_SETUP", ctx)
    H.run_eoc("EOC_NETHER_ATTUNEMENT_FEEDBACK_CHECK", ctx)
    H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_BIOKINESIS", ctx)
    H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_CLAIRSENTIENCE", ctx)
    H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_ELECTROKINESIS", ctx)
    H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_PHOTOKINESIS", ctx)
    H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_PYROKINESIS", ctx)
    H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_TELEKINESIS", ctx)
    H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_TELEPATHY", ctx)
    H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_TELEPORTATION", ctx)
    H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_VITAKINESIS", ctx)
    H.run_eoc("EOC_CHANNEL_TELEPORTER_POWERS_WHILE_THE_HOUNDS_ARE_WATCHING", ctx)
    H.run_eoc("EOC_MOM_TELEPORTING_IN_PORTAL_STORM_DUNGEON", ctx)
    H.run_eoc("EOC_PSIONICS_NETHER_AREA_CHECK", ctx)
    H.run_eoc("EOC_PSIONICS_BIOKINETIC_CHANNELING_FAILURE", ctx)
    H.run_eoc("EOC_PSIONICS_CLAIRSENTIENT_CHANNELING_FAILURE", ctx)
    H.run_eoc("EOC_PSIONICS_ELECTROKINETIC_CHANNELING_FAILURE", ctx)
    H.run_eoc("EOC_PSIONICS_PHOTOKINETIC_CHANNELING_FAILURE", ctx)
    H.run_eoc("EOC_PSIONICS_PYROKINETIC_CHANNELING_FAILURE", ctx)
    H.run_eoc("EOC_PSIONICS_TELEKINETIC_CHANNELING_FAILURE", ctx)
    H.run_eoc("EOC_PSIONICS_TELEPATH_CHANNELING_FAILURE", ctx)
    H.run_eoc("EOC_PSIONICS_TELEPORTER_CHANNELING_FAILURE", ctx)
    H.run_eoc("EOC_PSIONICS_VITAKINETIC_CHANNELING_FAILURE", ctx)
    H.run_eoc("EOC_PSIONICS_INITIAL_KCAL_COST", ctx)
    H.run_eoc("EOC_PSIONICS_CHANNEL_MAINTENANCE_CHECK", ctx)
    H.run_eoc("EOC_PSIONICS_CHANNEL_COSTS_FOCUS", ctx)
    H.run_eoc("EOC_TELEPORTER_THE_HOUNDS_FOLLOW", ctx)
    H.run_eoc("EOC_MOM_CASCADE_STONE_CONSEQUENCES", ctx)
    H.run_eoc("EOC_MOM_PSYCHIC_VAMPIRE_TELEPATHY", ctx)
    H.run_eoc("EOC_MOM_PSYCHIC_VAMPIRE_VITAKINESIS", ctx)
    H.run_eoc("EOC_PERK_BURNING_BRIGHT_CHANNELING_FINISH_RAISE_ATTUNEMENT", ctx)
    H.run_eoc("EOC_PERK_IN_THE_ZONE_ADD_EFFECT_TRIGGER", ctx)
    H.run_eoc("EOC_PERK_IN_THE_ZONE_REMOVE_EFFECT_TRIGGER", ctx)
    H.run_eoc("EOC_MOM_SI_PRE_TELEPORT_POWER_CHECKING", ctx)
end)
ccb.runtime.on("game:spellcasting_finish", "eoc_ev:spellcasting_finish")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("EOC_VITAKINESIS_RETURN_FROM_DEATH", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:EOC_PSYSHIELD_PARTIAL_EFFECT_GRANTER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PSYSHIELD_PARTIAL_EFFECT_GRANTER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_PSYSHIELD_PARTIAL_EFFECT_GRANTER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PSYSHIELD_PARTIAL_EFFECT_GRANTER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(120), math.floor(480); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PSYSHIELD_PARTIAL_EFFECT_GRANTER", "eoc_int:EOC_PSYSHIELD_PARTIAL_EFFECT_GRANTER")
ccb.runtime.handler("eoc_rec:EOC_RESET_TELEPATHIC_STEALING_TIMER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_RESET_TELEPATHIC_STEALING_TIMER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "TELEPATH") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_RESET_TELEPATHIC_STEALING_TIMER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_RESET_TELEPATHIC_STEALING_TIMER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(72000), math.floor(100800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_RESET_TELEPATHIC_STEALING_TIMER", "eoc_int:EOC_RESET_TELEPATHIC_STEALING_TIMER")
ccb.runtime.handler("eoc_rec:EOC_CHECK_NEAR_NETHER_CRYSTAL_RECURRING", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_CHECK_NEAR_NETHER_CRYSTAL_RECURRING"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_CHECK_NEAR_NETHER_CRYSTAL_RECURRING", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_CHECK_NEAR_NETHER_CRYSTAL_RECURRING", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(7200), math.floor(57600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_CHECK_NEAR_NETHER_CRYSTAL_RECURRING", "eoc_int:EOC_CHECK_NEAR_NETHER_CRYSTAL_RECURRING")
ccb.runtime.handler("eoc_rec:EOC_CONCENTRATION_LIMIT_INSTANT_UPDATER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_CONCENTRATION_LIMIT_INSTANT_UPDATER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC", "PSYCHIC_KNACK" })))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_CONCENTRATION_LIMIT_INSTANT_UPDATER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_CONCENTRATION_LIMIT_INSTANT_UPDATER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_CONCENTRATION_LIMIT_INSTANT_UPDATER", "eoc_int:EOC_CONCENTRATION_LIMIT_INSTANT_UPDATER")
ccb.runtime.handler("eoc_rec:EOC_PSI_NETHER_ATTUNEMENT_PERIODIC_ADJUSTMENT", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PSI_NETHER_ATTUNEMENT_PERIODIC_ADJUSTMENT"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_PSI_NETHER_ATTUNEMENT_PERIODIC_ADJUSTMENT", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PSI_NETHER_ATTUNEMENT_PERIODIC_ADJUSTMENT", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(30), math.floor(30); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PSI_NETHER_ATTUNEMENT_PERIODIC_ADJUSTMENT", "eoc_int:EOC_PSI_NETHER_ATTUNEMENT_PERIODIC_ADJUSTMENT")
ccb.runtime.handler("eoc_rec:EOC_PERK_BURNING_BRIGHT_ATTUNEMENT_MAINTAINED", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_BURNING_BRIGHT_ATTUNEMENT_MAINTAINED"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_burning_bright") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_BURNING_BRIGHT_ATTUNEMENT_MAINTAINED", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_BURNING_BRIGHT_ATTUNEMENT_MAINTAINED", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(5), math.floor(15); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_BURNING_BRIGHT_ATTUNEMENT_MAINTAINED", "eoc_int:EOC_PERK_BURNING_BRIGHT_ATTUNEMENT_MAINTAINED")
ccb.runtime.handler("eoc_rec:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_POSSESSION_HEADACHES_AND_FEVER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_POSSESSION_HEADACHES_AND_FEVER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_psi_range_increaser")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_MOM_XE_NOETIC_RANGE_BOOSTER_POSSESSION_HEADACHES_AND_FEVER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_POSSESSION_HEADACHES_AND_FEVER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(7200), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_POSSESSION_HEADACHES_AND_FEVER", "eoc_int:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_POSSESSION_HEADACHES_AND_FEVER")
ccb.runtime.handler("eoc_rec:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_HEADACHES_AND_FEVER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_HEADACHES_AND_FEVER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_psi_range_increaser")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_HEADACHES_AND_FEVER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_HEADACHES_AND_FEVER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_HEADACHES_AND_FEVER", "eoc_int:EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_HEADACHES_AND_FEVER")
ccb.runtime.handler("eoc_rec:EOC_CLAIR_RAD_SENSE_OUTSIDE_RECURRING", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_CLAIR_RAD_SENSE_OUTSIDE_RECURRING"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "CLAIRSENTIENT") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_CLAIR_RAD_SENSE_OUTSIDE_RECURRING", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_CLAIR_RAD_SENSE_OUTSIDE_RECURRING", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(10)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_CLAIR_RAD_SENSE_OUTSIDE_RECURRING", "eoc_int:EOC_CLAIR_RAD_SENSE_OUTSIDE_RECURRING")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:EOC_NETHER_CONDUIT_VALUE_DECREASER", function(_)
    local dk = "eoc_deact:EOC_NETHER_CONDUIT_VALUE_DECREASER"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_NETHER_CONDUIT_VALUE_DECREASER", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3), math.floor(15); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_NETHER_CONDUIT_VALUE_DECREASER", {})
end)
ccb.runtime.handler("eoc_glob:EOC_VITAKIN_HEALTH_POWER_VS_DISEASE_CHECK", function(_)
    local dk = "eoc_deact:EOC_VITAKIN_HEALTH_POWER_VS_DISEASE_CHECK"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_VITAKIN_HEALTH_POWER_VS_DISEASE_CHECK", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(14400), math.floor(28800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_VITAKIN_HEALTH_POWER_VS_DISEASE_CHECK", {})
end)
ccb.runtime.handler("eoc_glob:EOC_BANDIT_ASSASSIN", function(_)
    local dk = "eoc_deact:EOC_BANDIT_ASSASSIN"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_BANDIT_ASSASSIN", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(5184000), math.floor(8640000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_BANDIT_ASSASSIN", {})
end)
ccb.runtime.handler("eoc_glob:EOC_BANDIT_ASSASSIN_2", function(_)
    local dk = "eoc_deact:EOC_BANDIT_ASSASSIN_2"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_BANDIT_ASSASSIN_2", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(5184000), math.floor(8640000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_BANDIT_ASSASSIN_2", {})
end)
ccb.runtime.handler("eoc_glob:EOC_BANDIT_ASSASSIN_3", function(_)
    local dk = "eoc_deact:EOC_BANDIT_ASSASSIN_3"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_BANDIT_ASSASSIN_3", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(5184000), math.floor(8640000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_BANDIT_ASSASSIN_3", {})
end)
ccb.runtime.handler("eoc_glob:EOC_OLD_GUARD_ASSASSIN", function(_)
    local dk = "eoc_deact:EOC_OLD_GUARD_ASSASSIN"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_OLD_GUARD_ASSASSIN", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(5184000), math.floor(8640000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_OLD_GUARD_ASSASSIN", {})
end)
ccb.runtime.handler("eoc_glob:DEFENSE_MODE_WAVE_CONTROL", function(_)
    local dk = "eoc_deact:DEFENSE_MODE_WAVE_CONTROL"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("DEFENSE_MODE_WAVE_CONTROL", ctx)
    local t = math.max(1, math.floor(86400))
    ccb.tasks.after(t, "eoc_glob:DEFENSE_MODE_WAVE_CONTROL", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:EOC_NETHER_CONDUIT_VALUE_DECREASER") then
        ccb.state.world.set("eoc_glob_started:EOC_NETHER_CONDUIT_VALUE_DECREASER", true)
        ccb.tasks.after(1, "eoc_glob:EOC_NETHER_CONDUIT_VALUE_DECREASER", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_VITAKIN_HEALTH_POWER_VS_DISEASE_CHECK") then
        ccb.state.world.set("eoc_glob_started:EOC_VITAKIN_HEALTH_POWER_VS_DISEASE_CHECK", true)
        ccb.tasks.after(1, "eoc_glob:EOC_VITAKIN_HEALTH_POWER_VS_DISEASE_CHECK", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_BANDIT_ASSASSIN") then
        ccb.state.world.set("eoc_glob_started:EOC_BANDIT_ASSASSIN", true)
        ccb.tasks.after(1, "eoc_glob:EOC_BANDIT_ASSASSIN", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_BANDIT_ASSASSIN_2") then
        ccb.state.world.set("eoc_glob_started:EOC_BANDIT_ASSASSIN_2", true)
        ccb.tasks.after(1, "eoc_glob:EOC_BANDIT_ASSASSIN_2", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_BANDIT_ASSASSIN_3") then
        ccb.state.world.set("eoc_glob_started:EOC_BANDIT_ASSASSIN_3", true)
        ccb.tasks.after(1, "eoc_glob:EOC_BANDIT_ASSASSIN_3", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_OLD_GUARD_ASSASSIN") then
        ccb.state.world.set("eoc_glob_started:EOC_OLD_GUARD_ASSASSIN", true)
        ccb.tasks.after(1, "eoc_glob:EOC_OLD_GUARD_ASSASSIN", {})
    end
    if not ccb.state.world.get("eoc_glob_started:DEFENSE_MODE_WAVE_CONTROL") then
        ccb.state.world.set("eoc_glob_started:DEFENSE_MODE_WAVE_CONTROL", true)
        ccb.tasks.after(1, "eoc_glob:DEFENSE_MODE_WAVE_CONTROL", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
