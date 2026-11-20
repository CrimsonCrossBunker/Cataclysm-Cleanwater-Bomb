local ccb = require("ccb")

return {
    {
        spell = "biokin_breathe_skin",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("biokin_physical_enhance") >= 4
                and level("biokin_overcome_pain") >= 3
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could use your powers to make your skin selectively permeable to oxygen, allowing you to breathe underwater, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "biokin_flexibility",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("biokin_physical_enhance") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could twist your joints and relax your muscles far beyond the capability of a baseline human, allowing you to escape shackles and adeptly dodge blows for a brief period, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "biokin_dash",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return (level("biokin_enhance_mobility") >= 6
                or level("biokin_physical_enhance") >= 5)
                and (level("biokin_reflex_enhance") >= 5
                or level("biokin_adrenaline") >= 8)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could supercharge your muscles to move incredibly quickly for brief periods, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_armor_skin",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("biokin_physical_enhance") >= 8
                or level("biokin_overcome_pain") >= 6)
                and (level("biokin_flexibility") >= 7
                or level("biokin_climate_control") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could harden your skin to protect yourself from damage, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_climate_control",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("biokin_physical_enhance") >= 9
                or level("biokin_metabolism_enhance") >= 6)
                and level("biokin_overcome_pain") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could adapt your physiology to be comfortable in hotter or colder temperatures, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_adrenaline",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("biokin_dash") >= 8
                or level("biokin_enhance_mobility") >= 6)
                and level("biokin_breathe_skin") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could control your adrenaline, unleashing a surge of it on command when you need it, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_enhance_mobility",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("biokin_dash") >= 10
                or level("biokin_combat_dance") >= 4
                or level("biokin_physical_enhance") >= 10)
                and (level("biokin_reflex_enhance") >= 6
                or level("biokin_flexibility") >= 9)
                and level("biokin_overcome_pain") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could enhance your skin tension and joint flexibility to make your gear much less encumbering, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_hammerhand",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("biokin_physical_enhance") >= 6
                and level("biokin_armor_skin") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could replicate simple tools with your body, applying enough torque to turn bolts with your fingers or enough force to hammer a nail with your thumb, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_reflex_enhance",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("biokin_physical_enhance") >= 6
                and level("biokin_adrenaline") >= 8
                and (level("biokin_dash") >= 8
                or level("biokin_flexibility") >= 8)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could enhance your sensory acuity and reaction time, spotting threats from further away and moving more quickly to counter them, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_sealed_system",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("biokin_breathe_skin") >= 9
                or level("biokin_armor_skin") >= 9)
                and (level("biokin_hammerhand") >= 7
                or level("biokin_climate_control") >= 10)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  With an enormously deep breath and an alteration to your skin, you could protect yourself from harmful gases, electricity, radiation, and other deleterious conditions, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_metabolism_enhance",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("biokin_climate_control") >= 8
                and (level("biokin_adrenaline") >= 6
                or level("biokin_physical_enhance") >= 12)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could enhance your metabolism to a preternatural degree, eating only once a day and sleeping every two to three days, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_vitaminosis",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("biokin_metabolism_enhance") >= 8
                and level("biokin_adrenaline") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You can refine specific elements of your metabolism with an incredible amount of focus, allowing you to directly convert your stored calories into vitamins.")
        end,
    },
    {
        spell = "biokin_combat_dance",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("biokin_physical_enhance") >= 10
                and level("biokin_reflex_enhance") >= 10
                and (level("biokin_dash") >= 6
                or level("biokin_adrenaline") >= 9)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Combining enhancements to speed, strength, reaction time, agility, and coordination, you could enter a battle trance like the legendary berserkergang, but with full control over your mind, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_perfected_motion",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("biokin_combat_dance") >= 6
                and level("biokin_dash") >= 12
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could maintain a speed boost for an extended period of time, traveling a dozen meters in the blink of an eye, and avoiding any difficult terrain while doing so, if you can figure out the technique.")
        end,
    },
    {
        spell = "biokin_hurricane_blows",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("biokin_combat_dance") >= 10
                and (level("biokin_reflex_enhance") >= 14
                or level("biokin_adrenaline") >= 12)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could maintain a speed boost for an extended period of time, traveling a dozen meters in the blink of an eye, and avoiding any difficult terrain while doing so, if you can figure out the technique.")
        end,
    },
}
