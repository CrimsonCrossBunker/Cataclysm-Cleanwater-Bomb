local ccb = require("ccb")

return {
    {
        spell = "teleport_phase",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("teleport_blink") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could control your teleporting, traveling short distances without crossing the intervening space, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "teleport_warped_strikes",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("teleport_item_apport") >= 6
                and level("teleport_stride") >= 10
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You can maintain an easily modifiable section of warped space around you, which you can warp to allow your attacks to reach much further than they should.")
        end,
    },
    {
        spell = "teleport_ephemeral_walk",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("teleport_phase") >= 10
                and level("teleport_stride") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You can maintain a slight offset from normal space, allowing yourself to effortlessly phase through obstacles while still being able to interact with reality, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "teleport_item_apport",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("teleport_blink") >= 4
                and level("teleport_slow") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than traveling to a new location yourself, you could send an item you were holding there, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "teleport_stride",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("teleport_phase") >= 4
                and level("teleport_slow") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than expanding space, you could collapse it, making each of your steps cover a larger area of ground despite not moving any more quickly, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "teleport_transpose",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("teleport_displacement") >= 5
                and level("teleport_stride") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could combine moving yourself and moving a target to swap places, moving them to your previous location while you take their place, if you can figure out the technique.")
        end,
    },
    {
        spell = "teleport_displacement",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("teleport_item_apport") >= 5
                and level("teleport_slow") >= 10
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could teleport only your target, sending them somewhere nearby away from you, if you can figure out the technique.")
        end,
    },
    {
        spell = "teleport_reactive_displacement",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("teleport_displacement") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could automatically teleport away attacking enemies, if you can figure out the technique.")
        end,
    },
    {
        spell = "teleport_collapse",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("teleport_slow") >= 10
                or level("teleport_transpose") >= 6)
                and level("teleport_stride") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could warp space to such a degree that you could redirect your targets' movement, forcing them to travel toward a central point regardless of their intent, if you can figure out the technique.")
        end,
    },
    {
        spell = "teleport_farstep",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("teleport_stride") >= 8
                or level("teleport_collapse") >= 6)
                and level("teleport_phase") >= 10
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could travel much further distances, crossing dozens of meters in moments, if you can figure out the technique.")
        end,
    },
    {
        spell = "teleport_banish",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("teleport_farstep") >= 6
                or level("teleport_collapse") >= 8
                or level("teleport_transpose") >= 8)
                and level("teleport_displacement") >= 10
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could send your target somewhere *else*, some other place far from you in the endless parade of realities, if you can figure out the technique.")
        end,
    },
    {
        spell = "teleport_loci_establishment",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("teleport_stride") >= 6
                and level("teleport_farstep") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could concentrate on a specific location and teleport there at will.")
        end,
    },
    {
        spell = "teleport_gateway",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("teleport_loci_establishment") >= 6
                and level("teleport_farstep") >= 10
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Once you properly study a location so you're familiar enough with it, you could return there in moments even if you're fifty miles away, if you can figure out the technique.")
        end,
    },
    {
        spell = "teleport_dilated_gateway",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("teleport_gateway") >= 8
                and level("teleport_banish") >= 2
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Just as you can teleport yourself to memorized locations, you can also teleport other beings to those same locations alongside you.")
        end,
    },
    {
        spell = "teleport_relocation",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("teleport_gateway") >= 8
                and level("teleport_item_apport") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Just as you can teleport yourself to memorized locations, you can also teleport held items to those same locations.")
        end,
    },
    {
        spell = "teleport_summon",
        recipe = "practice_teleport_breach",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("teleport_displacement") >= 12
                or level("teleport_banish") >= 7)
                and level("teleport_gateway") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Just as you can send a target away from you, you could open up a portal to the Nether and allow some of its denizens to come through to Earth, if you can figure out the technique.")
        end,
    },
    {
        spell = "teleport_reality_tear",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("teleport_summon") >= 10
                and level("teleport_gateway") >= 10
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You are able to open a permanent tear in reality to the Nether, allowing all manners of creatures to pass through to Earth.")
        end,
    },
}
