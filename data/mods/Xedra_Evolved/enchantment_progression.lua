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

return progression
