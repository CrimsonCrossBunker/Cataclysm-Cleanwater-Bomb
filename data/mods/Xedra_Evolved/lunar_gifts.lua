local ccb = require("ccb")

return {
    {
        label = function() return ccb.services.translate("Gifts of the Moon: Level One") end,
        description = function() return ccb.services.translate("Choose a level one Gift of the Moon.  This gift will take at least one hour to learn.") end,
        gifts = {
            {
                trait = "WEREWOLF_SMELL_NEARBY_ENEMIES",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_SMELL_NEARBY_ENEMIES>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_SMELL_NEARBY_ENEMIES>\n<trait_description:WEREWOLF_SMELL_NEARBY_ENEMIES>") end,
            },
            {
                trait = "WEREWOLF_NO_SCENT",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_NO_SCENT>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_NO_SCENT>\n<trait_description:WEREWOLF_NO_SCENT>") end,
            },
            {
                trait = "WEREWOLF_ILLUMINATE_TARGET",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_ILLUMINATE_TARGET>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_ILLUMINATE_TARGET>\n<trait_description:WEREWOLF_ILLUMINATE_TARGET>") end,
            },
            {
                trait = "WEREWOLF_FRIEND_TO_ANIMALS",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_FRIEND_TO_ANIMALS>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_FRIEND_TO_ANIMALS>\n<trait_description:WEREWOLF_FRIEND_TO_ANIMALS>") end,
            },
            {
                trait = "WEREWOLF_SMASH_TERRAIN",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_SMASH_TERRAIN>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_SMASH_TERRAIN>\n<trait_description:WEREWOLF_SMASH_TERRAIN>") end,
            },
            {
                trait = "WEREWOLF_CLIMB_IN_WOLF_FORM",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_CLIMB_IN_WOLF_FORM>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_CLIMB_IN_WOLF_FORM>\n<trait_description:WEREWOLF_CLIMB_IN_WOLF_FORM>") end,
            },
        },
    },
    {
        label = function() return ccb.services.translate("Gifts of the Moon: Level Two") end,
        description = function() return ccb.services.translate("Choose a level two Gift of the Moon.  This gift will take at least two hours to learn") end,
        threshold = 700,
        gifts = {
            {
                trait = "WEREWOLF_SENSE_SPIRITS_AND_ALIENS",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_SENSE_SPIRITS_AND_ALIENS>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_SENSE_SPIRITS_AND_ALIENS>\n<trait_description:WEREWOLF_SENSE_SPIRITS_AND_ALIENS>") end,
            },
            {
                trait = "WEREWOLF_STUN_MACHINE",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_STUN_MACHINE>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_STUN_MACHINE>\n<trait_description:WEREWOLF_STUN_MACHINE>") end,
            },
            {
                trait = "WEREWOLF_EXTRA_WEAKPOINT_HITS",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_EXTRA_WEAKPOINT_HITS>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_EXTRA_WEAKPOINT_HITS>\n<trait_description:WEREWOLF_EXTRA_WEAKPOINT_HITS>") end,
            },
            {
                trait = "WEREWOLF_FAR_JUMP",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_FAR_JUMP>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_FAR_JUMP>\n<trait_description:WEREWOLF_FAR_JUMP>") end,
            },
            {
                trait = "WEREWOLF_CAMOUFLAGE_COAT",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_CAMOUFLAGE_COAT>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_CAMOUFLAGE_COAT>\n<trait_description:WEREWOLF_CAMOUFLAGE_COAT>") end,
            },
        },
    },
    {
        label = function() return ccb.services.translate("Gifts of the Moon: Level Three") end,
        description = function() return ccb.services.translate("Choose a level thee Gift of the Moon.  This gift will take at least three hours to learn") end,
        threshold = 2000,
        gifts = {
            {
                trait = "WEREWOLF_SILVER_CLAWS",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_SILVER_CLAWS>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_SILVER_CLAWS>\n<trait_description:WEREWOLF_SILVER_CLAWS>") end,
            },
            {
                trait = "WEREWOLF_MANA_BONUS_AFTER_KILL",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_MANA_BONUS_AFTER_KILL>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_MANA_BONUS_AFTER_KILL>\n<trait_description:WEREWOLF_MANA_BONUS_AFTER_KILL>") end,
            },
            {
                trait = "WEREWOLF_STRENGTH_BONUS",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_STRENGTH_BONUS>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_STRENGTH_BONUS>\n<trait_description:WEREWOLF_STRENGTH_BONUS>") end,
            },
            {
                trait = "WEREWOLF_BATTLE_FURY",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_BATTLE_FURY>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_BATTLE_FURY>\n<trait_description:WEREWOLF_BATTLE_FURY>") end,
            },
            {
                trait = "WEREWOLF_CURE_OUTSIDE_EFFECTS",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_CURE_OUTSIDE_EFFECTS>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_CURE_OUTSIDE_EFFECTS>\n<trait_description:WEREWOLF_CURE_OUTSIDE_EFFECTS>") end,
            },
        },
    },
    {
        label = function() return ccb.services.translate("Gifts of the Moon: Level Four") end,
        description = function() return ccb.services.translate("Choose a level four Gift of the Moon.  This gift will take at least four hours to learn") end,
        threshold = 4500,
        gifts = {
            {
                trait = "WEREWOLF_SUPER_FAST_REGENERATION",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_SUPER_FAST_REGENERATION>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_SUPER_FAST_REGENERATION>\n<trait_description:WEREWOLF_SUPER_FAST_REGENERATION>") end,
            },
            {
                trait = "WEREWOLF_SUMMON_FOG",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_SUMMON_FOG>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_SUMMON_FOG>\n<trait_description:WEREWOLF_SUMMON_FOG>") end,
            },
            {
                trait = "WEREWOLF_MOON_ARMOR",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_MOON_ARMOR>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_MOON_ARMOR>\n<trait_description:WEREWOLF_MOON_ARMOR>") end,
            },
        },
    },
    {
        label = function() return ccb.services.translate("Gifts of the Moon: Level Five") end,
        description = function() return ccb.services.translate("Choose a level five Gift of the Moon.  This gift will take at least five hours to learn") end,
        threshold = 8000,
        gifts = {
            {
                trait = "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM>\n<trait_description:WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM>") end,
            },
            {
                trait = "WEREWOLF_CLOSE_TEAR_IN_REALITY",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_CLOSE_TEAR_IN_REALITY>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_CLOSE_TEAR_IN_REALITY>\n<trait_description:WEREWOLF_CLOSE_TEAR_IN_REALITY>") end,
            },
            {
                trait = "WEREWOLF_WALK_THROUGH_WALLS",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_WALK_THROUGH_WALLS>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_WALK_THROUGH_WALLS>\n<trait_description:WEREWOLF_WALK_THROUGH_WALLS>") end,
            },
            {
                trait = "WEREWOLF_SUMMON_SHADOW_PACK",
                label = function() return ccb.services.translate("Learn <trait_name:WEREWOLF_SUMMON_SHADOW_PACK>") end,
                description = function() return ccb.services.translate("<trait_name:WEREWOLF_SUMMON_SHADOW_PACK>\n<trait_description:WEREWOLF_SUMMON_SHADOW_PACK>") end,
            },
        },
    },
}
