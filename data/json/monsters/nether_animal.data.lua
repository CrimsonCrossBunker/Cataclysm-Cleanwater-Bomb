local ccb = require("ccb")

-- Higher dodge due to the constantly changing fur pattern
ccb.content.define_monster {
    id = "mon_cat_mutant_prism",
    copy_from = "mon_cat",
    name = ccb.content.plural_text("iridescent cat", "iridescent cats"),
    description = ccb.content.text("As it moves, this cat's colors shift unnaturally in the light.  You can't make out the breed, but its fur pattern seems to change with every step."),
    dodge = 9,
}

ccb.content.define_monster {
    id = "mon_cat_liquid",
    copy_from = "mon_cat",
    name = ccb.content.plural_text("liquid cat", "liquid cats"),
    description = ccb.content.text("It is universally known that cats are liquid, but this cat's body is actually quivering while it walks around.  It also enjoys resting while twisting its body in ways that would break a normal cat's bones."),
    phase = "LIQUID",
    harvest = "exempt",
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = ccb.content.text("The %s's body splashes one last time."),
        },
    },
}

ccb.content.define_monster {
    id = "mon_cat_void",
    copy_from = "mon_cat",
    name = ccb.content.plural_text("void cat", "void cats"),
    description = ccb.content.text("Seeing how unnaturally dark this black cat's fur is, you are certain this is no ordinary cat.  Its fur seems to absorb light from the surroundings."),
    regenerates_in_dark = true,
}

ccb.content.define_monster {
    id = "mon_dog_incorporeal",
    copy_from = "mon_dog",
    name = ccb.content.plural_text("translucent dog", "translucent dogs"),
    description = ccb.content.text("This dog doesn't cast a shadow, and if you squint hard enough you can see right through it.  Its condition doesn't appear to do any harm to it, though it seems to cause trouble when it tries to groom itself."),
    color = "white",
    vision_night = 4,
}

ccb.content.define_monster {
    id = "mon_dog_telekenetic",
    copy_from = "mon_dog",
    name = ccb.content.plural_text("triclopean dog", "triclopean dogs"),
    description = ccb.content.text("A rather average looking dog until you notice the third eye, right on its forehead, covered by a thick eyelid.  Whenever its open, small particles of dust from the ground rise and swirl around it."),
    harvest = "dog_triclopean_with_skull",
}

ccb.content.define_monster {
    id = "mon_dog_antimemetic",
    copy_from = "mon_dog",
    name = ccb.content.plural_text("unknowable dog", "unknowable dogs"),
    description = ccb.content.text("You are completely unable to recall anything about what this dog looks like.  You know it's a dog, you know it's there, you know you can see it, but any further information about it isn't retained in your mind."),
}
