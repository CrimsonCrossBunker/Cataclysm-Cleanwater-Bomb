local ccb = require("ccb")

return {
    {
        spell = "electrokinetic_zap_enemies",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("electrokinetic_shock_touch") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could use your powers to charge your skin with electricity, shocking and damaging anyone who strikes you, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "electrokinetic_melee_attacks",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("electrokinetic_shock_touch") >= 5
                and level("electrokinetic_zap_enemies") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could channel electricity through your arms while you attack, adding a shock to the blow, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "electrokinetic_personal_battery",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("electrokinetic_see_electric") >= 5
                and level("electrokinetic_zap_enemies") >= 8
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could extend a galvanic charge outward from your skin, charging any compatible devices you're carrying with you, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_paralysis",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("electrokinetic_see_electric") >= 6
                and (level("electrokinetic_melee_attacks") >= 5
                or level("electrokinetic_shock_touch") >= 8)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could overload an organic target's nervous system, causing seizures and incapacitating them for a brief period, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_reduce_pain",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("electrokinetic_paralysis") >= 4
                or (level("electrokinetic_see_electric") >= 8
                and level("electrokinetic_zap_enemies") >= 8)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could use your control over nervous systems to reduce the pain you feel and recover from it faster, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_hacking_interface",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("electrokinetic_see_electric") >= 4
                and level("electrokinetic_shock_touch") >= 4
                and level("electrokinetic_personal_battery") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could create an electrical interface to hack nearby devices, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_lightning_bolt",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("electrokinetic_shock_touch") >= 12
                or level("electrokinetic_melee_attacks") >= 8)
                and level("electrokinetic_zap_enemies") >= 8
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could extend your electrical discharges, unleashing blasts of lightning at your enemies, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_recharge_vehicle",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("electrokinetic_zap_enemies") >= 9
                or level("electrokinetic_paralysis") >= 7)
                and level("electrokinetic_personal_battery") >= 10
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could charge vehicle or residential batteries instead of just the small ones in portable devices, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_pain_immune",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("electrokinetic_reduce_pain") >= 9
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could block the pain signals in your body entirely for a short time, letting you fight on through hideous wounds, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_speed_boost",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("electrokinetic_personal_battery") >= 11
                or level("electrokinetic_paralysis") >= 6)
                and (level("electrokinetic_zap_enemies") >= 8
                or level("electrokinetic_see_electric") >= 5)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could enhance your reflexes and synaptic reaction time, both moving and thinking faster, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_robot_interface",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("electrokinetic_see_electric") >= 12
                and level("electrokinetic_hacking_interface") >= 8
                and level("electrokinetic_kill_robot") >= 8
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could directly manipulate a nearby robot's circuitry, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_kill_robot",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("electrokinetic_recharge_vehicle") >= 8
                or level("electrokinetic_lightning_bolt") >= 8
                or level("electrokinetic_melee_attacks") >= 13)
                and level("electrokinetic_see_electric") >= 8
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  With a single overwhelming power surge, you could overload and destroy a robotic or cybernetic enemy, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_lightning_aura",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("electrokinetic_zap_enemies") >= 12
                and (level("electrokinetic_personal_battery") >= 15
                or level("electrokinetic_recharge_vehicle") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could charge the air around you with so much electricity that lightning would lash out at anyone around you, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_lightning_blast",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("electrokinetic_kill_robot") >= 6
                or level("electrokinetic_lightning_bolt") >= 10)
                and (level("electrokinetic_melee_attacks") >= 8
                or level("electrokinetic_shock_touch") >= 12)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Not only could you hurl a bolt of lightning, but an actual thunderbolt that causes an explosion at the point of impact, if you can figure out the technique.")
        end,
    },
    {
        spell = "electrokinetic_revive",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("electrokinetic_speed_boost") >= 8
                and (level("electrokinetic_reduce_pain") >= 13
                or level("electrokinetic_pain_immune") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could charge a corpse's nervous system, manipulating the signals and forcing dead flesh to move and fight for you, if you can figure out the technique.")
        end,
    },
}
