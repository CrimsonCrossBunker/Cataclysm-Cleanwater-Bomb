local runtime = require("ccb").runtime
local progression = {}

local function count_traits(ctx, ids)
    local traits = ctx.character_inputs.traits
    local count = 0
    for _, id in ipairs(ids) do
        if traits[id] then
            count = count + 1
        end
    end
    return count
end

local post_threshold_bonus_traits = {
    "THRESH_ARVORE",
    "THRESH_IERDE",
    "THRESH_HOMULLUS",
    "THRESH_SALAMANDER",
    "THRESH_SYLPH",
    "THRESH_UNDINE",
}

function progression.post_threshold_bonus(ctx, value)
    return value + count_traits(ctx, post_threshold_bonus_traits)
end

local werewolf_tier_one_traits = {
    "WEREWOLF_SMELL_NEARBY_ENEMIES",
    "WEREWOLF_NO_SCENT",
    "WEREWOLF_ILLUMINATE_TARGET",
    "WEREWOLF_FRIEND_TO_ANIMALS",
    "WEREWOLF_SMASH_TERRAIN",
    "WEREWOLF_CLIMB_IN_WOLF_FORM",
}

function progression.werewolf_tier_one(ctx)
    return count_traits(ctx, werewolf_tier_one_traits)
end

local werewolf_tier_two_traits = {
    "WEREWOLF_SENSE_SPIRITS_AND_ALIENS",
    "WEREWOLF_STUN_MACHINE",
    "WEREWOLF_EXTRA_WEAKPOINT_HITS",
    "WEREWOLF_FAR_JUMP",
    "WEREWOLF_CAMOUFLAGE_COAT",
}

function progression.werewolf_tier_two(ctx)
    return count_traits(ctx, werewolf_tier_two_traits)
end

local werewolf_tier_three_traits = {
    "WEREWOLF_PARTIAL_SHIFT",
    "WEREWOLF_SILVER_CLAWS",
    "WEREWOLF_MANA_BONUS_AFTER_KILL",
    "WEREWOLF_STRENGTH_BONUS",
    "WEREWOLF_BATTLE_FURY",
}

function progression.werewolf_tier_three(ctx)
    return count_traits(ctx, werewolf_tier_three_traits)
end

local werewolf_tier_four_traits = {
    "WEREWOLF_SUPER_FAST_REGENERATION",
    "WEREWOLF_SUMMON_FOG",
    "WEREWOLF_MOON_ARMOR",
}

function progression.werewolf_tier_four(ctx)
    return count_traits(ctx, werewolf_tier_four_traits)
end

local werewolf_tier_five_traits = {
    "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
    "WEREWOLF_CLOSE_TEAR_IN_REALITY",
    "WEREWOLF_WALK_THROUGH_WALLS",
    "WEREWOLF_SUMMON_SHADOW_PACK",
}

function progression.werewolf_tier_five(ctx)
    return count_traits(ctx, werewolf_tier_five_traits)
end

local vampire_tier_three_traits = {
    "BLOODHASTE",
    "HYPNOTIC_GAZE",
    "MAGICFORBLOOD",
    "VAMPIRE_COMMAND_BEAST",
    "VAMPIRE_EARTH_SLUMBER",
    "VAMPIRE_CARDIO_BONUS",
    "VAMPIRE_MOTION_ALARM",
    "VAMPIRE_BONUS_HP",
    "VAMPIRE_STORE_MORE_BLOOD",
    "VAMPIRE_INSTANT_BLEED",
    "VAMPIRE_BIG_STOMACH",
    "VAMPIRE_DETECT_VAMPIRES",
    "DHAMPIR_REDUCED_PAIN",
    "DHAMPIR_MEND_WOUNDS_FASTER",
    "DHAMPIR_AVOID_EAT_SLEEP_DRINK",
}

function progression.vampire_tier_three(ctx)
    return count_traits(ctx, vampire_tier_three_traits)
end


local vampire_tier_one_traits = {
    "EYEGLEAM",
    "BLOOD_FUN",
    "STAMINAFORBLOOD",
    "COMMUNE_NIGHT",
    "VAMPIRIC_STRENGTH",
    "VAMPIRIC_RESILIENCE",
    "VAMPIRE_HEIGHTENED_SENSES",
    "VAMPIRE_HEALTH_BONUS",
    "VAMPIRE_SENSE_CHILDREN_OF_THE_NIGHT",
    "VAMPIRE_SILENT_MOVE",
    "DHAMPIR_REDUCED_COLD_TEMPS",
}

function progression.vampire_tier_one(ctx)
    return count_traits(ctx, vampire_tier_one_traits)
end

local vampire_tier_two_traits = {
    "BLOODHEAL",
    "COAGULANTWEAVE",
    "VAMPIRIC_DODGE",
    "VAMPIRE_FEAR_GAZE",
    "VAMPIRE_WALK_ON_WALLS",
    "VAMPIRE_BEAST_CLAWS",
    "VAMPIRIC_STEALTH_BONUS",
    "VAMPIRE_SEE_HEAT",
    "VAMPIRE_FEIGN_DEATH",
    "VAMPIRE_BLOOD_TEMPORARY_BOOST",
    "EYEGLEAM_UPGRADE",
    "VAMPIRE_SEE_THROUGH_NIGHT_EYES",
    "BLOOD_FUN_UPGRADE",
    "VAMPIRE_SILENT_MOVE_UPGRADE",
    "DHAMPIR_FANGS",
    "DHAMPIR_SLOWFALL",
    "DHAMPIR_RESIST_DISEASE_POISON_INFECTION",
    "DHAMPIR_BLACKEN_SOUL_ARION",
}

function progression.vampire_tier_two(ctx)
    return count_traits(ctx, vampire_tier_two_traits)
end

local vampire_tier_four_traits = {
    "TRUE_VAMPIRE_POWER",
    "VAMPIRE_TORPOR",
    "VAMPIRE_DOMINATE",
    "VAMPIRE_NO_BREATHE",
    "VAMPIRE_NO_ILLNESS",
    "VAMPIRE_BAT_FORM",
    "VAMPIRE_WOLF_FORM",
    "VAMPIRE_MIST_FORM",
    "VAMPIRE_STORE_MORE_BLOOD_UPGRADE",
    "VAMPIRE_INVISIBLE_IN_DARK",
    "VAMPIRE_NO_ILLNESS_UPGRADE",
    "VAMPIRE_FORM_UPGRADE",
    "VAMPIRE_BLOOD_FOR_POTENCY",
}

function progression.vampire_tier_four(ctx)
    return count_traits(ctx, vampire_tier_four_traits)
end

local vampire_tier_five_traits = {
    "VAMPIRE_MASTER_MORTAL_MIND",
    "VAMPIRE_DISTILLATE_INNER_BLOOD",
    "VAMPIRE_SHADOW_FORM",
    "VAMPIRE_LAST_BREATH_MIST",
    "VAMPIRE_IRON_MIND",
    "VAMPIRE_BLIND_THE_SUN",
    "VAMPIRE_HEAL_IN_DARK",
    "VAMPIRE_DRINK_VAMPIRE_BLOOD",
    "VAMPIRE_GAIN_BLOOD_GIFTS",
    "VAMPIRE_LAST_BREATH_MIST_UPGRADE",
    "VAMPIRE_MASTER_MORTAL_MIND_UPGRADE",
}

function progression.vampire_tier_five(ctx)
    return count_traits(ctx, vampire_tier_five_traits)
end

function progression.vampire_tier_one_with_potency(ctx)
    return progression.vampire_tier_one(ctx) + ctx.character_inputs.effect_intensities.effect_player_anathema_potency_boost
end

function progression.vampire_tier_four_with_potence(ctx)
    return progression.vampire_tier_four(ctx) + (ctx.character_inputs.traits.TRUE_VAMPIRE_POWER and 5 or 0)
end

function progression.vampire_tier_five_with_cauldron(ctx)
    return progression.vampire_tier_five(ctx) + (ctx.character_inputs.traits.VAMPIRE_BLOOD_FOR_POTENCY_REAL and 10 or 0)
end

function progression.chron_spell(ctx, level, multiplier, base)
    return ((level * multiplier) + base)
        * runtime.call_number("attribute_scaling", ctx.character_inputs.stats.intelligence)
end

local bloodthorn_traits = {
    "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT",
    "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT_WHIP",
    "BLOODTHORNE_DRUID_REGAIN_BLOOD",
    "BLOODTHORNE_DRUID_BONUS_MANA_REGEN",
    "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM",
    "BLOODTHORNE_DRUID_STOP_BLEEDING",
    "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE",
    "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES",
    "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD",
    "BLOODTHORNE_DRUID_SUMMON_THORNHOUND",
    "BLOODTHORNE_DRUID_SLOWER_BLEEDING",
    "BLOODTHORNE_DRUID_CREATE_THORN_PRISON",
}

function progression.bloodthorn_traits(ctx)
    return count_traits(ctx, bloodthorn_traits)
end

return progression
