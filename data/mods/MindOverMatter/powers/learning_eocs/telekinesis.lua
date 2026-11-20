local ccb = require("ccb")

return {
    {
        spell = "telekinetic_noise",
        tier = "tier_one",
        chance = 3,
        roll_before_counter = true,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could use a quick burst of telekinetic force to create noise, luring enemies away from you or toward a trapped location, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_slam_down",
        fixed_hours = { 12, 24 },
        chance = 20,
        meets = function(level)
            return level("telekinetic_push") >= 4
                or level("telekinetic_noise") >= 1
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Instead of just shoving someone away from your location, you could direct the force orthogonally to knock someone to the ground, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_momentum",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("telekinetic_push") >= 5
                and level("telekinetic_pull") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Instead of just applying all of your force at once, you could apply it gradually to all movement around you, making yourself slightly faster and anything dangerous slightly slower, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_slowfall",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("telekinetic_momentum") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could lift yourself just a little, slowing you any time you take a fall and making swimming much easier, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_wave",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("telekinetic_push") >= 7
                and level("telekinetic_slam_down") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could release force in all directions, knocking back everyone surrounding you all at once, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_water_walk",
        recipe = "practice_telekinetic_water_walking",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("telekinetic_slowfall") >= 6
                and level("telekinetic_momentum") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could counteract gravity, not enough to fly, but enough to allow surface tension to hold you up so you could walk on water, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_lifting_field",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("telekinetic_vehicle_lift") >= 3
                or (level("telekinetic_pull") >= 7
                and level("telekinetic_momentum") >= 5)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could hold a single object in place, carrying it next to you without using your hands, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_strength",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("telekinetic_pull") >= 6
                or level("telekinetic_push") >= 6)
                and level("telekinetic_momentum") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could enhance your own strength, allowing you to pull much heavier objects or smash through study doors and walls, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_hammer",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("telekinetic_wave") >= 4
                or level("telekinetic_push") >= 8)
                and level("telekinetic_slam_down") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could concentrate your application of force into a blunt instrument, shattering bones and splintering furniture, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_vehicle_lift",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("telekinetic_pull") >= 8
                and level("telekinetic_slowfall") >= 8)
                or level("telekinetic_strength") >= 10
                or level(" telekinetic_lifting_field") >= 12
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than smashing objects with your telekinetic strength, you could apply it to lifting a car, allowing you to work on the undercarriage without a jack, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_shield",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("telekinetic_wave") >= 8
                and level("telekinetic_momentum") >= 10
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could create a barrier of force around yourself, shielding you from harm, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_explosion",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("telekinetic_slam_down") >= 12
                or level("telekinetic_hammer") >= 7)
                and (level("telekinetic_push") >= 10
                or level("telekinetic_pull") >= 10)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than striking a single point, you could create an explosion of telekinetic force, damaging an entire area, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_levitation",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("telekinetic_push") >= 12
                or level("telekinetic_water_walk") >= 8)
                and level("telekinetic_slowfall") >= 9
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than simply slowing your fall, you could stop it, completely defying gravity and walking on air, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_move_large_weight",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("telekinetic_push") >= 15
                or level("telekinetic_pull") >= 15)
                and (level("telekinetic_momentum") >= 10
                or level("telekinetic_vehicle_lift") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could lift truly enormous amounts of weight, hurling huge creatures with a moment of effort, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_aegis",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("telekinetic_wave") >= 8
                or level("telekinetic_slowfall") >= 9)
                and (level("telekinetic_momentum") >= 12
                or level("telekinetic_strength") >= 8)
                and level("telekinetic_shield") >= 7
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could take all the energy of a telekinetic shield and pour it into a single instant, forming a barrier strong enough to repel a ballistic missile, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telekinetic_earthshaker",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("telekinetic_explosion") >= 8
                or level("telekinetic_wave") >= 13)
                and (level("telekinetic_move_large_weight") >= 5
                or level("telekinetic_hammer") >= 9)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could grab the very earth with your powers, shaking it and causing a minor local earthquake, if you can figure out the proper technique.")
        end,
    },
}
