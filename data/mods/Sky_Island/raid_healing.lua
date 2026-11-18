local ccb = require("ccb")
local services = ccb.services
local state = require("raid_state")
local id = services.types.id
local M = {}

local cleared_effects = {
    "irradiated",
    "corroding",
    "onfire",
    "dazed",
    "stunned",
    "venom_blind",
    "formication",
    "blisters",
    "frostbite",
    "frostbite_recovery",
    "wet",
    "slimed",
    "migo_atmosphere",
    "fetid_goop",
    "sap",
    "nausea",
    "bleed",
    "fungus",
    "dermatik",
    "bloodworms",
    "paincysts",
    "brainworms",
    "tapeworm",
    "blind",
    "poison",
    "venom_dmg",
    "venom_weaken",
    "stung",
    "badpoison",
    "foodpoison",
    "paralyzepoison",
    "tetanus",
    "rat_bite_fever",
    "infected",
    "asthma",
    "common_cold",
    "flu",
    "pre_flu",
    "pre_common_cold",
    "VITRIFYING",
    "tpollen",
}
local mind_effects = {
    "psi_nether_attention",
    "effect_nether_attunement_raiser",
    "effect_nether_attunement_attenuation",
    "effect_nether_attunement_feedback",
    "psi_blind",
    "psi_dazed",
    "psi_deaf",
    "effect_photokinetic_illuminate_enemy",
    "effect_photokinetic_illumination",
    "effect_riftwalker_teleport",
    "effect_teleporting_lock",
    "effect_vitakinetic_health_down",
    "effect_vitakinetic_healing_down",
    "effect_vitakinetic_healing_down_super",
    "psi_vitakinetic_degeneration",
    "psionic_overload",
    "effect_psi_null_unbound",
    "effect_biokin_overload",
    "blind_clair_overload",
    "deaf_clair_overload",
    "effect_electrokin_overload",
    "effect_photokin_lumination_overload",
    "effect_photokin_myopia_overload",
    "blind_photokin_overload",
    "effect_pyrokin_overload",
    "effect_pyrokin_fever_burning",
    "effect_portal_storm_teleport",
    "effect_teleporter_overload",
    "effect_psi_teleport_lock",
    "effect_telekin_overload",
    "effect_vitakin_overload",
}
local xedra_effects = {
    "blood_spiders",
    "visuals",
    "effect_dread_weight",
    "poisoned_blood",
    "poisoned_blood2",
    "effect_broke_fae_ban",
    "effect_evil_eye",
    "xe_hydrating_gout_incubation",
    "xe_hydrating_gout",
}

local function remove_effects(character, names)
    for _, name in ipairs(names) do
        state.checked(services.effects.remove(character, id("effect", name)))
    end
end

local function vitamin(character, name)
    return state.checked(services.needs.get_vitamin(character, id("vitamin", name)))
end

local function set_vitamin(character, name, amount)
    state.checked(services.needs.set_vitamin(character, id("vitamin", name), amount))
end

local function mod_health(character)
    if services.gameplay.mods.is_loaded("magiclysm") then
        state.add_effect(character, "effect_disjunction", 2)
    end
    if services.gameplay.mods.is_loaded("mindovermatter") then
        set_vitamin(character, "vitamin_psionic_drain", 0)
        remove_effects(character, mind_effects)
    end
    if services.gameplay.mods.is_loaded("xedra_evolved") then
        if state.has_trait(character, "LILIN_TRAITS") and vitamin(character, "lilin_ruach_vitamin") == 0 then
            set_vitamin(character, "lilin_ruach_vitamin", 720)
            state.add_effect(character, "effect_si_lilin_no_ruach_upgrades", 259200)
        end
        if state.has_trait(character, "VAMPIRE") then
            local blood = 200
            for _, trait in ipairs { "VAMPIRE2", "VAMPIRE3", "VAMPIRE4", "BLOOD_DRINKER" } do
                if state.has_trait(character, trait) then blood = blood + 200 end
            end
            if vitamin(character, "human_blood_vitamin") <= blood then
                set_vitamin(character, "human_blood_vitamin", blood)
            end
        end
        remove_effects(character, xedra_effects)
    end
end

function M.extras(character)
    local calories = state.checked(services.needs.get(character)).stored_kcal
    state.checked(services.needs.modify_calories(character, math.max(calories, 9000) - calories, false))
    local thirst = state.checked(services.needs.get(character)).thirst
    state.checked(services.needs.set(character, { thirst = math.min(thirst, 800) }))
    for _, name in ipairs { "redcells", "bad_food", "blood", "instability" } do
        set_vitamin(character, name, 0)
    end
    local pain = state.checked(services.creatures.snapshot(character)).pain
    state.checked(services.needs.modify_raw_pain(character, -pain))
    state.checked(services.needs.set(character, { radiation = 0, painkiller = 0 }))
    local oxygen = state.checked(services.needs.get(character)).oxygen_max
    state.checked(services.needs.set(character, { oxygen = oxygen }))
    local stamina = state.checked(services.needs.get(character)).stamina_max
    state.checked(services.needs.set(character, { stamina = stamina }))
    state.add_effect(character, "panacea", 30, 1)
    remove_effects(character, cleared_effects)
    state.checked(services.world.reschedule_events("vitrified_farm_escape_key", services.time.duration(0, "turn")))
    mod_health(character)
end

function M.death(character)
    state.checked(services.characters.set_hp_group(character, "ALL", 999))
    state.checked(services.characters.set_hp_group(character, "ALL_MAJOR", 15))
    M.extras(character)
end

function M.full(character)
    if state.has_trait(character, "awayfromhome") then
        state.message(character, ccb.services.translate("The effect is wasted and you don't feel any better.  You have to be in your sanctuary to be healed by this!"))
        return
    end
    state.message(character, ccb.services.translate("Your body mends itself in the blink of an eye.  Underlying health issues may persist, but your structural integrity is restored."))
    state.checked(services.characters.set_hp_group(character, "ALL", 999))
    M.extras(character)
end

function M.at_heart(character)
    if state.number("islandrank") == 0 then
        M.full(character)
        state.message(character, ccb.services.translate("The island's grace heals you at no charge.\nThis effect will only be free until you have survived 10 expeditions."), "neutral", true)
    elseif state.checked(services.inventory.has_items(character, id("item", "warptoken"), 4, 0)) then
        state.message(character, ccb.services.translate("The warp shards you were holding dissipate into a mist and swirl in tiny vortices around your body.  The price is paid, and you are healed."), "neutral", true)
        M.full(character)
        state.checked(services.inventory.consume_by_type(character, id("item", "warptoken"), 4, 0))
    else
        state.message(character, ccb.services.translate("You must have the required payment on your person to be healed."), "neutral", true)
    end
end

return M
