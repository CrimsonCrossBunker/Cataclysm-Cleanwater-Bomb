local ccb = require("ccb")

return {
    {
        spell = "pyrokinetic_eruption",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("pyrokinetic_intensify_flames") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could create flame ex nihilo, starting objects on fire or burning your enemies alive, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_cauterize",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("pyrokinetic_lance") >= 5
                or (level("pyrokinetic_eruption") >= 6
                and level("pyrokinetic_quell_flames") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could focus your heat and sear bleeding wounds shut, stopping bleeding instantly at the cost of a small amount of further damage, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_call_flames",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("pyrokinetic_eruption") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  With a bit of concentration you could keep a fire going through your powers alone, burning on air and providing a source of heat and light without needing fuel, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_quell_flames",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("pyrokinetic_call_flames") >= 5
                and level("pyrokinetic_intensify_flames") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Just as you can start fires, you could also stop them, harmlessly dispersing the heat and dissipating existing flames, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_cloak",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("pyrokinetic_call_flames") >= 6
                or level("pyrokinetic_eruption") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could heat the air around yourself to an even greater degree, maintaining comfort and a pleasant temperature in the depths of winter, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_flamethrower",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("pyrokinetic_call_flames") >= 7
                and level("pyrokinetic_flash") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than focusing on a point, you could spew a swath of flames, damaging a whole group of enemies, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_lance",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("pyrokinetic_eruption") >= 9
                and level("pyrokinetic_quell_flames") >= 6)
                or level("pyrokinetic_call_flames") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could focus your heat into a searing line, capable of welding or cutting through metal, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_thermogenesis",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("pyrokinetic_call_flames") >= 10
                or level("pyrokinetic_cloak") >= 6)
                and (level("pyrokinetic_flash") >= 7
                or level("pyrokinetic_intensify_flames") >= 8)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could heat the air itself, making an entire room warm, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_aura",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("pyrokinetic_thermogenesis") >= 5
                or level("pyrokinetic_flamethrower") >= 6)
                and level("pyrokinetic_cloak") >= 8
                and level("pyrokinetic_eruption") >= 7
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could heat the air around yourself burning hot, injuring anyone engaged in melee combat with you, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_flame_immunity",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("pyrokinetic_cloak") >= 10
                or level("pyrokinetic_aura") >= 6)
                and level("pyrokinetic_quell_flames") >= 9
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Your control over temperature is strong enough that you could keep yourself completely shielded from it, becoming totally immune to flame and heat, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_blast",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("pyrokinetic_flamethrower") >= 8
                or level("pyrokinetic_eruption") >= 13)
                and (level("pyrokinetic_thermogenesis") >= 6
                or level("pyrokinetic_aura") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  With enough focused heat you could unleash an explosion, catching multiple enemies in its wake, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_aoe_blast",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("pyrokinetic_flamethrower") >= 12
                or level("pyrokinetic_blast") >= 6)
                and (level("pyrokinetic_thermogenesis") >= 10
                or level("pyrokinetic_flame_immunity") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could build the heat up around yourself quickly enough to cause an expanding explosion and protect yourself from its effects, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "pyrokinetic_incineration",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("pyrokinetic_eruption") >= 14
                or level("pyrokinetic_flamethrower") >= 10)
                and level("pyrokinetic_blast") >= 10
                and level("pyrokinetic_aoe_blast") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  By focusing all of your power on a single point, you could raise the temperature there thousands of degrees, incinerating whatever you're focused on, if you can figure out the proper technique.")
        end,
    },
}
