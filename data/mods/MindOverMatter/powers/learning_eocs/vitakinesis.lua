local ccb = require("ccb")

return {
    {
        spell = "vita_concentrated_healing",
        tier = "tier_one",
        meets = function(level)
            return level("vita_health_power") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could reroute stem cells and blood flow to injured parts, speeding their healing at the expense of your uninjured areas, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_stop_bleeding",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("vita_slow_bleeding") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than merely slowing your bleeding, you could stop it, and clean the wound to encourage healing too, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_health_power_ally",
        recipe = "practice_vita_healing_touch",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("vita_health_power") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  The same way you encourage your own healing and good health, you could use physical contact to provide that same bonus to an ally, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_hurt_touch",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("vita_health_power_ally") >= 5
                and level("vita_slow_bleeding") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than speeding healing, you could slow it, causing damage and especially reducing the preternatural healing of some of the post-Cataclysm creatures out there, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_remove_poison",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("vita_health_power") >= 8
                and (level("vita_slow_bleeding") >= 7
                or level("vita_stop_bleeding") >= 3)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could remove poison from your body, carrying it your skin and sweating it out, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_cure_disease",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("vita_remove_poison") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Instead of carrying poison to your skin, you could carry antibodies and white blood cells to diseased parts of your body, speeding your recovery time, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_increased_hp",
        tier = "tier_two",
        chance = 40,
        allow_knacks_only = true,
        meets = function(level)
            return level("vita_health_power") >= 10
                and level("vita_concentrated_healing") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You can already increase your general level of health and focus your body's healing energies on particular locations.  You could probably increase your overall resilience, requiring much larger injuries to completely incapacitate you, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_sleeping_trance",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("vita_health_power") >= 8
                and level("vita_cure_disease") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could enter a trance, allowing your mind and body to restore themselves more efficiently than natural sleep, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_stop_infection",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("vita_cure_disease") >= 7
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could clean your wounds with an act of will, preventing infection or curing one before it leads to life-threatening problems, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_healing_trance",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("vita_stop_infection") >= 5
                and level("vita_concentrated_healing") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could sink into a trance, focusing all of your energy on healing and speed your recovery hundreds of times, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_attack_touch",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("vita_hurt_touch") >= 8
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than merely slowing your enemies' healing, you could directly damage their cells, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_blood_purge",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("vita_healing_trance") >= 6
                and (level("vita_remove_poison") >= 8
                or level("vita_stop_infection") >= 8)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could perform a full sweep of your bloodstream, purging all foreign contaminants, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_no_need_for_sleep",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("vita_sleeping_trance") >= 10
                and level("vita_healing_trance") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could put parts of your brain to sleep while leaving the rest of it awake, allowing you to remain conscious while sitting gaining the benefits of rest, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_banish_illness",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("vita_stop_infection") >= 12
                and (level("vita_concentrated_healing") >= 8
                or level("vita_cure_disease") >= 12)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could cure diseases directly, even long-term or chronic conditions, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_super_heal",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("vita_health_power") >= 14
                or level("vita_healing_trance") >= 9)
                and (level("vita_concentrated_healing") >= 10
                or level("vita_remove_poison") >= 7
                or level("vita_blood_purge") >= 5)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could speed your healing rate thousands of times, closing wounds in minutes, albeit at a great physical cost to your body, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_degenerating_touch",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("vita_hurt_touch") >= 16
                or level("vita_attack_touch") >= 8)
                and level("vita_banish_illness") >= 6
                and (level("vita_super_heal") >= 5
                or level("vita_cure_disease") >= 15)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could reverse your enemies' natural healing processes, causing cellular breakdown and necrosis to occur at an accelerated pace, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "vita_return_from_death",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("vita_super_heal") >= 6
                or (level("vita_banish_illness") >= 8
                and level("vita_healing_trance") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could prepare for grievous or potentially-fatal injury, kicking your healing into overdrive and preventing yourself from dying, if you can figure out the proper technique.")
        end,
    },
}
