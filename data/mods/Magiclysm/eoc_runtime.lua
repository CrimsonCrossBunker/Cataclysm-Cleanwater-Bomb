local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }
require("ccb_runtime_helpers").attach(H, E)

H._jm_channeling_proficiency_modifier = function(ctx)
    return (1 + (((H.char_proficiency(H.u(ctx), "prof_magic_channel_beginner", "percent") / 1000) + (H.char_proficiency(H.u(ctx), "prof_magic_channel_apprentice", "percent") / 1000)) + (H.char_proficiency(H.u(ctx), "prof_magic_channel_master", "percent") / 1000)))
end
H._jm_enhancement_proficiency_modifier = function(ctx)
    return (1 + (((H.char_proficiency(H.u(ctx), "prof_magic_enhancement_beginner", "percent") / 1000) + (H.char_proficiency(H.u(ctx), "prof_magic_enhancement_apprentice", "percent") / 1000)) + (H.char_proficiency(H.u(ctx), "prof_magic_enhancement_master", "percent") / 1000)))
end
H._jm_limit_caster_level_boost = function(ctx, _a0, _a1)
    return math.floor(math.min(_a0, (1 + (_a1 / 5))))
end
H._jm_magiclysm_spell_failure_transformation_proficiency_adjustments_damage_npc = function(ctx)
    return (((1 + ((H.truthy((((H.npc(ctx) and services.proficiencies.has_id_text(H.npc(ctx), "prof_magic_transformation_beginner").value) == true) and 1 or 0))) and (0.1) or (0))) + ((H.truthy((((H.npc(ctx) and services.proficiencies.has_id_text(H.npc(ctx), "prof_magic_transformation_apprentice").value) == true) and 1 or 0))) and (0.15) or (0))) + ((H.truthy((((H.npc(ctx) and services.proficiencies.has_id_text(H.npc(ctx), "prof_magic_transformation_master").value) == true) and 1 or 0))) and (0.2) or (0)))
end
H._jm_mc_spell_cost_train_factor = function(ctx, _a0, _a1, _a2)
    return math.max(_a1, math.min(_a2, (_a2 - ((((_a1 * math.max(0, _a0)) / H.char_mana(H.u(ctx), "maximum")) * _a2) / _a1))))
end
H._jm_mc_spell_train_focus_factor = function(ctx, _a0, _a1)
    return (((_a1 > 15)) and ((((math.max(20, _a0) - 50) / 100) + 0.5)) or (1))
end
H._jm_summoning_proficiency_modifier = function(ctx)
    return (1 + (((H.char_proficiency(H.u(ctx), "prof_magic_summon_beginner", "percent") / 1000) + (H.char_proficiency(H.u(ctx), "prof_magic_summon_apprentice", "percent") / 1000)) + (H.char_proficiency(H.u(ctx), "prof_magic_summon_master", "percent") / 1000)))
end
H._jm_transformation_proficiency_modifier = function(ctx)
    return (1 + (((H.char_proficiency(H.u(ctx), "prof_magic_transformation_beginner", "percent") / 1000) + (H.char_proficiency(H.u(ctx), "prof_magic_transformation_apprentice", "percent") / 1000)) + (H.char_proficiency(H.u(ctx), "prof_magic_transformation_master", "percent") / 1000)))
end

require("eoc_handlers_01")(E, H)
require("eoc_handlers_02")(E, H)
require("eoc_handlers_03")(E, H)
require("eoc_handlers_04")(E, H)

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
    H.run_eoc("EOC_CONDITION_CHECK_ELF_IN_THE_WILD_ON_OMT_ENTER", ctx)
end)
ccb.runtime.on("game:avatar_enters_omt", "eoc_ev:avatar_enters_omt")
ccb.runtime.handler("eoc_ev:avatar_moves", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_DRUID_TRAVERSE_THE_WILDS_REMOVER", ctx)
    H.run_eoc("EOC_EARTHSHAPER_DANGERSENSE_CHECKER", ctx)
    H.run_eoc("EOC_EARTHSHAPER_SLEEP_IN_EARTH_REMOVER", ctx)
    H.run_eoc("EOC_CLOAK_OF_ELVENKIND_TURN_ON", ctx)
    H.run_eoc("EOC_CLOAK_OF_ELVENKIND_TURN_OFF", ctx)
    H.run_eoc("EOC_DRUID_WATERWALKING_REMOVERE", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:character_casts_spell", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MC_CASTED_A_SPELL_LEARN_BOOST", ctx)
    H.run_eoc("EOC_MC_CASTED_A_SPELL_LEARN_BOOST_ATTUNED", ctx)
    H.run_eoc("EOC_MC_CASTED_A_SPELL_LEARN_BOOST_BIOTEK", ctx)
    H.run_eoc("EOC_MC_CASTED_A_SPELL_LEARN_BOOST_CLASSLESS", ctx)
end)
ccb.runtime.on("game:character_casts_spell", "eoc_ev:character_casts_spell")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_DISPEL_MAGIC_REMOVE_ITEMS", ctx)
    H.run_eoc("EOC_DISJUNCTION_REMOVE_ITEMS", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_loses_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_ANIMIST_SPIRIT_WALKING_LOSE_APPEARANCE", ctx)
end)
ccb.runtime.on("game:character_loses_effect", "eoc_ev:character_loses_effect")
ccb.runtime.handler("eoc_ev:character_melee_attacks_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MAGICLYSM_MELEE_CHARACTER_REMOVE_INVISIBILITY_EFFECTS", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_character", "eoc_ev:character_melee_attacks_character")
ccb.runtime.handler("eoc_ev:character_melee_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MAGICLYSM_MELEE_MONSTER_REMOVE_INVISIBILITY_EFFECTS", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_monster", "eoc_ev:character_melee_attacks_monster")
ccb.runtime.handler("eoc_ev:character_takeoff_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_IRON_ALLERGY_UNWEARING_IRON_OR_STEEL", ctx)
    H.run_eoc("EOC_LOVES_SHINY_OBJECTS_UNWEARING", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_FISH_REMOVE", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_BEAR_REMOVE", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_DEER_FOLLOWUP", ctx)
end)
ccb.runtime.on("game:character_takeoff_item", "eoc_ev:character_takeoff_item")
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MAGUS_STOP_ATTACK_SHIELD", ctx)
    H.run_eoc("EOC_MAGICLYSM_ORB_OF_LIGHT_CLASSLESS_REMOVED_ON_DAMAGE", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")
ccb.runtime.handler("eoc_ev:character_wears_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_IRON_ALLERGY_WEARING_IRON_OR_STEEL", ctx)
    H.run_eoc("EOC_LOVES_SHINY_OBJECTS_WEARING", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_FISH", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_BEAR", ctx)
    H.run_eoc("EOC_PUT_ON_WILDSHAPE_CLOAK_DEER", ctx)
    H.run_eoc("EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE", ctx)
end)
ccb.runtime.on("game:character_wears_item", "eoc_ev:character_wears_item")
ccb.runtime.handler("eoc_ev:character_wields_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_IRON_ALLERGY_WIELDING_IRON_OR_STEEL", ctx)
    H.run_eoc("EOC_LOVES_SHINY_OBJECTS_WIELDING", ctx)
end)
ccb.runtime.on("game:character_wields_item", "eoc_ev:character_wields_item")
ccb.runtime.handler("eoc_ev:game_avatar_new", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MANA_LEECH_START", ctx)
end)
ccb.runtime.on("game:game_avatar_new", "eoc_ev:game_avatar_new")
ccb.runtime.handler("eoc_ev:game_begin", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MAGICLYSM_RAVENFOLK_HOARDER_UPDATE", ctx)
end)
ccb.runtime.on("game:game_begin", "eoc_ev:game_begin")
ccb.runtime.handler("eoc_ev:game_load", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_FORGE_GAME_LOAD", ctx)
end)
ccb.runtime.on("game:game_load", "eoc_ev:game_load")
ccb.runtime.handler("eoc_ev:game_start", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_GAME_START", ctx)
end)
ccb.runtime.on("game:game_start", "eoc_ev:game_start")
ccb.runtime.handler("eoc_ev:opens_spellbook", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_magus_caster_level_boost", ctx)
    H.run_eoc("EOC_kelvinist_caster_level_boost", ctx)
    H.run_eoc("EOC_technomancer_caster_level_boost", ctx)
    H.run_eoc("EOC_biomancer_caster_level_boost", ctx)
    H.run_eoc("EOC_animist_caster_level_boost", ctx)
    H.run_eoc("EOC_stormshaper_caster_level_boost", ctx)
    H.run_eoc("EOC_earthshaper_caster_level_boost", ctx)
    H.run_eoc("EOC_druid_caster_level_boost", ctx)
    H.run_eoc("EOC_GRABBED_ARMS_MAKES_SOMATIC_SPELLS_HARDER", ctx)
    H.run_eoc("EOC_GRABBED_HANDS_MAKES_SOMATIC_SPELLS_HARDER", ctx)
    H.run_eoc("EOC_MAGICLYSM_BROKEN_LIMBS_MAKES_SOMATIC_SPELLS_HARDER", ctx)
    H.run_eoc("EOC_THAUMIC_ZOMBIES_INCREASE_DIFFICULTY", ctx)
    H.run_eoc("EOC_NO_CASTING_ENERVATION_SPELLS_EFFECTS", ctx)
    H.run_eoc("EOC_NO_CASTING_CONVEYANCE_SPELLS_EFFECTS", ctx)
    H.run_eoc("EOC_NO_CASTING_RESTORATION_SPELLS_EFFECTS", ctx)
    H.run_eoc("EOC_NO_CASTING_TRANSFORMATION_SPELLS_EFFECTS", ctx)
    H.run_eoc("EOC_NO_CASTING_FOR_EMPTY", ctx)
    H.run_eoc("EOC_MANA_OVERLOAD_MAKES_SPELLS_MORE_DIFFICULT", ctx)
    H.run_eoc("EOC_ARCHMAGE_BENEFITS_PROGRESSIVE_SCHOOL_DIFFICULTY_REDUCTIONS", ctx)
    H.run_eoc("EOC_perk_caster_level_up_animist", ctx)
    H.run_eoc("EOC_perk_caster_level_up_biomancer", ctx)
    H.run_eoc("EOC_perk_caster_level_up_druid", ctx)
    H.run_eoc("EOC_perk_caster_level_up_earthshaper", ctx)
    H.run_eoc("EOC_perk_caster_level_up_kelvinist", ctx)
    H.run_eoc("EOC_perk_caster_level_up_magus", ctx)
    H.run_eoc("EOC_perk_caster_level_up_stormshaper", ctx)
    H.run_eoc("EOC_perk_caster_level_up_technomancer", ctx)
    H.run_eoc("EOC_MAGICLYSM_SI_PRE_TELEPORT_LOCATION_CHECKING", ctx)
end)
ccb.runtime.on("game:opens_spellbook", "eoc_ev:opens_spellbook")
ccb.runtime.handler("eoc_ev:spellcasting_finish", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MANA_FLASH_SPELLCASTING_FINISH", ctx)
    H.run_eoc("EOC_MANA_LUM_EXTERNAL_SPELLCASTING_FINISH", ctx)
    H.run_eoc("EOC_technomancer_caster_level_boost_finish_casting", ctx)
    H.run_eoc("EOC_BIOMANCY_IS_DISTURBING", ctx)
    H.run_eoc("EOC_MAGICLYSM_SI_PRE_TELEPORT_POWER_CHECKING", ctx)
end)
ccb.runtime.on("game:spellcasting_finish", "eoc_ev:spellcasting_finish")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("EOC_DUST_REBORN", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "ARTIFICER") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(60)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING", "eoc_int:EOC_ATTUNEMENT_ARTIFICER_BATTERY_RECHARGING")
ccb.runtime.handler("eoc_rec:EOC_GIVE_FROZEN_PRESSURE_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_FROZEN_PRESSURE_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "GLACIER_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_FROZEN_PRESSURE_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_FROZEN_PRESSURE_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_FROZEN_PRESSURE_OFF", "eoc_int:EOC_GIVE_FROZEN_PRESSURE_OFF")
ccb.runtime.handler("eoc_rec:EOC_GIVE_CLAIRVOYANCE_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_CLAIRVOYANCE_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "RADIATION_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_CLAIRVOYANCE_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_CLAIRVOYANCE_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_CLAIRVOYANCE_OFF", "eoc_int:EOC_GIVE_CLAIRVOYANCE_OFF")
ccb.runtime.handler("eoc_rec:EOC_GIVE_MIND_READ", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_MIND_READ"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "SHAMAN") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_MIND_READ", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_MIND_READ", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_MIND_READ", "eoc_int:EOC_GIVE_MIND_READ")
ccb.runtime.handler("eoc_rec:EOC_GIVE_SOUL_PRESSURE_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_SOUL_PRESSURE_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "SOULFIRE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_SOUL_PRESSURE_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_SOUL_PRESSURE_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_SOUL_PRESSURE_OFF", "eoc_int:EOC_GIVE_SOUL_PRESSURE_OFF")
ccb.runtime.handler("eoc_rec:SUN_MAGE_BUFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:SUN_MAGE_BUFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "SUN_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("SUN_MAGE_BUFF", ctx)
end)
ccb.runtime.handler("eoc_int:SUN_MAGE_BUFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:SUN_MAGE_BUFF", "eoc_int:SUN_MAGE_BUFF")
ccb.runtime.handler("eoc_rec:EOC_GIVE_FREEZING_AURA_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_FREEZING_AURA_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "TUNDRA_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_FREEZING_AURA_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_FREEZING_AURA_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_FREEZING_AURA_OFF", "eoc_int:EOC_GIVE_FREEZING_AURA_OFF")
ccb.runtime.handler("eoc_rec:EOC_GIVE_TOXIC_AURA_OFF", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_GIVE_TOXIC_AURA_OFF"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "WITHER_MAGE") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_GIVE_TOXIC_AURA_OFF", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_GIVE_TOXIC_AURA_OFF", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_GIVE_TOXIC_AURA_OFF", "eoc_int:EOC_GIVE_TOXIC_AURA_OFF")
ccb.runtime.handler("eoc_rec:EOC_PLAYER_IN_FORGE", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PLAYER_IN_FORGE"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_PLAYER_IN_FORGE", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PLAYER_IN_FORGE", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1800)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PLAYER_IN_FORGE", "eoc_int:EOC_PLAYER_IN_FORGE")
ccb.runtime.handler("eoc_rec:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(86400), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE", "eoc_int:EOC_FANTASY_SPECIES_REMOVE_THRESHOLD_RECURRENCE")
ccb.runtime.handler("eoc_rec:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_any_trait(H.u(ctx), { "ELVEN_BUILD", "DWARVEN_BUILD", "GOBLIN_BUILD", "LIZARDFOLK_BUILD", "RAVENFOLK_BUILD" })))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(10), math.floor(10); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER", "eoc_int:EOC_FANTASY_SPECIES_TRANSFORM_PURIFIER")
ccb.runtime.handler("eoc_rec:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "MANA_LUM_EXTERNAL") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(43200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER", "eoc_int:EOC_MANA_LUM_EXTERNAL_RANDOM_TRIGGER")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_MANA_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_MANA_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_mana") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_MANA_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_MANA_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_MANA_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_MANA_MUTATOR")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:EOC_MANA_LEECH_PLAYER_NOT_WORN", function(_)
    local dk = "eoc_deact:EOC_MANA_LEECH_PLAYER_NOT_WORN"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_MANA_LEECH_PLAYER_NOT_WORN", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3600), math.floor(3600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_MANA_LEECH_PLAYER_NOT_WORN", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:EOC_MANA_LEECH_PLAYER_NOT_WORN") then
        ccb.state.world.set("eoc_glob_started:EOC_MANA_LEECH_PLAYER_NOT_WORN", true)
        ccb.tasks.after(1, "eoc_glob:EOC_MANA_LEECH_PLAYER_NOT_WORN", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
