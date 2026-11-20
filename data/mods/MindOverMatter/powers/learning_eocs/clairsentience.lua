local ccb = require("ccb")

return {
    {
        spell = "clair_danger_sense",
        tier = "tier_one",
        chance = 20,
        roll_before_counter = true,
        meets = function(level)
            return level("clair_better_senses") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could expand your senses into the esoteric, gaining a feel for nearby movement and the overall danger of a situation, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "clair_spot_weakness",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("clair_danger_sense") >= 4
                and level("clair_night_vision") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  The same way your eyes can pick out details in pure dark and you can sense hidden dangers, you could find the weaknesses of your enemies, knowing exactly where to strike them, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "clair_night_vision",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("clair_better_senses") >= 8
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could enhance your senses to such a degree that you could even \"see\" in the dark, even pitch blackness, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "clair_see_auras",
        recipe = "practice_clair_aura_sight",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("clair_better_senses") >= 5
                and level("clair_spot_weakness") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could turn your insight on people, looking beyond the surface toward their essential elements, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "clair_ranged_enhance",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("clair_spot_weakness") >= 7
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could greatly enhance your vision, making ranged combat much easier as you're able to pinpoint exactly where to shoot, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_examine_item",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("clair_see_auras") >= 6
                or (level("clair_speed_reading") >= 8
                or level("clair_danger_sense") >= 8)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could examine an item with preternatural senses, discovering information that would be impossible to figure out with any normal investigation, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_sense_hostile_creatures",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("clair_better_senses") >= 8
                and level("clair_danger_sense") >= 6
                and level("clair_aura_sight") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You have a general sense of possible dangers already, but you could refine it, you could focus and learn the exact location of those that seek to do you harm, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "clair_voyance",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("clair_danger_sense") >= 6
                and (level("clair_aura_sight") >= 6
                or level("clair_night_vision") >= 10)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You perform the classic feat of clairvoyance, throwing your senses to a spot nearby, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_dodge_power",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("clair_voyance") >= 6
                and (level("clair_danger_sense") >= 10
                or level("clair_sense_hostile_creatures") >= 10)
                and (level("clair_speed_reading") >= 10
                or level("clair_spot_weakness") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could predict your enemies' movements and attacks, smoothly avoiding danger by not being where they are about to strike, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_craft_bonus",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("clair_speed_reading") >= 8
                and level("clair_spot_weakness") >= 4
                and level("clair_danger_sense") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could use your insight into the near future to speed any manual tasks you do, working smoothly and efficiently to construct or assemble something, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_perfect_shot",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("clair_ranged_enhance") >= 9
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could predict the exact trajectory of a bullet, aiming for the perfect spot to do the most damage, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_see_map",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("clair_voyance") >= 8
                and (level("clair_danger_sense") >= 6
                or level("clair_aura_sight") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You expand your vision to the surrounding terrain, revealing nearby points of interest and where you should go, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_clear_sight",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("clair_night_vision") >= 10
                and (level("clair_speed_reading") >= 8
                or level("clair_dodge_power") >= 5
                or level("clair_aura_sight") >= 8)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could enhance your senses so much that nothing could cloud them for as long as you maintain your concentration, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_astral_projection",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("clair_clear_sight") >= 6
                and level("clair_voyance") >= 9)
                or (level("clair_see_map") >= 8
                and level("clair_voyance") >= 9)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could cast your spirit free from your body, wandering as a ghost and spying out your surroundings, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_group_tactics",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("clair_ranged_enhance") >= 7
                and level("clair_dodge_power") >= 8
                and level("clair_clear_sight") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could use your prescience to help direct the flow of battle, calling out orders so your allies can react to dangers before they happen, if you can figure out the technique.")
        end,
    },
    {
        spell = "clair_omniscience",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("clair_clear_sight") >= 5
                and (level("clair_see_map") >= 8
                or level("clair_voyance") >= 14)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could expand your senses to a huge area, seeing every most of dust, every blade of grass, every speck or spot, all simultaneously, if you can figure out the technique.")
        end,
    },
}
