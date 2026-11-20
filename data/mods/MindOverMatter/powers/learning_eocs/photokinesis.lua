local ccb = require("ccb")

return {
    {
        spell = "photokinetic_light_up_enemy",
        tier = "tier_one",
        chance = 20,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Creating light in a single place is easy, but you could outline another being in light, marking their location and making it harder for them to avoid attack, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "photokinetic_snuff_light",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("photokinetic_light_local") >= 5
                or level("photokinetic_create_light") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Just like you can create light, you could extinguish it, plunging an area into darkness, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "photokinetic_light_dodge",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("photokinetic_snuff_light") >= 5
                and level("photokinetic_create_light") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Instead of simply creating light you could bend it, warping it around yourself and making it hard for enemies to determine your exact position, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "photokinetic_light_beam",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("photokinetic_light_local") >= 8
                or level("photokinetic_create_light") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could focus the light you create, making it a searing beam capable of burning your enemies, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "photokinetic_camouflage",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("photokinetic_light_dodge") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could bend the light not only around yourself, but around your nearby surroundings, blending them together and making yourself very difficult to spot from a distance, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "photokinetic_rad_immunity",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("photokinetic_light_dodge") >= 9
                or (level("photokinetic_snuff_light") >= 6
                and level("photokinetic_camouflage") >= 5)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Bending light leads to deflecting it, and you could deflect harmful light and radiation away from yourself, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "photokinetic_light_arms",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("photokinetic_light_dodge") >= 8
                and level("photokinetic_camouflage") >= 6
                and level("photokinetic_light_local") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could create illusions of your arms and weapons, making it much harder for your enemies to know where you are going to strike, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_hide_ugly",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("photokinetic_camouflage") >= 8
                and level("photokinetic_rad_immunity") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  With a full-body wreathe of illusion, you could conceal your form, preventing anyone from reacting poorly to part of your appearance that isn't normal, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_flash_bang",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("photokinetic_create_light") >= 9
                or level("photokinetic_light_beam") >= 5)
                and level("photokinetic_light_up_enemy") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could create a large amount of light and allow it to burst out all at once, creating something similar to a flashbang effect, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_light_image",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("photokinetic_light_beam") >= 6
                and (level("photokinetic_camouflage") >= 6
                or level("photokinetic_light_arms") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could create an illusion of yourself, or even multiple illusions, confusion your enemies as to where you even are, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_radio",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("photokinetic_rad_immunity") >= 6
                and (level("photokinetic_create_light") >= 8
                or level("photokinetic_light_beam") >= 7)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could read and broadcast radio waves, communicating with anyone else who is left out there, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_sterilize_food",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("photokinetic_rad_immunity") >= 7
                and level("photokinetic_camouflage") >= 4
                and (level("photokinetic_light_flash") >= 3
                or level("photokinetic_light_up_enemy") >= 9
                or level("photokinetic_light_beam") >= 5)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  With a focused burst of radiation, you could sterilize food, making it last much longer without going rotten, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_stun_robots",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("photokinetic_light_flash") >= 5
                or (level("photokinetic_radio") >= 6
                and level("photokinetic_light_beam") >= 4)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Electronics are vulnerable to electromagnetic waves, and light is an electromagnetic wave.  While you couldn't destroy electronics, you can overload them and cause them to fail for a brief time.")
        end,
    },
    {
        spell = "photokinetic_invisibility",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("photokinetic_rad_immunity") >= 6
                or level("photokinetic_light_image") >= 6)
                and (level("photokinetic_camouflage") >= 10
                or level("photokinetic_hide_ugly") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could bend light completely around yourself, concealing your existence entirely, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_light_flash",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("photokinetic_light_beam") >= 8
                and (level("photokinetic_rad_immunity") >= 6
                or level("photokinetic_light_arms") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could expand the usage of focused light, creating a wide beam capable of searing entire groups of enemies, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_blinding_glare",
        recipe = "practice_photokinetic_light_blinding_glare",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("photokinetic_create_light") >= 12
                or level("photokinetic_flash_bang") >= 7)
                and (level("photokinetic_light_flash") >= 6
                or level("photokinetic_rad_immunity") >= 10)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Enhancing your generation of light to an extreme level, you could glow brighter than a floodlight and blind anyone who attempts to attack you, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_light_disintegrate",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("photokinetic_blinding_glare") >= 5
                and (level("photokinetic_light_flash") >= 8
                or level("photokinetic_light_beam") >= 14)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could pour so much energy into a target that their body begins to disintegrate, doing immense damage, if you can figure out the technique.")
        end,
    },
    {
        spell = "photokinetic_light_army",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("photokinetic_light_image") >= 10
                and (level("photokinetic_create_light") >= 14
                or level("photokinetic_light_arms") >= 10
                or level("photokinetic_blinding_glare") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could summon multiple duplicates, dozens, even more, a veritable legion of holographic clones to allow you confuse and dazzle your enemies, if you can figure out the technique.")
        end,
    },
}
