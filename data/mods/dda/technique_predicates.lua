local ccb = require("ccb")
local services = ccb.services
local creatures = services.creatures
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function effect_intensity(creature, effect, part)
    return checked(services.effects.exact_intensity(creature, id("effect", effect),
        part and id("body_part", part)))
end

ccb.runtime.handler("allow_tec_biojutsu_takedown", function(combat)
    return not (effect_intensity(combat.target, "downed") ~= nil)
end)

ccb.runtime.handler("allow_tec_venom_snake_tail", function(combat)
    return effect_intensity(combat.target, "stunned") ~= nil
end)

ccb.runtime.handler("allow_tech_rodent_bite", function(combat)
    return checked(services.mutations.has_id_text(combat.attacker, "INCISORS"))
end)

ccb.runtime.handler("allow_tech_rabbit_bite_grabbed", function(combat)
    return checked(services.mutations.has_id_text(combat.attacker, "INCISORS"))
        and (effect_intensity(combat.attacker, "grabbed", "arm_r") ~= nil
            or effect_intensity(combat.attacker, "grabbed", "arm_l") ~= nil
            or effect_intensity(combat.attacker, "grabbed", "hand_r") ~= nil
            or effect_intensity(combat.attacker, "grabbed", "hand_l") ~= nil)
end)

ccb.runtime.handler("allow_tech_bird_peck", function(combat)
    return not (checked(services.mutations.has_id_text(combat.attacker, "WINGS_BIRD")))
end)

ccb.runtime.handler("allow_tech_bird_peck_if_wings", function(combat)
    return checked(services.mutations.has_id_text(combat.attacker, "WINGS_BIRD"))
end)

ccb.runtime.handler("allow_tech_bird_peck_grabbed", function(combat)
    return effect_intensity(combat.attacker, "grabbed", "arm_r") ~= nil
        or effect_intensity(combat.attacker, "grabbed", "arm_l") ~= nil
        or effect_intensity(combat.attacker, "grabbed", "hand_r") ~= nil
        or effect_intensity(combat.attacker, "grabbed", "hand_l") ~= nil
end)

ccb.runtime.handler("allow_tech_broad_paw_punch", function(combat)
    return not ((checked(services.mutations.has_id_text(combat.attacker, "CLAWS"))
            or checked(services.mutations.has_id_text(combat.attacker, "CLAWS_RAT"))
            or checked(services.mutations.has_id_text(combat.attacker, "CLAWS_ST"))
            or checked(services.mutations.has_id_text(combat.attacker, "CLAWS_RETRACT_active"))))
end)

ccb.runtime.handler("allow_tech_broad_paw_punch_with_claws", function(combat)
    return checked(services.mutations.has_id_text(combat.attacker, "CLAWS"))
        or checked(services.mutations.has_id_text(combat.attacker, "CLAWS_RAT"))
        or checked(services.mutations.has_id_text(combat.attacker, "CLAWS_ST"))
        or checked(services.mutations.has_id_text(combat.attacker, "CLAWS_RETRACT_active"))
end)

ccb.runtime.handler("allow_tech_broad_paw_smash_knockback", function(combat)
    return combat.attacker_size > combat.target_size
        or (combat.attacker_size == combat.target_size
            and checked(creatures.volume_ml(combat.attacker)) * 1.25 <= checked(creatures.volume_ml(combat.target)))
end)

ccb.runtime.handler("allow_vine_limb_trip", function(combat)
    return combat.attacker_size >= combat.target_size
end)

ccb.runtime.handler("allow_hooves_kick", function(combat)
    return combat.attacker_size >= combat.target_size
        and not (effect_intensity(combat.attacker, "natural_stance") ~= nil)
        and (not (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER")))
            and not (effect_intensity(combat.attacker, "GRAB") ~= nil))
end)

ccb.runtime.handler("allow_hooves_kick_against_large", function(combat)
    return combat.attacker_size < combat.target_size
        and not (effect_intensity(combat.attacker, "natural_stance") ~= nil)
        and (not (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER")))
            and not (effect_intensity(combat.attacker, "GRAB") ~= nil))
end)

ccb.runtime.handler("allow_hooves_kick_natural", function(combat)
    return combat.attacker_size >= combat.target_size
        and effect_intensity(combat.attacker, "natural_stance") ~= nil
        and (not (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER")))
            and not (effect_intensity(combat.attacker, "GRAB") ~= nil))
end)

ccb.runtime.handler("allow_hooves_kick_natural_against_large", function(combat)
    return combat.attacker_size < combat.target_size
        and effect_intensity(combat.attacker, "natural_stance") ~= nil
        and (not (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER")))
            and not (effect_intensity(combat.attacker, "GRAB") ~= nil))
end)

ccb.runtime.handler("allow_hooves_kick_crit", function(combat)
    return combat.attacker_size >= combat.target_size
end)

ccb.runtime.handler("allow_toe_talons_kick", function(combat)
    return not (effect_intensity(combat.attacker, "natural_stance") ~= nil)
        and (not (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER")))
            and not (effect_intensity(combat.attacker, "GRAB") ~= nil))
end)

ccb.runtime.handler("allow_toe_talons_kick_natural", function(combat)
    return effect_intensity(combat.attacker, "natural_stance") ~= nil
        and (not (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER")))
            and not (effect_intensity(combat.attacker, "GRAB") ~= nil))
end)

ccb.runtime.handler("allow_tail_scorpion_sting_natural", function(combat)
    return effect_intensity(combat.attacker, "natural_stance") ~= nil
        or (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
            and checked(creatures.has_flag_text(combat.attacker, "GRAB")))
end)

ccb.runtime.handler("allow_tail_thick_bash_crit", function(combat)
    return combat.attacker_size >= combat.target_size
        and not (checked(creatures.has_flag_text(combat.target, "STUMBLES")))
end)

ccb.runtime.handler("allow_tail_thick_bash_crit_vs_stumble", function(combat)
    return combat.attacker_size >= combat.target_size
        and checked(creatures.has_flag_text(combat.target, "STUMBLES"))
end)

ccb.runtime.handler("allow_tec_dbg_sting_effect_2", function(combat)
    return checked(creatures.has_flag_text(combat.attacker, "DREAMY"))
end)

ccb.runtime.handler("allow_fangs_bite", function(combat)
    return not (effect_intensity(combat.attacker, "natural_stance") ~= nil)
        and not ((checked(services.mutations.has_id_text(combat.attacker, "MUZZLE"))
                or checked(services.mutations.has_id_text(combat.attacker, "MUZZLE_BEAR"))
                or checked(services.mutations.has_id_text(combat.attacker, "MUZZLE_LONG"))
                or checked(services.mutations.has_id_text(combat.attacker, "MUZZLE_RAPTOR"))
                or checked(services.mutations.has_id_text(combat.attacker, "MUZZLE_RAT"))))
        and (not (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER")))
            and not (effect_intensity(combat.attacker, "GRAB") ~= nil))
end)

ccb.runtime.handler("allow_fangs_bite_effect_1", function(combat)
    return checked(creatures.has_flag_text(combat.attacker, "DRACULIN_VENOM"))
end)

ccb.runtime.handler("allow_fangs_bite_natural", function(combat)
    return not ((checked(services.mutations.has_id_text(combat.attacker, "MUZZLE"))
                or checked(services.mutations.has_id_text(combat.attacker, "MUZZLE_BEAR"))
                or checked(services.mutations.has_id_text(combat.attacker, "MUZZLE_LONG"))
                or checked(services.mutations.has_id_text(combat.attacker, "MUZZLE_RAPTOR"))
                or checked(services.mutations.has_id_text(combat.attacker, "MUZZLE_RAT"))))
        and (effect_intensity(combat.attacker, "natural_stance") ~= nil
            or (checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                and checked(creatures.has_flag_text(combat.attacker, "GRAB"))))
end)

ccb.runtime.handler("allow_brutal", function(combat)
    return combat.attacker_size >= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and (not (checked(creatures.has_species(combat.target, id("species", "NETHER"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER_EMANATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "LEECH_PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "MIGO"))))
            and not (checked(creatures.has_species(combat.target, id("species", "SLIME"))))
            and not (checked(creatures.has_species(combat.target, id("species", "FUNGUS"))))
            and not (checked(creatures.has_species(combat.target, id("species", "PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ROBOT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "CYBORG"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HALLUCINATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HORROR"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ABERRATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "KRAKEN")))))
        and ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                and checked(creatures.has_flag_text(combat.attacker, "GRAB"))
                and services.random.native_int(1, 20) + combat.attacker_strength > combat.target_grab_strength)
            or not ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                    and checked(creatures.has_flag_text(combat.attacker, "GRAB")))))
end)

ccb.runtime.handler("allow_wrap", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and combat.target_size ~= 1
        and not (checked(creatures.has_body_type(combat.target, "blob")))
        and not (checked(creatures.has_body_type(combat.target, "fish")))
        and not (checked(creatures.has_body_type(combat.target, "snake")))
end)

ccb.runtime.handler("allow_sweep", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and combat.target_size ~= 1
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
end)

ccb.runtime.handler("allow_precise", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and (not (checked(creatures.has_species(combat.target, id("species", "ZOMBIE"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER_EMANATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "LEECH_PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "MIGO"))))
            and not (checked(creatures.has_species(combat.target, id("species", "SLIME"))))
            and not (checked(creatures.has_species(combat.target, id("species", "FUNGUS"))))
            and not (checked(creatures.has_species(combat.target, id("species", "PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ROBOT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "CYBORG"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HALLUCINATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HORROR"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ABERRATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "KRAKEN")))))
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
end)

ccb.runtime.handler("allow_tec_precise", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
end)

ccb.runtime.handler("allow_tec_aikido_blockthrow", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and combat.target_size ~= 1
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
        and ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                and checked(creatures.has_flag_text(combat.attacker, "GRAB"))
                and services.random.native_int(1, 20) + combat.attacker_strength > combat.target_grab_strength)
            or not ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                    and checked(creatures.has_flag_text(combat.attacker, "GRAB")))))
end)

ccb.runtime.handler("allow_tec_bojutsu_frontstrike", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and combat.target_size ~= 1
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and not (checked(creatures.has_body_type(combat.target, "blob")))
end)

ccb.runtime.handler("allow_tec_boxing_counter", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
end)

ccb.runtime.handler("allow_tec_boxing_upper", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and combat.target_size - 1 <= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "mi-go"))
            or checked(creatures.has_body_type(combat.target, "kangoroo"))
            or checked(creatures.has_body_type(combat.target, "horse"))
            or checked(creatures.has_body_type(combat.target, "bear"))
            or checked(creatures.has_body_type(combat.target, "angel")))
end)

ccb.runtime.handler("allow_tec_brawl_power", function(combat)
    return combat.attacker_size >= combat.target_size
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and not (effect_intensity(combat.target, "stunned") ~= nil)
end)

ccb.runtime.handler("allow_tec_brawl_trip", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and combat.attacker_size - 1 <= combat.target_size
        and (checked(creatures.has_body_type(combat.target, "angel"))
            or checked(creatures.has_body_type(combat.target, "human")))
        and not (effect_intensity(combat.target, "downed") ~= nil)
end)

ccb.runtime.handler("allow_tec_capoeira_spinkick", function(combat)
    return combat.attacker_size >= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
end)

ccb.runtime.handler("allow_tec_crane_strike", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and (not (checked(creatures.has_species(combat.target, id("species", "ZOMBIE"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER_EMANATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "LEECH_PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "MIGO"))))
            and not (checked(creatures.has_species(combat.target, id("species", "SLIME"))))
            and not (checked(creatures.has_species(combat.target, id("species", "FUNGUS"))))
            and not (checked(creatures.has_species(combat.target, id("species", "PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ROBOT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "CYBORG"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HALLUCINATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HORROR"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ABERRATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "KRAKEN")))))
end)

ccb.runtime.handler("allow_tec_dragon_strike", function(combat)
    return effect_intensity(combat.target, "downed") ~= nil
end)

ccb.runtime.handler("allow_tec_judo_throw", function(combat)
    return combat.attacker_size <= combat.target_size
        and combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and checked(creatures.has_body_type(combat.target, "human"))
end)

ccb.runtime.handler("allow_tec_kickboxing_push", function(combat)
    return combat.attacker_size >= combat.target_size
        and ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                and checked(creatures.has_flag_text(combat.attacker, "GRAB"))
                and services.random.native_int(1, 20) + combat.attacker_strength > combat.target_grab_strength)
            or not ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                    and checked(creatures.has_flag_text(combat.attacker, "GRAB")))))
end)

ccb.runtime.handler("allow_tec_krav_maga_disarm", function(combat)
    return effect_intensity(combat.target, "downed") ~= nil
        and effect_intensity(combat.target, "stunned") ~= nil
        and (checked(creatures.has_species(combat.target, id("species", "HUMAN")))
            or checked(creatures.has_species(combat.target, id("species", "FERAL"))))
        and combat.attacker_size + 1 >= combat.target_size
        and checked(creatures.has_body_type(combat.target, "human"))
end)

ccb.runtime.handler("allow_tec_leopard_pounce", function(combat)
    return combat.attacker_size >= combat.target_size
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
end)

ccb.runtime.handler("allow_tec_ninjutsu_downkill", function(combat)
    return effect_intensity(combat.target, "downed") ~= nil
        and combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and (not (checked(creatures.has_species(combat.target, id("species", "ZOMBIE"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER_EMANATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "LEECH_PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "MIGO"))))
            and not (checked(creatures.has_species(combat.target, id("species", "SLIME"))))
            and not (checked(creatures.has_species(combat.target, id("species", "FUNGUS"))))
            and not (checked(creatures.has_species(combat.target, id("species", "PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ROBOT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "CYBORG"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HALLUCINATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HORROR"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ABERRATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "KRAKEN")))))
end)

ccb.runtime.handler("allow_tec_taekwondo_strong", function(combat)
    return combat.attacker_size + 1 >= combat.target_size
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
        and ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                and checked(creatures.has_flag_text(combat.attacker, "GRAB"))
                and services.random.native_int(1, 20) + combat.attacker_strength > combat.target_grab_strength)
            or not ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                    and checked(creatures.has_flag_text(combat.attacker, "GRAB")))))
end)

ccb.runtime.handler("allow_tec_taichi_precise", function(combat)
    return combat.attacker_size >= combat.target_size
        and not (effect_intensity(combat.target, "stunned") ~= nil)
        and (not (checked(creatures.has_species(combat.target, id("species", "ZOMBIE"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER"))))
            and not (checked(creatures.has_species(combat.target, id("species", "NETHER_EMANATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "LEECH_PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "MIGO"))))
            and not (checked(creatures.has_species(combat.target, id("species", "SLIME"))))
            and not (checked(creatures.has_species(combat.target, id("species", "FUNGUS"))))
            and not (checked(creatures.has_species(combat.target, id("species", "PLANT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ROBOT"))))
            and not (checked(creatures.has_species(combat.target, id("species", "CYBORG"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HALLUCINATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "HORROR"))))
            and not (checked(creatures.has_species(combat.target, id("species", "ABERRATION"))))
            and not (checked(creatures.has_species(combat.target, id("species", "KRAKEN")))))
        and ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                and checked(creatures.has_flag_text(combat.attacker, "GRAB"))
                and services.random.native_int(1, 20) + combat.attacker_strength > combat.target_grab_strength)
            or not ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                    and checked(creatures.has_flag_text(combat.attacker, "GRAB")))))
end)

ccb.runtime.handler("allow_tec_wingchun_hook_knockback", function(combat)
    return combat.attacker_size >= combat.target_size
        and ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                and checked(creatures.has_flag_text(combat.attacker, "GRAB"))
                and services.random.native_int(1, 20) + combat.attacker_strength > combat.target_grab_strength)
            or not ((checked(creatures.has_flag_text(combat.target, "GRAB_FILTER"))
                    and checked(creatures.has_flag_text(combat.attacker, "GRAB")))))
        and not (effect_intensity(combat.target, "downed") ~= nil)
        and (checked(creatures.has_body_type(combat.target, "human"))
            or checked(creatures.has_body_type(combat.target, "angel")))
end)
