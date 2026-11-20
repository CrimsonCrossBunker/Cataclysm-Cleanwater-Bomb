local ccb = require("ccb")

return {
    {
        spell = "telepathic_shield",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("telepathic_concentration") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could invert the extreme focus of the concentration trance to make an impenetrable shell around your mind, protecting you from telepathic attack, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_mesmerize",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("telepathic_mind_sense") >= 6
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could nudge someone's mind into a self-focused spiral, keeping them in a daze and unaware of the outside world, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_morale",
        tier = "tier_one",
        chance = 20,
        meets = function(level)
            return level("telepathic_concentration") >= 6
                and level("telepathic_mind_sense") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  In the same way you prepare your mind for learning, you could buffer it against the stresses of post-Cataclysmic life, editing out unwarranted negative thoughts, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_blast",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("telepathic_mind_sense") >= 7
                and level("telepathic_morale") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than any kind of subtle detection or adjustment, you could lash out with your powers, damaging the minds you contact, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_animal_mind_control",
        recipe = "practice_telepathic_beastmaster",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("telepathic_morale") >= 8
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  The minds of animals are less complex than those of humans.  You should be able to overshadow them, to direct their actions and make them friendly toward you, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_confusion",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return (level("telepathic_blast") >= 6
                or level("telepathic_morale") >= 6)
                and level("telepathic_morale") >= 4
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Rather than a clumsy hammer, you could use a telepathic scalpel to cut off the target's connection between their senses and their brain, leaving them stumbling and blind, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_fear",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("telepathic_blast") >= 8
                and level("telepathic_morale") >= 8
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could evoke your target's darkest fears, leaving them frozen in panic or trembling in terror, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_invisibility",
        tier = "tier_two",
        chance = 40,
        meets = function(level)
            return level("telepathic_confusion") >= 8
                and (level("telepathic_morale") >= 6
                or level("telepathic_blast") >= 11
                or level("telepathic_shield") >= 8)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could erase yourself from a target's perceptions, making them completely unable to even know that you're there, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_blast_radius",
        recipe = "practice_telepathic_scream",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("telepathic_blast") >= 11
                or level("telepathic_fear") >= 7)
                and level("telepathic_shield") >= 5
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You could erase yourself from a target's perceptions, making them completely unable to even know that you're there, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_beast_taming",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("telepathic_animal_mind_control") >= 10
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  You can overshadow animal minds for a short time, but it shouldn't be difficult to make further adjustments, to make the animal friendly for weeks or months, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_mind_control",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return (level("telepathic_morale") >= 12
                or level("telepathic_invisibility") >= 6)
                and (level("telepathic_fear") >= 5
                or level("telepathic_animal_mind_control") >= 8
                or level("telepathic_confusion") >= 7)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Just as you can control the minds of animals, you could control the minds of humans, or maybe even aliens, if you can figure out the proper technique.")
        end,
    },
    {
        spell = "telepathic_network",
        tier = "tier_three",
        chance = 80,
        meets = function(level)
            return level("telepathic_mind_sense") >= 10
                and level("telepathic_blast_radius") >= 6
                and (level("telepathic_morale") >= 12
                or level("telepathic_invisibility") >= 6)
        end,
        message = function()
            return ccb.services.translate("Use of your powers has led to an insight.  Thought is far faster than speech, and with your allies nearby you could warn each other of any dangers or enemy weaknesses as fast as thinking, if you can figure out the proper technique.")
        end,
    },
}
