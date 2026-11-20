local ccb = require("ccb")
local scaling = require("psychic_enchantment_scaling")
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function character(actor)
    return actor and (actor.subtype == "avatar" or actor.subtype == "npc" or actor.subtype == "character")
end

local function intelligence(actor)
    return character(actor) and checked(services.characters.snapshot(actor, 1)).stats.intelligence or 0
end

local function level(actor, spell)
    return character(actor) and checked(services.spells.effective_level(actor, spell)) or 0
end

local function intensity(actor, effect)
    if actor and actor.kind == "creature" then
        return checked(services.effects.exact_intensity(actor, id("effect", effect))) or -1
    end
    return -1
end

local function number(actor, key)
    if actor == nil then return 0 end
    return checked(services.variables.get_number(actor, key, { strict = true })).value or 0
end

local function vitamin(actor, name)
    return character(actor) and checked(services.needs.get_vitamin(actor, id("vitamin", name))) or 0
end

local function power(actor)
    local attunement = number(actor, "nether_attunement_power_scaling")
    if attunement == 0 then return 0 end
    local fatigue = scaling.weariness_from(function(effect) return intensity(actor, effect) end)
    return ccb.runtime.call_number("attribute_scaling", intelligence(actor)) * attunement * fatigue
end

local function maximum_level(actor, flag)
    if not character(actor) then return 0 end
    local crystal = checked(services.inventory.wielded_matches(actor, id("json_flag", flag)))
    return intelligence(actor) * 1.5 + (crystal and 6 or 0)
end

local function stat(name, compute)
    ccb.runtime.handler(name, function(context) return compute(context.speaker) end)
end

stat("scale_electrokin_zap_attacked_min_damage", function(actor)
    return (level(actor, "electrokinesis_zap_enemies") / 4 + 1) * ccb.runtime.call_number("attribute_scaling", intelligence(actor)) * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_electrokin_zap_attacked_max_damage", function(actor)
    return (level(actor, "electrokinesis_zap_enemies") / 2 + 5) * ccb.runtime.call_number("attribute_scaling", intelligence(actor)) * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_electrokin_zap_attack_min_damage", function(actor)
    return (level(actor, "electrokinetic_melee_attacks") / 3 + 3) * ccb.runtime.call_number("attribute_scaling", intelligence(actor)) * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_electrokin_zap_attack_max_damage", function(actor)
    return (level(actor, "electrokinetic_melee_attacks") / 1.5 + 10) * ccb.runtime.call_number("attribute_scaling", intelligence(actor)) * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_photokin_blinding_glare_attack_max_level", function(actor)
    return maximum_level(actor, "MATRIX_CRYSTAL_PHOTOKINESIS")
end)

stat("scale_photokin_blinding_glare_attack_min_aoe", function(actor)
    return math.min((level(actor, "photokinetic_blinding_glare") * 1.2 + 5) * ccb.runtime.call_number("attribute_scaling", intelligence(actor)) * number(actor, "nether_attunement_power_scaling"), 40)
end)

stat("scale_pyro_aura_attack_min_damage", function(actor)
    return 5 * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_pyro_aura_attack_max_damage", function(actor)
    return 15 * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_pyro_aura_attacked_max_damage", function(actor)
    return 20 * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_electro_potion_attacked_min_damage", function(actor)
    return 3 * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_electro_potion_attacked_max_damage", function(actor)
    return 7 * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_telepathic_blast_radius_mind_cry_max_level", function(actor)
    return maximum_level(actor, "MATRIX_CRYSTAL_TELEPATHY")
end)

stat("scale_telepathic_blast_radius_mind_cry_min_damage", function(actor)
    return 9 * ccb.runtime.call_number("attribute_scaling", intelligence(actor)) * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_telepathic_blast_radius_mind_cry_max_damage", function(actor)
    return 15 * ccb.runtime.call_number("attribute_scaling", intelligence(actor)) * number(actor, "nether_attunement_power_scaling")
end)

stat("scale_telepathic_blast_radius_mind_cry_min_aoe", function(actor)
    return math.min(9.2 * ccb.runtime.call_number("attribute_scaling", intelligence(actor)) * number(actor, "nether_attunement_power_scaling"), 40)
end)

stat("scale_biokin_sealed_system_max_level", function(actor)
    return maximum_level(actor, "MATRIX_CRYSTAL_BIOKINESIS")
end)

stat("scale_biokin_sealed_system_min_duration", function(actor)
    return (level(actor, "biokin_sealed_system") * 800 + 6000) * power(actor)
end)

stat("scale_biokin_sealed_system_max_duration", function(actor)
    return (level(actor, "biokin_sealed_system") * 2500 + 30000) * power(actor)
end)

stat("scale_clair_sense_rads_outside_max_level", function(actor)
    return maximum_level(actor, "MATRIX_CRYSTAL_CLAIRSENTIENCE")
end)

stat("scale_clair_sense_rads_outside_min_duration", function(actor)
    return (level(actor, "clair_sense_rads") * 23000 + 180000) * power(actor)
end)

stat("scale_clair_sense_rads_outside_max_duration", function(actor)
    return (level(actor, "clair_sense_rads") * 48000 + 450000) * power(actor)
end)

stat("scale_clair_voyance_min_range", function(actor)
    return math.min((level(actor, "clair_voyance") * 1.2 + 2) * power(actor), 80)
end)

stat("scale_clair_voyance_min_aoe", function(actor)
    return math.min((level(actor, "clair_voyance") * 1.2 + 1.5) * power(actor), 50)
end)

stat("scale_clair_voyance_min_duration", function(actor)
    return (level(actor, "clair_voyance") * 50 + 250) * power(actor)
end)

stat("scale_clair_voyance_max_duration", function(actor)
    return (level(actor, "clair_voyance") * 110 + 1500) * power(actor)
end)

stat("scale_clair_see_map_min_aoe", function(actor)
    return (level(actor, "clair_see_map") * 0.5 + 4) * power(actor)
end)

stat("scale_clair_see_map_max_aoe", function(actor)
    return (level(actor, "clair_see_map") * 1 + 11) * power(actor)
end)

stat("scale_clair_omniscience_min_duration", function(actor)
    return (level(actor, "clair_omniscience") * 75 + 200) * power(actor)
end)

stat("scale_clair_omniscience_max_duration", function(actor)
    return (level(actor, "clair_omniscience") * 150 + 1000) * power(actor)
end)

stat("scale_electrokinetic_lightning_aura_spark_max_level", function(actor)
    return maximum_level(actor, "MATRIX_CRYSTAL_ELECTROKINESIS")
end)

stat("scale_electrokinetic_lightning_aura_attack_placeholder_min_damage", function(actor)
    return (level(actor, "electrokinetic_lightning_aura") * 1 + 5) * ccb.runtime.call_number("attribute_scaling", intelligence(actor))
end)

stat("scale_electrokinetic_lightning_aura_attack_placeholder_max_damage", function(actor)
    return (level(actor, "electrokinetic_lightning_bolt") * 1.5 + 20) * ccb.runtime.call_number("attribute_scaling", intelligence(actor))
end)

stat("scale_electrokinetic_lightning_aura_attack_placeholder_min_range", function(actor)
    return math.min((level(actor, "electrokinetic_lightning_aura") * 0.33 + 2) * ccb.runtime.call_number("attribute_scaling", intelligence(actor)), 10)
end)

stat("scale_electrokinetic_lightning_blast_min_damage", function(actor)
    return (level(actor, "electrokinetic_lightning_blast") * 2 + 25) * power(actor)
end)

stat("scale_electrokinetic_lightning_blast_max_damage", function(actor)
    return (level(actor, "electrokinetic_lightning_blast") * 4.5 + 90) * power(actor)
end)

stat("scale_electrokinetic_lightning_blast_min_range", function(actor)
    return math.min((level(actor, "electrokinetic_lightning_blast") * 0.7 + 2) * power(actor), 50)
end)

stat("scale_electrokinetic_lightning_blast_min_aoe", function(actor)
    return math.min((level(actor, "electrokinetic_lightning_blast") * 0.25 + 1) * power(actor), 15)
end)

stat("scale_electrokinetic_lightning_blast_trail_min_damage", function(actor)
    return (level(actor, "electrokinetic_lightning_blast") * 0.5 + 5) * power(actor)
end)

stat("scale_electrokinetic_lightning_blast_trail_max_damage", function(actor)
    return (level(actor, "electrokinetic_lightning_blast") * 1.5 + 25) * power(actor)
end)

stat("scale_electrokinetic_lightning_blast_trail_min_range", function(actor)
    return math.min((level(actor, "electrokinetic_lightning_blast") * 0.3 + 2) * power(actor), 50)
end)

stat("scale_electrokinetic_lightning_blast_trail_min_aoe", function(actor)
    return math.min((level(actor, "electrokinetic_lightning_blast") * 0.06 + 0) * power(actor), 1)
end)

stat("scale_electrokinetic_revive_min_range", function(actor)
    return math.min((level(actor, "electrokinetic_revive") * 0.25 + 2) * power(actor), 40)
end)

stat("scale_electrokinetic_shock_touch_min_damage", function(actor)
    return (level(actor, "electrokinetic_shock_touch") * 1 + 2) * power(actor)
end)

stat("scale_electrokinetic_shock_touch_max_damage", function(actor)
    return (level(actor, "electrokinetic_shock_touch") * 1.5 + 7) * power(actor)
end)

stat("scale_electrokinetic_lightning_bolt_min_damage", function(actor)
    return (level(actor, "electrokinetic_lightning_bolt") * 2 + 20) * power(actor)
end)

stat("scale_electrokinetic_lightning_bolt_max_damage", function(actor)
    return (level(actor, "electrokinetic_lightning_bolt") * 4 + 45) * power(actor)
end)

stat("scale_electrokinetic_lightning_bolt_min_range", function(actor)
    return math.min((level(actor, "electrokinetic_lightning_bolt") * 0.7 + 3) * power(actor), 50)
end)

stat("scale_electrokinetic_recharge_vehicle_min_damage", function(actor)
    return (level(actor, "electrokinetic_recharge_vehicle") * 125 + 250) * power(actor)
end)

stat("scale_electrokinetic_recharge_vehicle_max_damage", function(actor)
    return (level(actor, "electrokinetic_recharge_vehicle") * 250 + 500) * power(actor)
end)

stat("scale_electrokinetic_kill_robot_min_range", function(actor)
    return math.min((level(actor, "electrokinetic_kill_robot") * 0.7 + 1) * power(actor), 50)
end)

stat("scale_electrokinetic_kill_robot_sparks_min_range", function(actor)
    return math.min((level(actor, "electrokinetic_kill_robot") * 0.4 + 1) * power(actor), 50)
end)

stat("scale_nether_attunement_everyone_downed_min_aoe", function(actor)
    return math.max(0, math.min(vitamin(actor, "vitamin_psionic_drain") * 0.25 - 125, 30)) + 2
end)

stat("scale_photokinetic_create_light_01_min_range", function(actor)
    return math.min((level(actor, "photokinetic_create_light") * 1.2 + 5) * power(actor), 70)
end)

stat("scale_photokinetic_create_light_01_min_aoe", function(actor)
    return math.min((level(actor, "photokinetic_create_light") * 0.8 + 1) * power(actor), 50)
end)

stat("scale_photokinetic_snuff_light_min_duration", function(actor)
    return (level(actor, "photokinetic_snuff_light") * 1000 + 5000) * power(actor)
end)

stat("scale_photokinetic_snuff_light_max_duration", function(actor)
    return (level(actor, "photokinetic_snuff_light") * 1000 + 10000) * power(actor)
end)

stat("scale_photokinetic_snuff_light_min_range", function(actor)
    return math.min((level(actor, "photokinetic_snuff_light") * 1.2 + 5) * power(actor), 70)
end)

stat("scale_photokinetic_snuff_light_min_aoe", function(actor)
    return math.min((level(actor, "photokinetic_snuff_light") * 0.8 + 1) * power(actor), 50)
end)

stat("scale_photokinetic_light_beam_min_damage", function(actor)
    return (level(actor, "photokinetic_light_beam") * 1.5 + 3) * power(actor)
end)

stat("scale_photokinetic_light_beam_max_damage", function(actor)
    return (level(actor, "photokinetic_light_beam") * 3.5 + 15) * power(actor)
end)

stat("scale_photokinetic_light_beam_min_range", function(actor)
    return math.min((level(actor, "photokinetic_light_beam") * 0.6 + 2) * power(actor), 30)
end)

stat("scale_photokinetic_light_arms_min_duration", function(actor)
    return (level(actor, "photokinetic_light_arms") * 800 + 2600) * power(actor)
end)

stat("scale_photokinetic_light_arms_max_duration", function(actor)
    return (level(actor, "photokinetic_light_arms") * 4100 + 7100) * power(actor)
end)

stat("scale_photokinetic_flash_bang_min_range", function(actor)
    return math.min((level(actor, "photokinetic_flash_bang") * 0.7 + 3) * power(actor), 50)
end)

stat("scale_photokinetic_flash_bang_min_aoe", function(actor)
    return math.min((level(actor, "photokinetic_flash_bang") * 0.5 + 2) * power(actor), 30)
end)

stat("scale_photokinetic_light_image_max_damage", function(actor)
    return level(actor, "photokinetic_light_image") / 3 * power(actor)
end)

stat("scale_photokinetic_light_image_min_duration", function(actor)
    return (level(actor, "photokinetic_light_image") * 550 + 4840) * power(actor)
end)

stat("scale_photokinetic_light_image_max_duration", function(actor)
    return (level(actor, "photokinetic_light_image") * 1350 + 13650) * power(actor)
end)

stat("scale_photokinetic_light_image_min_range", function(actor)
    return math.min((level(actor, "photokinetic_light_image") * 0.8 + 2) * power(actor), 40)
end)

stat("scale_photokinetic_stun_robots_min_duration", function(actor)
    return (level(actor, "photokinetic_stun_robots") * 200 + 75) * power(actor)
end)

stat("scale_photokinetic_stun_robots_max_duration", function(actor)
    return (level(actor, "photokinetic_stun_robots") * 300 + 150) * power(actor)
end)

stat("scale_photokinetic_stun_robots_min_range", function(actor)
    return math.min((level(actor, "photokinetic_stun_robots") * 0.8 + 3) * power(actor), 50)
end)

stat("scale_photokinetic_stun_robots_min_aoe", function(actor)
    return math.min((level(actor, "photokinetic_stun_robots") * 0.25 + 1) * power(actor), 20)
end)

stat("scale_photokinetic_light_flash_min_damage", function(actor)
    return (level(actor, "photokinetic_light_flash") * 2.5 + 20) * power(actor)
end)

stat("scale_photokinetic_light_flash_max_damage", function(actor)
    return (level(actor, "photokinetic_light_flash") * 6 + 54) * power(actor)
end)

stat("scale_photokinetic_light_flash_min_range", function(actor)
    return math.min((level(actor, "photokinetic_light_flash") * 0.6 + 2) * power(actor), 50)
end)

stat("scale_photokinetic_light_flash_min_aoe", function(actor)
    return math.min((level(actor, "photokinetic_light_flash") * 0.3 + 1) * power(actor), 20)
end)

stat("scale_photokinetic_light_disintegrate_min_damage", function(actor)
    return (level(actor, "photokinetic_light_disintegrate") * 5.5 + 45) * power(actor)
end)

stat("scale_photokinetic_light_disintegrate_max_damage", function(actor)
    return (level(actor, "photokinetic_light_disintegrate") * 17 + 135) * power(actor)
end)

stat("scale_photokinetic_light_disintegrate_min_range", function(actor)
    return math.min((level(actor, "photokinetic_light_disintegrate") * 0.8 + 2) * power(actor), 50)
end)

stat("scale_pyrokinetic_blast_max_level", function(actor)
    return maximum_level(actor, "MATRIX_CRYSTAL_PYROKINESIS")
end)

stat("scale_pyrokinetic_blast_min_damage", function(actor)
    return ((level(actor, "pyrokinetic_blast") + level(actor, "pyrokinetic_blast_knack")) * 2.5 + 37) * power(actor)
end)

stat("scale_pyrokinetic_blast_max_damage", function(actor)
    return ((level(actor, "pyrokinetic_blast") + level(actor, "pyrokinetic_blast_knack")) * 5 + 115) * power(actor)
end)

stat("scale_pyrokinetic_blast_min_range", function(actor)
    return math.min(((level(actor, "pyrokinetic_blast") + level(actor, "pyrokinetic_blast_knack")) * 0.9 + 4) * power(actor), 70)
end)

stat("scale_pyrokinetic_blast_min_aoe", function(actor)
    return math.min(((level(actor, "pyrokinetic_blast") + level(actor, "pyrokinetic_blast_knack")) * 0.4 + 2) * power(actor), 25)
end)

stat("scale_pyrokinetic_aoe_blast_min_damage", function(actor)
    return (level(actor, "pyrokinetic_aoe_blast") * 5 + 65) * power(actor)
end)

stat("scale_pyrokinetic_aoe_blast_max_damage", function(actor)
    return (level(actor, "pyrokinetic_aoe_blast") * 8.5 + 169) * power(actor)
end)

stat("scale_pyrokinetic_aoe_blast_min_aoe", function(actor)
    return math.min((level(actor, "pyrokinetic_aoe_blast") * 0.9 + 4) * power(actor), 35)
end)

stat("scale_pyrokinetic_incineration_min_damage", function(actor)
    return (level(actor, "pyrokinetic_incineration") * 10 + 150) * power(actor)
end)

stat("scale_pyrokinetic_incineration_max_damage", function(actor)
    return (level(actor, "pyrokinetic_incineration") * 25 + 400) * power(actor)
end)

stat("scale_pyrokinetic_incineration_min_range", function(actor)
    return math.min((level(actor, "pyrokinetic_incineration") * 0.5 + 2) * power(actor), 20)
end)

stat("scale_pyrokinetic_eruption_min_damage", function(actor)
    return ((level(actor, "pyrokinetic_eruption") + level(actor, "pyrokinetic_eruption_knack")) * 1.5 + 6) * power(actor)
end)

stat("scale_pyrokinetic_eruption_max_damage", function(actor)
    return ((level(actor, "pyrokinetic_eruption") + level(actor, "pyrokinetic_eruption_knack")) * 3 + 26) * power(actor)
end)

stat("scale_pyrokinetic_eruption_min_range", function(actor)
    return math.max(1, math.min(((level(actor, "pyrokinetic_eruption") + level(actor, "pyrokinetic_eruption_knack")) / 10 + 1) * power(actor), 5))
end)

stat("scale_pyrokinetic_flash_min_range", function(actor)
    return math.min(((level(actor, "pyrokinetic_flash") + level(actor, "pyrokinetic_flash_knack")) * 1.2 + 3) * power(actor), 50)
end)

stat("scale_pyrokinetic_flash_min_aoe", function(actor)
    return math.min(((level(actor, "pyrokinetic_flash") + level(actor, "pyrokinetic_flash_knack")) * 0.25 + 1) * power(actor), 8)
end)

stat("scale_pyrokinetic_flash_min_duration", function(actor)
    return ((level(actor, "pyrokinetic_flash") + level(actor, "pyrokinetic_flash_knack")) * 50 + 100) * power(actor)
end)

stat("scale_pyrokinetic_flash_max_duration", function(actor)
    return ((level(actor, "pyrokinetic_flash") + level(actor, "pyrokinetic_flash_knack")) * 100 + 800) * power(actor)
end)

stat("scale_pyrokinetic_quell_flames_min_range", function(actor)
    return math.min((level(actor, "pyrokinetic_quell_flames") * 0.8 + 3) * power(actor), 70)
end)

stat("scale_pyrokinetic_quell_flames_min_aoe", function(actor)
    return math.min((level(actor, "pyrokinetic_quell_flames") * 0.5 + 1) * power(actor), 50)
end)

stat("scale_pyrokinetic_quell_flames_self_min_range", function(actor)
    return math.min((level(actor, "pyrokinetic_quell_flames") * 0.8 + 5) * power(actor), 70)
end)

stat("scale_pyrokinetic_flamethrower_min_damage", function(actor)
    return ((level(actor, "pyrokinetic_flamethrower") + level(actor, "pyrokinetic_flamethrower_knack")) * 1.5 + 15) * power(actor)
end)

stat("scale_pyrokinetic_flamethrower_max_damage", function(actor)
    return ((level(actor, "pyrokinetic_flamethrower") + level(actor, "pyrokinetic_flamethrower_knack")) * 2.5 + 40) * power(actor)
end)

stat("scale_pyrokinetic_flamethrower_min_range", function(actor)
    return math.min(((level(actor, "pyrokinetic_flamethrower") + level(actor, "pyrokinetic_flamethrower_knack")) * 0.3 + 3) * power(actor), 20)
end)

stat("scale_pyrokinetic_flamethrower_min_aoe", function(actor)
    return math.min(((level(actor, "pyrokinetic_flamethrower") + level(actor, "pyrokinetic_flamethrower_knack")) * 3 + 27) * power(actor), 120)
end)

stat("scale_pyrokin_summon_thermogenesis_1_min_duration", function(actor)
    return (level(actor, "pyrokinetic_thermogenesis") * 15000 + 360000) * power(actor)
end)

stat("scale_pyrokin_summon_thermogenesis_1_max_duration", function(actor)
    return (level(actor, "pyrokinetic_thermogenesis") * 30000 + 720000) * power(actor)
end)

stat("scale_telekinetic_item_pull_real_max_level", function(actor)
    return maximum_level(actor, "MATRIX_CRYSTAL_TELEKINESIS")
end)

stat("scale_telekinetic_item_pull_real_min_damage", function(actor)
    return math.max(50 - (level(actor, "telekinetic_pull") + level(actor, "telekinetic_pull_knack")) * 3 * power(actor), 0)
end)

stat("scale_telekinetic_item_pull_real_max_damage", function(actor)
    return math.max(100 - (level(actor, "telekinetic_pull") + level(actor, "telekinetic_pull_knack")) * 4 * power(actor), 0)
end)

stat("scale_telekinetic_item_pull_real_min_aoe", function(actor)
    return (level(actor, "telekinetic_pull") + level(actor, "telekinetic_pull_knack")) * 0.2 * power(actor)
end)

stat("scale_telekinetic_item_pull_real_min_range", function(actor)
    return math.min(((level(actor, "telekinetic_pull") + level(actor, "telekinetic_pull_knack")) * 0.9 + 2) * power(actor), 40)
end)

stat("scale_telekinetic_item_push_real_min_damage", function(actor)
    return math.min(((level(actor, "telekinetic_pull") + level(actor, "telekinetic_pull_knack")) * 0.4 + 1) * power(actor), 40)
end)

stat("scale_telekinetic_item_push_real_max_damage", function(actor)
    return math.min(((level(actor, "telekinetic_pull") + level(actor, "telekinetic_pull_knack")) * 0.9 + 4) * power(actor), 40)
end)

stat("scale_telekinetic_item_push_real_min_range", function(actor)
    return math.min(((level(actor, "telekinetic_pull") + level(actor, "telekinetic_pull_knack")) * 0.9 + 2) * power(actor), 40)
end)

stat("scale_telekinetic_item_push_real_max_range", function(actor)
    return math.min(((level(actor, "telekinetic_pull") + level(actor, "telekinetic_pull_knack")) * 0.9 + 2) * power(actor), 40)
end)

stat("scale_telekinetic_noise_min_damage", function(actor)
    return (level(actor, "telekinetic_noise") * 0.5 + 3) * power(actor)
end)

stat("scale_telekinetic_noise_max_damage", function(actor)
    return (level(actor, "telekinetic_noise") * 1.5 + 8) * power(actor)
end)

stat("scale_telekinetic_noise_min_range", function(actor)
    return math.min((level(actor, "telekinetic_noise") * 0.9 + 2) * power(actor), 60)
end)

stat("scale_telekinetic_slam_down_min_damage", function(actor)
    return ((level(actor, "telekinetic_slam_down") + level(actor, "telekinetic_slam_down_knack")) * 0.5 + 5) * power(actor)
end)

stat("scale_telekinetic_slam_down_max_damage", function(actor)
    return ((level(actor, "telekinetic_slam_down") + level(actor, "telekinetic_slam_down_knack")) * 1.2 + 15) * power(actor)
end)

stat("scale_telekinetic_slam_down_min_duration", function(actor)
    return ((level(actor, "telekinetic_slam_down") + level(actor, "telekinetic_slam_down_knack")) * 25 + 100) * power(actor)
end)

stat("scale_telekinetic_slam_down_max_duration", function(actor)
    return ((level(actor, "telekinetic_slam_down") + level(actor, "telekinetic_slam_down_knack")) * 95 + 400) * power(actor)
end)

stat("scale_telekinetic_slam_down_min_range", function(actor)
    return math.min(((level(actor, "telekinetic_slam_down") + level(actor, "telekinetic_slam_down_knack")) * 0.5 + 2) * power(actor), 40)
end)

stat("scale_telekinetic_slowfall_min_duration", function(actor)
    return (level(actor, "telekinetic_slowfall") * 100 + 300) * power(actor)
end)

stat("scale_telekinetic_slowfall_max_duration", function(actor)
    return (level(actor, "telekinetic_slowfall") * 400 + 1500) * power(actor)
end)

stat("scale_telekinetic_hammer_min_damage", function(actor)
    return (level(actor, "telekinetic_hammer") * 1.25 + 18) * power(actor)
end)

stat("scale_telekinetic_hammer_max_damage", function(actor)
    return (level(actor, "telekinetic_hammer") * 3.5 + 55) * power(actor)
end)

stat("scale_telekinetic_hammer_min_range", function(actor)
    return math.min((level(actor, "telekinetic_hammer") * 0.9 + 3) * power(actor), 70)
end)

stat("scale_telekinetic_explosion_min_damage", function(actor)
    return (level(actor, "telekinetic_explosion") * 3 + 22) * power(actor)
end)

stat("scale_telekinetic_explosion_max_damage", function(actor)
    return (level(actor, "telekinetic_explosion") * 7.5 + 99) * power(actor)
end)

stat("scale_telekinetic_explosion_min_range", function(actor)
    return math.min((level(actor, "telekinetic_explosion") * 0.9 + 4) * power(actor), 60)
end)

stat("scale_telekinetic_explosion_min_aoe", function(actor)
    return math.min((level(actor, "telekinetic_explosion") * 0.3 + 2) * power(actor), 30)
end)

stat("scale_telekinetic_aegis_max_duration", function(actor)
    return (level(actor, "telekinetic_aegis") * 20 + 200) * power(actor)
end)

stat("scale_telekinetic_earthshaker_min_duration", function(actor)
    return (level(actor, "telekinetic_earthshaker") * 45 + 200) * power(actor)
end)

stat("scale_telekinetic_earthshaker_max_duration", function(actor)
    return (level(actor, "telekinetic_earthshaker") * 75 + 500) * power(actor)
end)

stat("scale_telekinetic_earthshaker_min_aoe", function(actor)
    return math.min((level(actor, "telekinetic_earthshaker") * 0.8 + 5) * power(actor), 35)
end)

stat("scale_telekinetic_earthshaker_bash_terrain_min_damage", function(actor)
    return (level(actor, "telekinetic_earthshaker") * 2.5 + 30) * power(actor)
end)

stat("scale_telekinetic_earthshaker_bash_terrain_max_damage", function(actor)
    return (level(actor, "telekinetic_earthshaker") * 7 + 80) * power(actor)
end)

stat("scale_telekinetic_earthshaker_bash_terrain_min_aoe", function(actor)
    return math.min((level(actor, "telekinetic_earthshaker") * 0.7 + 5) * power(actor), 35)
end)

stat("scale_telepathic_blast_min_damage", function(actor)
    return ((level(actor, "telepathic_blast") + level(actor, "telepathic_blast_knack") * 1.5) * 1.5 + 5) * power(actor)
end)

stat("scale_telepathic_blast_max_damage", function(actor)
    return (level(actor, "telepathic_blast") * 3 + level(actor, "telepathic_blast_knack") * 3 + 5) * power(actor)
end)

stat("scale_telepathic_blast_min_range", function(actor)
    return math.min((level(actor, "telepathic_blast") * 1.1 + level(actor, "telepathic_blast_knack") * 1.1 + 3) * power(actor), 80)
end)

stat("scale_telepathic_confusion_min_duration", function(actor)
    return (level(actor, "telepathic_confusion") * 50 + 200) * power(actor)
end)

stat("scale_telepathic_confusion_max_duration", function(actor)
    return (level(actor, "telepathic_confusion") * 150 + 800) * power(actor)
end)

stat("scale_telepathic_confusion_min_range", function(actor)
    return math.min((level(actor, "telepathic_confusion") * 1.1 + 3) * power(actor), 80)
end)

stat("scale_telepathic_confusion_blind_min_duration", function(actor)
    return (level(actor, "telepathic_confusion") * 100 + 400) * power(actor)
end)

stat("scale_telepathic_confusion_blind_max_duration", function(actor)
    return (level(actor, "telepathic_confusion") * 100 + 2000) * power(actor)
end)

stat("scale_telepathic_confusion_blind_min_range", function(actor)
    return (level(actor, "telepathic_confusion") * 2 + 3) * power(actor)
end)

stat("scale_telepathic_invisibility_min_duration", function(actor)
    return ((level(actor, "telepathic_invisibility") + level(actor, "telepathic_invisibility_knack")) * 1300 + 12700) * power(actor)
end)

stat("scale_telepathic_invisibility_max_duration", function(actor)
    return ((level(actor, "telepathic_invisibility") + level(actor, "telepathic_invisibility_knack")) * 5200 + 52300) * power(actor)
end)

stat("scale_telepathic_invisibility_min_range", function(actor)
    return math.min(((level(actor, "telepathic_invisibility") + level(actor, "telepathic_invisibility_knack")) * 1.5 + 3) * power(actor), 80)
end)

stat("scale_telepathic_invisibility_min_aoe", function(actor)
    return math.min(((level(actor, "telepathic_invisibility") + level(actor, "telepathic_invisibility_knack")) * 0.15 + 0) * power(actor), 4)
end)

stat("scale_telepathic_blast_radius_min_damage", function(actor)
    return (level(actor, "telepathic_blast_radius") * 1 + level(actor, "telepathic_blast_radius_knack") * 1 + 3) * power(actor)
end)

stat("scale_telepathic_blast_radius_max_damage", function(actor)
    return (level(actor, "telepathic_blast_radius") * 2 + level(actor, "telepathic_blast_radius_knack") * 2 + 3) * power(actor)
end)

stat("scale_telepathic_blast_radius_min_aoe", function(actor)
    return math.min((level(actor, "telepathic_blast_radius") * 1.2 + level(actor, "telepathic_blast_radius_knack") * 1.2 + 2) * power(actor), 40)
end)

stat("scale_telepathic_beast_taming_min_damage", function(actor)
    return (level(actor, "telepathic_beast_taming") * 15 + 200) * power(actor)
end)

stat("scale_telepathic_beast_taming_max_damage", function(actor)
    return (level(actor, "telepathic_beast_taming") * 35 + 500) * power(actor)
end)

stat("scale_telepathic_beast_taming_min_duration", function(actor)
    return (level(actor, "telepathic_beast_taming") * 8640000 + 241920000) * power(actor)
end)

stat("scale_telepathic_beast_taming_max_duration", function(actor)
    return (level(actor, "telepathic_beast_taming") * 25920000 + 483840000) * power(actor)
end)

stat("scale_telepathic_beast_taming_min_range", function(actor)
    return math.min((level(actor, "telepathic_beast_taming") * 1 + 3) * power(actor), 70)
end)

stat("scale_telepathic_mind_control_min_damage", function(actor)
    return (level(actor, "telepathic_mind_control") * 4 + 30) * power(actor)
end)

stat("scale_telepathic_mind_control_max_damage", function(actor)
    return (level(actor, "telepathic_mind_control") * 6 + 120) * power(actor)
end)

stat("scale_telepathic_mind_control_min_duration", function(actor)
    return (level(actor, "telepathic_mind_control") * 150 + 600) * power(actor)
end)

stat("scale_telepathic_mind_control_max_duration", function(actor)
    return (level(actor, "telepathic_mind_control") * 650 + 5200) * power(actor)
end)

stat("scale_telepathic_mind_control_min_range", function(actor)
    return math.min((level(actor, "telepathic_mind_control") * 1 + 3) * power(actor), 70)
end)

stat("scale_telepathic_network_real_min_duration", function(actor)
    return (level(actor, "telepathic_network") * 700 + 10000) * power(actor)
end)

stat("scale_telepathic_network_real_max_duration", function(actor)
    return (level(actor, "telepathic_network") * 3400 + 30000) * power(actor)
end)

stat("scale_teleport_slow_max_level", function(actor)
    return maximum_level(actor, "MATRIX_CRYSTAL_TELEPORTATION")
end)

stat("scale_teleport_slow_min_range", function(actor)
    return math.min((level(actor, "teleport_slow") * 1.2 + 3) * power(actor), 80)
end)

stat("scale_teleport_slow_min_duration", function(actor)
    return (level(actor, "teleport_slow") * 75 + 125) * power(actor)
end)

stat("scale_teleport_slow_max_duration", function(actor)
    return (level(actor, "teleport_slow") * 200 + 1500) * power(actor)
end)

stat("scale_teleport_phase_real_min_range", function(actor)
    return math.max(2, math.min((level(actor, "teleport_phase") * 0.1 + 2) * power(actor), 4))
end)

stat("scale_teleport_transpose_min_range", function(actor)
    return math.min((level(actor, "teleport_transpose") * 1.5 + 1) * power(actor), 80)
end)

stat("scale_teleport_collapse_01_min_range", function(actor)
    return math.min((level(actor, "teleport_collapse") * 1.2 + 5) * power(actor), 80)
end)

stat("scale_teleport_collapse_01_min_aoe", function(actor)
    return math.min((level(actor, "teleport_collapse") * 0.25 + 3) * power(actor), 15)
end)

stat("scale_teleport_farstep_real_max_aoe", function(actor)
    return math.min(level(actor, "teleport_farstep") * -0.2 + 4, 1)
end)

stat("scale_teleport_farstep_real_min_range", function(actor)
    return math.min((level(actor, "teleport_farstep") * 2 + 1) * power(actor), 80)
end)

stat("scale_teleport_reality_tear_temporary_min_range", function(actor)
    return math.min((level(actor, "teleport_reality_tear") * 1.3 + 2) * power(actor), 80)
end)

stat("scale_vita_hurt_touch_max_level", function(actor)
    return maximum_level(actor, "MATRIX_CRYSTAL_VITAKINESIS")
end)

stat("scale_vita_hurt_touch_min_dot", function(actor)
    return math.min((level(actor, "vita_hurt_touch") * 0.002 + 0.03) * power(actor), 0.1)
end)

stat("scale_vita_hurt_touch_min_duration", function(actor)
    return (level(actor, "vita_hurt_touch") * 2900 + 1800) * power(actor)
end)

stat("scale_vita_hurt_touch_max_duration", function(actor)
    return (level(actor, "vita_hurt_touch") * 7800 + 6100) * power(actor)
end)

stat("scale_vita_health_power_ally_min_duration", function(actor)
    return (level(actor, "vita_health_power_ally") * 2100 + 35400) * power(actor)
end)

stat("scale_vita_health_power_ally_max_duration", function(actor)
    return (level(actor, "vita_health_power_ally") * 29800 + 155000) * power(actor)
end)

stat("scale_vita_attack_touch_min_damage", function(actor)
    return (level(actor, "vita_attack_touch") * 2 + 12) * power(actor)
end)

stat("scale_vita_attack_touch_max_damage", function(actor)
    return (level(actor, "vita_attack_touch") * 4 + 35) * power(actor)
end)

stat("scale_vita_attack_touch_min_duration", function(actor)
    return (level(actor, "vita_attack_touch") * 50 + 400) * power(actor)
end)

stat("scale_vita_attack_touch_max_duration", function(actor)
    return (level(actor, "vita_attack_touch") * 150 + 800) * power(actor)
end)
