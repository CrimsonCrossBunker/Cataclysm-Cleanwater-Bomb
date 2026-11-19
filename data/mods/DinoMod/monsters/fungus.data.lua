local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zilophosaurus_fungus",
    name = ccb.content.plural_text("fungal dilophosaurus zombie", "fungal dilophosaurus zombies"),
    description = ccb.content.text("Once a predator dinosaur with sharp teeth and two prominent bony crests on its head, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh with a colorful frill of interwoven mushrooms."),
    copy_from = "mon_zilophosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { cooldown = 5, kind = "bite" } },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zeratosaurus_fungus",
    name = ccb.content.plural_text("fungal ceratosaurus zombie", "fungal ceratosaurus zombies"),
    description = ccb.content.text("Once an enormous, scaly dinosaur studded with bony spikes with colorful horns, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered scales and spikes."),
    copy_from = "mon_zeratosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { cooldown = 5, kind = "bite" } },
    upgrade = false,
    flags = { "SEES", "HEARS", "BASHES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "SWIMS" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zpinosaurus_fungus",
    name = ccb.content.plural_text("fungal spinosaurus zombie", "fungal spinosaurus zombies"),
    description = ccb.content.text("Once an enormous crocodile-headed carnivorous dinosaur with a sail on its back, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zpinosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { cooldown = 5, kind = "bite" } },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM", "SWIMS" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zorvosaurus_fungus",
    name = ccb.content.plural_text("fungal torvosaurus zombie", "fungal torvosaurus zombies"),
    description = ccb.content.text("Once a bipedal dinosaur with a large head, long sharp teeth, short strong arms, and long tail, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zorvosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { cooldown = 5, kind = "bite" } },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zallosaurus_fungus",
    name = ccb.content.plural_text("fungal allosaurus zombie", "fungal allosaurus zombies"),
    description = ccb.content.text("Once a large predatory bipedal dinosaur with a broad scaly back, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zallosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { cooldown = 5, kind = "bite" } },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "BASHES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zacrocanthosaurus_fungus",
    name = ccb.content.plural_text("fungal acrocanthosaurus zombie", "fungal acrocanthosaurus zombies"),
    description = ccb.content.text("Once a huge predatory bipedal dinosaur, with a tall ridge running down the length of its back covered with heavy muscles and showing teeth curved and serrated like sawblades, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zacrocanthosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    grab_strength = 100,
    attacks = {
        { id = "bite_grab" },
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "LUNGE", cooldown = 20 },
    },
    upgrade = false,
    flags = { "SEES", "GRABS", "POISON", "STUMBLES", "BASHES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_ziganotosaurus_fungus",
    name = ccb.content.plural_text("fungal giganotosaurus zombie", "fungal giganotosaurus zombies"),
    description = ccb.content.text("Once a huge predatory bipedal dinosaur showing teeth curved and serrated like sawblades, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_ziganotosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    grab_strength = 100,
    attacks = {
        { id = "bite_grab" },
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "LUNGE", cooldown = 20 },
    },
    upgrade = false,
    flags = { "SEES", "GRABS", "POISON", "STUMBLES", "BASHES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_ziats_fungus",
    name = ccb.content.plural_text("fungal siats zombie", "fungal siats zombies"),
    description = ccb.content.text("Once a huge predatory bipedal dinosaur with long claws and strong arms for grappling, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_ziats",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "BIO_OP_TAKEDOWN", cooldown = 20 },
        { id = "ranged_pull", cooldown = 20 },
        { id = "grab_drag" },
        { id = "drag_followup" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "BASHES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zryptosaurus_fungus",
    name = ccb.content.plural_text("fungal dryptosaurus zombie", "fungal dryptosaurus zombies"),
    description = ccb.content.text("Once a large predatory bipedal dinosaur with sharp teeth and claws, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zryptosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    grab_strength = 75,
    attacks = {
        { id = "bite_grab", cooldown = 20 },
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 20 },
    },
    upgrade = false,
    flags = { "SEES", "GRABS", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zanotyrannus_fungus",
    name = ccb.content.plural_text("fungal nanotyrannus zombie", "fungal nanotyrannus zombies"),
    description = ccb.content.text("Once a predatory bipedal dinosaur with sharp teeth and long legs, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zanotyrannus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    grab_strength = 75,
    attacks = {
        { id = "bite_grab", cooldown = 20 },
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 20 },
    },
    upgrade = false,
    flags = { "SEES", "GRABS", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zappalachiosaurus_fungus",
    name = ccb.content.plural_text("fungal appalachiosaurus zombie", "fungal appalachiosaurus zombies"),
    description = ccb.content.text("Once a huge predatory bipedal dinosaur with massive jaws, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zappalachiosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    grab_strength = 75,
    attacks = {
        { id = "bite_grab", cooldown = 20 },
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 20 },
    },
    upgrade = false,
    flags = { "SEES", "GRABS", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zorgosaurus_fungus",
    name = ccb.content.plural_text("fungal gorgosaurus zombie", "fungal gorgosaurus zombies"),
    description = ccb.content.text("Once a huge predatory bipedal dinosaur with massive jaws, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zorgosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    grab_strength = 100,
    attacks = {
        { id = "bite_grab", cooldown = 20 },
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 20 },
    },
    upgrade = false,
    flags = { "SEES", "GRABS", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zalbertosaurus_fungus",
    name = ccb.content.plural_text("fungal albertosaurus zombie", "fungal albertosaurus zombies"),
    description = ccb.content.text("Once a huge predatory bipedal dinosaur with long claws and massive jaws, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zalbertosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    grab_strength = 75,
    attacks = {
        { id = "bite_grab", cooldown = 5 },
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 5 },
    },
    upgrade = false,
    flags = { "SEES", "GRABS", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zianzhousaurus_fungus",
    name = ccb.content.plural_text("fungal qianzhousaurus zombie", "fungal qianzhousaurus zombies"),
    description = ccb.content.text("This was once a large, bipedal, feather-covered dinosaur with a long, gator-like mouth with sharp teeth.  Now fungal tendrils sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zianzhousaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { cooldown = 5, kind = "bite" },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 5 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zanuqsaurus_fungus",
    name = ccb.content.plural_text("fungal nanuqsaurus zombie", "fungal nanuqsaurus zombies"),
    description = ccb.content.text("This was once a large, bipedal dinosaur with a long, sharp teeth.  Now fungal tendrils sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zanuqsaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { cooldown = 5, kind = "bite" },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 10 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zaspletosaurus_fungus",
    name = ccb.content.plural_text("fungal daspletosaurus zombie", "fungal daspletosaurus zombies"),
    description = ccb.content.text("This was once a large, bipedal dinosaur with a long, sharp teeth.  Now fungal tendrils sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zaspletosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { cooldown = 5, kind = "bite" },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 5 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zyrannosaurus_fungus",
    name = ccb.content.plural_text("fungal z-rex", "fungal z-rexes"),
    description = ccb.content.text("Once a huge predatory bipedal dinosaur with massive sharp teeth, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zyrannosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { cooldown = 5, kind = "bite" } },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "BASHES", "DESTROYS", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zedcolbertia_fungus",
    name = ccb.content.plural_text("fungal nedcolbertia zombie", "fungal nedcolbertia zombies"),
    description = ccb.content.text("Once a feathered, plant-eating, bipedal dinosaur, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered feathers."),
    copy_from = "mon_zedcolbertia",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "HEARS", "PET_MOUNTABLE", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zallimimus_fungus",
    name = ccb.content.plural_text("fungal gallimimus zombie", "fungal gallimimus zombies"),
    description = ccb.content.text("Once a feathered, plant-eating, bipedal dinosaur, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered feathers."),
    copy_from = "mon_zallimimus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "HEARS", "PET_MOUNTABLE", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_ztruthiomimus_fungus",
    name = ccb.content.plural_text("fungal struthiomimus zombie", "fungal struthiomimus zombies"),
    description = ccb.content.text("Once a feathered, plant-eating, bipedal dinosaur, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered feathers."),
    copy_from = "mon_ztruthiomimus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "HEARS", "PET_MOUNTABLE", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zornithomimus_fungus",
    name = ccb.content.plural_text("fungal ornithomimus zombie", "fungal ornithomimus zombies"),
    description = ccb.content.text("Once a feathered, plant-eating, bipedal dinosaur, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered feathers."),
    copy_from = "mon_zornithomimus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "HEARS", "PET_MOUNTABLE", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zalcarius_fungus",
    name = ccb.content.plural_text("fungal falcarius zombie", "fungal falcarius zombies"),
    description = ccb.content.text("Once a feathered bipedal plant eating dinosaur with long claws, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered feathers."),
    copy_from = "mon_zalcarius",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { id = "longswipe", cooldown = 20 } },
    upgrade = false,
    flags = { "SEES", "HEARS", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zerizinosaurus_fungus",
    name = ccb.content.plural_text("fungal therizinosaurus zombie", "fungal therizinosaurus zombies"),
    description = ccb.content.text("Once a huge feathered bipedal plant eating dinosaur with long claws, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered feathers."),
    copy_from = "mon_zerizinosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { id = "longswipe", cooldown = 20 } },
    upgrade = false,
    flags = { "SEES", "HEARS", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES", "DESTROYS" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zothronychus_fungus",
    name = ccb.content.plural_text("fungal nothronychus zombie", "fungal nothronychus zombies"),
    description = ccb.content.text("Once a large feathered bipedal plant eating dinosaur with sharp curved claws, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered feathers."),
    copy_from = "mon_zothronychus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { id = "longswipe", cooldown = 30 } },
    upgrade = false,
    flags = { "SEES", "HEARS", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zanzu_fungus",
    name = ccb.content.plural_text("fungal anzu zombie", "fungal anzu zombies"),
    description = ccb.content.text("Once a large feathered bipedal dinosaur with a long neck and claws, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered feathers."),
    copy_from = "mon_zanzu",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { id = "longswipe", cooldown = 30 } },
    upgrade = false,
    flags = { "SEES", "HEARS", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zeinonychus_fungus",
    name = ccb.content.plural_text("fungal deinonychus zombie", "fungal deinonychus zombies"),
    description = ccb.content.text("Once a feathered, carnivorous dinosaur with a large, sickle-shaped talon on each foot, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zeinonychus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { cooldown = 5, maximum_range = 5, allow_no_target = true, kind = "leap" },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zutahraptor_fungus",
    name = ccb.content.plural_text("fungal utahraptor zombie", "fungal utahraptor zombies"),
    description = ccb.content.text("Once a large, feathered, meat-eating dinosaur with a sickle-shaped talon on each foot, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zutahraptor",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { cooldown = 5, maximum_range = 5, allow_no_target = true, kind = "leap" },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zarahsaurus_fungus",
    name = ccb.content.plural_text("fungal sarahsaurus zombie", "fungal sarahsaurus zombies"),
    description = ccb.content.text("This was once a long-necked, bipedal plant eating dinosaur with a long tail.  Now fungal tendrils sprout from the mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zarahsaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zanchisaurus_fungus",
    name = ccb.content.plural_text("fungal anchisaurus zombie", "fungal anchisaurus zombies"),
    description = ccb.content.text("This was once a four legged plant eating dinosaur with a long neck and leathery skin.  Now fungal tendrils sprout from the mouth, eyes, and other orifices, holding together a large shambling mass of mold-covered flesh."),
    copy_from = "mon_zanchisaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zissi_fungus",
    name = ccb.content.plural_text("fungal issi zombie", "fungal issi zombies"),
    description = ccb.content.text("This was once a large, long-necked, bipedal plant eating dinosaur with a long tail.  Now fungal tendrils sprout from the mouth, eyes, and other orifices, holding together a large shambling mass of mold-covered flesh."),
    copy_from = "mon_zissi",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zoabosaurus_fungus",
    name = ccb.content.plural_text("fungal moabosaurus zombie", "fungal moabosaurus zombies"),
    description = ccb.content.text("This was once a huge, long-necked, four-legged dinosaur with a long tail.  Now fungal tendrils sprout from the mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zoabosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zaplocanthosaurus_fungus",
    name = ccb.content.plural_text("fungal haplocanthosaurus zombie", "fungal haplocanthosaurus zombies"),
    description = ccb.content.text("This was once a huge, long-necked, four-legged plant eating dinosaur with a long tail.  Now fungal tendrils sprout from the mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zaplocanthosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zamargasaurus_fungus",
    name = ccb.content.plural_text("fungal amargasaurus zombie", "fungal amargasaurus zombies"),
    description = ccb.content.text("This was once a huge, long-necked, four-legged plant eating dinosaur with a whip-like tail and spiked neck.  Now fungal tendrils sprout from the mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zamargasaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "SMASH", cooldown = 30 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zapatosaurus_fungus",
    name = ccb.content.plural_text("fungal apatosaurus zombie", "fungal apatosaurus zombies"),
    description = ccb.content.text("Once a massive, long-necked, four-legged plant eating dinosaur with a long, whip-like tail, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zapatosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "SMASH", cooldown = 30 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zrontosaurus_fungus",
    name = ccb.content.plural_text("fungal brontosaurus zombie", "fungal brontosaurus zombies"),
    description = ccb.content.text("This was once a massive, long-necked, four-legged dinosaur herbivore with a bulky torso and a long, whip-like tail.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zapatosaurus_fungus",
    upgrade = false,
}

ccb.content.define_monster {
    id = "mon_ziplodocus_fungus",
    name = ccb.content.plural_text("fungal diplodocus zombie", "fungal diplodocus zombies"),
    description = ccb.content.text("Once a huge, long-necked, four-legged plant eating dinosaur with a tiny head and long, whip-like tail, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zapatosaurus_fungus",
    upgrade = false,
}

ccb.content.define_monster {
    id = "mon_zarosaurus_fungus",
    name = ccb.content.plural_text("fungal barosaurus zombie", "fungal barosaurus zombies"),
    description = ccb.content.text("Once a huge, long-necked, four-legged plant eating dinosaur with a long, whip-like tail, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zapatosaurus_fungus",
    upgrade = false,
}

ccb.content.define_monster {
    id = "mon_zamarasaurus_fungus",
    name = ccb.content.plural_text("fungal camarasaurus zombie", "fungal camarasaurus zombies"),
    description = ccb.content.text("Once a huge, long-necked, four-legged plant eating dinosaur with a long, whip-like tail, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zapatosaurus_fungus",
    upgrade = false,
}

ccb.content.define_monster {
    id = "mon_zrachiosaurus_fungus",
    name = ccb.content.plural_text("fungal brachiosaurus zombie", "fungal brachiosaurus zombies"),
    description = ccb.content.text("Once a gigantic, long-necked, four-legged plant eating dinosaur with longer forelegs and a long, whip-like tail, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zapatosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 2, speed = 0.65 } },
}

ccb.content.define_monster {
    id = "mon_zastrodon_fungus",
    name = ccb.content.plural_text("fungal astrodon zombie", "fungal astrodon zombies"),
    description = ccb.content.text("Once a gigantic, long-necked, four-legged plant eating dinosaur with a huge nose, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zapatosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 2, speed = 0.65 } },
}

ccb.content.define_monster {
    id = "mon_zalamosaurus_fungus",
    name = ccb.content.plural_text("fungal alamosaurus zombie", "fungal alamosaurus zombies"),
    description = ccb.content.text("Once a gigantic, long-necked, four-legged plant eating dinosaur with longer forelegs and spiked tail protected by natural bone armor, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh."),
    copy_from = "mon_zapatosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 1.5, speed = 0.8, armor = { bash = 2, cut = 2 } } },
}

ccb.content.define_monster {
    id = "mon_ztegosaurus_fungus",
    name = ccb.content.plural_text("fungal stegosaurus zombie", "fungal stegosaurus zombies"),
    description = ccb.content.text("This was once a large, four-legged dinosaur herbivore with a spiked tail and tall bone plates jutting from its back.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_ztegosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "SMASH", cooldown = 30 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zesperosaurus_fungus",
    name = ccb.content.plural_text("fungal hesperosaurus zombie", "fungal hesperosaurus zombies"),
    description = ccb.content.text("This was once a large, four-legged dinosaur herbivore with a spiked tail and long bone plates jutting from its back.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zesperosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "SMASH", cooldown = 30 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zastonia_fungus",
    name = ccb.content.plural_text("fungal gastonia zombie", "fungal gastonia zombies"),
    description = ccb.content.text("Once a heavily armored four legged dinosaur with a long tail, a beak, and large shoulder spikes, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zodosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 0.7 } },
}

ccb.content.define_monster {
    id = "mon_zargoyleosaurus_fungus",
    name = ccb.content.plural_text("fungal gargoyleosaurus zombie", "fungal gargoyleosaurus zombies"),
    description = ccb.content.text("Once a lightly armored four legged dinosaur with a rigid spiked tail, a beak, and sturdy spikes along the sides, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zodosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 0.8 } },
}

ccb.content.define_monster {
    id = "mon_zauropelta_fungus",
    name = ccb.content.plural_text("fungal sauropelta zombie", "fungal sauropelta zombies"),
    description = ccb.content.text("Once a heavily armored four legged dinosaur with a beak, a long tail, and long wicked-looking spikes jutting out of the neck, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zodosaurus_fungus",
    upgrade = false,
    armor = { bash = 16, bullet = 7, cut = 30 },
}

ccb.content.define_monster {
    id = "mon_zodosaurus_fungus",
    name = ccb.content.plural_text("fungal nodosaurus zombie", "fungal nodosaurus zombies"),
    description = ccb.content.text("Once a heavily armored four legged dinosaur with a beak and large bony plates covering the back, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zankylosaurus_fungus",
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    inheritance = { scale = { hp = 0.6 } },
}

ccb.content.define_monster {
    id = "mon_zanoplosaurus_fungus",
    name = ccb.content.plural_text("fungal panoplosaurus zombie", "fungal panoplosaurus zombies"),
    description = ccb.content.text("Once a heavily armored four legged dinosaur with a lumpy armored head with a beak and thick plates protecting the cheeks, thick back armor, and small short spikes along the sides, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zankylosaurus_fungus",
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    inheritance = { scale = { hp = 0.6 } },
}

ccb.content.define_monster {
    id = "mon_zedmontonia_fungus",
    name = ccb.content.plural_text("fungal edmontonia zombie", "fungal edmontonia zombies"),
    description = ccb.content.text("Once something like a gigantic armadillo-dinosaur hybrid with long, bony spikes, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zankylosaurus_fungus",
    melee_damage = { { type = "stab", amount = 10 } },
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    inheritance = { scale = { hp = 0.65 } },
}

ccb.content.define_monster {
    id = "mon_zzuul_fungus",
    name = ccb.content.plural_text("fungal zuul zombie", "fungal zuul zombies"),
    description = ccb.content.text("Once a four-legged armored dinosaur covered with spikes with a wicked club tail, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zankylosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 0.4, speed = 1.2 } },
}

ccb.content.define_monster {
    id = "mon_zyoplosaurus_fungus",
    name = ccb.content.plural_text("fungal dyoplosaurus zombie", "fungal dyoplosaurus zombies"),
    description = ccb.content.text("Once a heavily armored four legged dinosaur with a beak and a long tail ending in a spiked club of bone, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zankylosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 0.35, speed = 1.2 } },
}

ccb.content.define_monster {
    id = "mon_zankylosaurus_fungus",
    name = ccb.content.plural_text("fungal ankylosaurus zombie", "fungal ankylosaurus zombies"),
    description = ccb.content.text("Once a heavily armored four legged dinosaur with a long tail ending in a massive spiked club of bone, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zankylosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "SMASH", cooldown = 30 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zuoplocephalus_fungus",
    name = ccb.content.plural_text("fungal euoplocephalus zombie", "fungal euoplocephalus zombies"),
    description = ccb.content.text("Once a heavily armored four legged dinosaur with a horny beak, two bony rings protecting the neck, and a long tail ending in a heavy club of bone, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zuoplocephalus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "SMASH", cooldown = 30 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zcolosaurus_fungus",
    name = ccb.content.plural_text("fungal scolosaurus zombie", "fungal scolosaurus zombies"),
    description = ccb.content.text("Once a heavily armored four legged dinosaur with several long spikes along the back and a long spiked tail ending in a club of bone, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zcolosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "SMASH", cooldown = 30 },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zenontosaurus_fungus",
    name = ccb.content.plural_text("fungal tenontosaurus zombie", "fungal tenontosaurus zombies"),
    description = ccb.content.text("This was once a feathered, four-legged dinosaur with a beak and a broad long tail.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered feathers."),
    copy_from = "mon_zenontosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zryosaurus_fungus",
    name = ccb.content.plural_text("fungal dryosaurus zombie", "fungal dryosaurus zombies"),
    description = ccb.content.text("This was once a small feathered dinosaur with short arms, a long neck, and a horned beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered feathers."),
    copy_from = "mon_zamptosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zamptosaurus_fungus",
    name = ccb.content.plural_text("fungal camptosaurus zombie", "fungal camptosaurus zombies"),
    description = ccb.content.text("This was once a large, feathered, bipedal dinosaur with strong legs, broad shoulders, and a pointed beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together an enormous shambling mass of mold-covered feathers."),
    copy_from = "mon_zamptosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_ziguanodon_fungus",
    name = ccb.content.plural_text("fungal iguanodon zombie", "fungal iguanodon zombies"),
    description = ccb.content.text("Once a bulky, beaked four-legged dinosaur herbivore with spiky thumbs, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 3.5 } },
}

ccb.content.define_monster {
    id = "mon_zeolambia_fungus",
    name = ccb.content.plural_text("fungal eolambia zombie", "fungal eolambia zombies"),
    description = ccb.content.text("Once a beaked, slender four-legged dinosaur herbivore with a long neck, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 1.5 } },
}

ccb.content.define_monster {
    id = "mon_zadrosaurus_fungus",
    name = ccb.content.plural_text("fungal hadrosaurus zombie", "fungal hadrosaurus zombies"),
    description = ccb.content.text("Once a bulky, beaked four-legged dinosaur herbivore, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 3 } },
}

ccb.content.define_monster {
    id = "mon_zaiasaura_fungus",
    name = ccb.content.plural_text("fungal maiasaura zombie", "fungal maiasaura zombies"),
    description = ccb.content.text("This was once a huge, four-legged dinosaur herbivore with hooves, a heavy tail, and a flat beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 3 } },
}

ccb.content.define_monster {
    id = "mon_zryposaurus_fungus",
    name = ccb.content.plural_text("fungal gryposaurus zombie", "fungal gryposaurus zombies"),
    description = ccb.content.text("Once a huge, four-legged dinosaur herbivore with a toothless beak and a narrow arching nasal hump, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 4 } },
}

ccb.content.define_monster {
    id = "mon_zrosaurolophus_fungus",
    name = ccb.content.plural_text("fungal prosaurolophus zombie", "fungal prosaurolophus zombies"),
    description = ccb.content.text("Once a huge, four-legged dinosaur herbivore with hooves and a broad beak and a small nasal crest, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 4 } },
}

ccb.content.define_monster {
    id = "mon_zaurolophus_fungus",
    name = ccb.content.plural_text("fungal saurolophus zombie", "fungal saurolophus zombies"),
    description = ccb.content.text("Once a huge, four-legged dinosaur herbivore with hooves and a broad beak and a spiky head crest, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 4 } },
}

ccb.content.define_monster {
    id = "mon_zedmontosaurus_fungus",
    name = ccb.content.plural_text("fungal edmontosaurus zombie", "fungal edmontosaurus zombies"),
    description = ccb.content.text("Once a huge, four-legged dinosaur herbivore with a broad, toothless beak, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 5 } },
}

ccb.content.define_monster {
    id = "mon_zarasaurolophus_fungus",
    name = ccb.content.plural_text("fungal parasaurolophus zombie", "fungal parasaurolophus zombies"),
    description = ccb.content.text("Once a huge, four-legged dinosaur herbivore with a blunt head crest, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    upgrade = false,
    inheritance = { scale = { hp = 4 } },
}

ccb.content.define_monster {
    id = "mon_zambeosaurus_fungus",
    name = ccb.content.plural_text("fungal lambeosaurus zombie", "fungal lambeosaurus zombies"),
    description = ccb.content.text("Once a huge, four-legged dinosaur herbivore with a long stiff tail, hooves, a narrow beak and a tall head crest, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
        { reference = "SHRIEK", cooldown = 5 },
    },
    upgrade = false,
    inheritance = { scale = { hp = 4 } },
}

ccb.content.define_monster {
    id = "mon_zorythosaurus_fungus",
    name = ccb.content.plural_text("fungal corythosaurus zombie", "fungal corythosaurus zombies"),
    description = ccb.content.text("Once a huge, four-legged dinosaur herbivore with a short beak and a tall head crest, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
        { reference = "SHRIEK", cooldown = 5 },
    },
    upgrade = false,
    inheritance = { scale = { hp = 4 } },
}

ccb.content.define_monster {
    id = "mon_zypacrosaurus_fungus",
    name = ccb.content.plural_text("fungal hypacrosaurus zombie", "fungal hypacrosaurus zombies"),
    description = ccb.content.text("Once a huge, four-legged dinosaur herbivore with a tall ridge down the back, a tail, hooves, a short beak and a wide, rounded head crest, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh and bone."),
    copy_from = "mon_zamptosaurus_fungus",
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
        { reference = "SHRIEK", cooldown = 5 },
    },
    upgrade = false,
    inheritance = { scale = { hp = 4 } },
}

ccb.content.define_monster {
    id = "mon_zachycephalosaurus_fungus",
    name = ccb.content.plural_text("fungal pachycephalosaurus zombie", "fungal pachycephalosaurus zombies"),
    description = ccb.content.text("Once a feathered, bipedal dinosaur with a hard-looking domed head, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered feathers."),
    copy_from = "mon_zachycephalosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "PET_MOUNTABLE" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zeptoceratops_fungus",
    name = ccb.content.plural_text("fungal leptoceratops zombie", "fungal leptoceratops zombies"),
    description = ccb.content.text("This was once a four-legged dinosaur herbivore with a bony crest and beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zeptoceratops",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "PET_MOUNTABLE" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zzuniceratops_fungus",
    name = ccb.content.plural_text("fungal zuniceratops zombie", "fungal zuniceratops zombies"),
    description = ccb.content.text("This was once a four-legged dinosaur herbivore with a tall thin bony head crest, two long brow horns, and a beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zzuniceratops",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "PET_MOUNTABLE" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zokiceratops_fungus",
    name = ccb.content.plural_text("fungal lokiceratops zombie", "fungal lokiceratops zombies"),
    description = ccb.content.text("This was once a four-legged dinosaur herbivore with a bony head crest with two large horns pointing out and down, two long brow horns, and a beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zokiceratops",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "PET_MOUNTABLE" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_ztyracosaurus_fungus",
    name = ccb.content.plural_text("fungal styracosaurus zombie", "fungal styracosaurus zombies"),
    description = ccb.content.text("This was once a stocky four-legged dinosaur with a bony crest with several long spikes and one large horn above the beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_ztyracosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "PET_MOUNTABLE" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zentrosaurus_fungus",
    name = ccb.content.plural_text("fungal centrosaurus zombie", "fungal centrosaurus zombies"),
    description = ccb.content.text("This was once a large stocky four-legged dinosaur with a bony crest and one large horn above the nose.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zentrosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "PET_MOUNTABLE" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zeiniosaurus_fungus",
    name = ccb.content.plural_text("fungal einiosaurus zombie", "fungal einiosaurus zombies"),
    description = ccb.content.text("This was once a stocky dinosaur with a tall bony crest and one large horn above the nose curving forward towards the beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zeiniosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "PET_MOUNTABLE" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zachelousaurus_fungus",
    name = ccb.content.plural_text("fungal achelousaurus zombie", "fungal achelousaurus zombies"),
    description = ccb.content.text("This was once a stocky dinosaur with a tall bony crest with two long curved spikes and three rough bosses above the eyes and nose as well as a short tail and hooked beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zriceratops_fungus",
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "SMASH", cooldown = 30 },
    },
    upgrade = false,
    inheritance = { scale = { hp = 0.55 } },
}

ccb.content.define_monster {
    id = "mon_zachyrhinosaurus_fungus",
    name = ccb.content.plural_text("fungal pachyrhinosaurus zombie", "fungal pachyrhinosaurus zombies"),
    description = ccb.content.text("This was once a massive, four-legged dinosaur herbivore, with a tall bony crest from which four long horns and a short nose horn emerged.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zriceratops_fungus",
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "SMASH", cooldown = 30 },
    },
    upgrade = false,
    inheritance = { scale = { hp = 0.65 } },
}

ccb.content.define_monster {
    id = "mon_zasmosaurus_fungus",
    name = ccb.content.plural_text("fungal chasmosaurus zombie", "fungal chasmosaurus zombies"),
    description = ccb.content.text("This was once a four-legged dinosaur with a tall bony crest from which three short horns emerge above the eyes and beak.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zriceratops_fungus",
    upgrade = false,
    inheritance = { scale = { armor = { bash = 2 } } },
}

ccb.content.define_monster {
    id = "mon_zentaceratops_fungus",
    name = ccb.content.plural_text("fungal pentaceratops zombie", "fungal pentaceratops zombies"),
    description = ccb.content.text("This was once a massive, four-legged dinosaur herbivore, with a tall bony crest from which four long horns and a short nose horn emerged.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zriceratops_fungus",
    upgrade = false,
    inheritance = { scale = { armor = { bash = 2 } } },
}

ccb.content.define_monster {
    id = "mon_zosmoceratops_fungus",
    name = ccb.content.plural_text("fungal kosmoceratops zombie", "fungal kosmoceratops zombies"),
    description = ccb.content.text("This was once a massive, four-legged dinosaur herbivore, with a tall bony crest from which fifteen horns and spikes emerged.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zriceratops_fungus",
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { id = "impale" },
        { reference = "stretch_horn_DinoMod", cooldown = 10 },
    },
    upgrade = false,
    inheritance = { scale = { melee_dice = 2, melee_damage = { type = "stab", amount = 0.65 } } },
}

ccb.content.define_monster {
    id = "mon_zorosaurus_fungus",
    name = ccb.content.plural_text("fungal torosaurus zombie", "fungal torosaurus zombies"),
    description = ccb.content.text("This was once a massive, four-legged dinosaur herbivore, with a tall bony crest from which two wicked-looking horns emerged.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zriceratops_fungus",
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { id = "impale" },
        { reference = "stretch_horn_DinoMod", cooldown = 5 },
    },
    upgrade = false,
    inheritance = { scale = { melee_dice = 2, melee_damage = { type = "stab", amount = 0.65 } } },
}

ccb.content.define_monster {
    id = "mon_zriceratops_fungus",
    name = ccb.content.plural_text("fungal triceratops zombie", "fungal triceratops zombies"),
    description = ccb.content.text("This was once a massive, four-legged dinosaur herbivore, with a bony head crest from which three wicked-looking horns emerged.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zriceratops",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 }, { id = "impale" } },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "PET_MOUNTABLE", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zona_fungus",
    name = ccb.content.plural_text("fungal fona zombie", "fungal fona zombies"),
    description = ccb.content.text("This was once a two-legged dinosaur herbivore, with a long tail and claws.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zona",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 } },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "PET_MOUNTABLE", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zescelosaurus_fungus",
    name = ccb.content.plural_text("fungal thescelosaurus zombie", "fungal thescelosaurus zombies"),
    description = ccb.content.text("This was once a sturdy two-legged dinosaur herbivore, with a long beak and feathers.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered flesh."),
    copy_from = "mon_zescelosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = { { reference = "FUNGUS", cooldown = 200 } },
    upgrade = false,
    flags = { "SEES", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "PET_MOUNTABLE", "BASHES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zteranodon_fungus",
    name = ccb.content.plural_text("fungal pteranodon zombie", "fungal pteranodon zombies"),
    description = ccb.content.text("This was once a large, feathered reptile with a long, pointy, toothless beak and a long, pointy head crest, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered feathers."),
    copy_from = "mon_zteranodon",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "HEARS", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY", "WARM", "BASHES", "FLIES" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zuetzalcoatlus_fungus",
    name = ccb.content.plural_text("fungal quetzalcoatlus zombie", "fungal quetzalcoatlus zombies"),
    volume = "190 L",
    mass = "250 kg",
    speed = 78,
    hp = 249,
    description = ccb.content.text("This was once a large, feathered reptile with a long, pointy, toothless beak and a long, pointy head crest, fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a shambling mass of mold-covered feathers."),
    copy_from = "mon_zteranodon_fungus",
    upgrade = false,
}

ccb.content.define_monster {
    id = "mon_zosasaurus_fungus",
    name = ccb.content.plural_text("fungal mosasaurus zombie", "fungal mosasaurus zombies"),
    description = ccb.content.text("This was once a huge aquatic dinosaur the size of a house, with a crocodile-like head and swimming fins.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a foul mass of mold-covered scales and teeth."),
    copy_from = "mon_zosasaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = {
        "SEES",
        "HEARS",
        "DESTROYS",
        "WARM",
        "SWIMS",
        "AQUATIC",
        "POISON",
        "STUMBLES",
        "NO_BREATHE",
        "FILTHY",
    },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zonisaurus_fungus",
    name = ccb.content.plural_text("fungal shonisaurus zombie", "fungal shonisaurus zombies"),
    description = ccb.content.text("This was once a huge aquatic dinosaur the size of a house, with a long snout and swimming fins.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a foul mass of mold-covered scales and teeth."),
    copy_from = "mon_zonisaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = {
        "SEES",
        "HEARS",
        "DESTROYS",
        "WARM",
        "SWIMS",
        "AQUATIC",
        "POISON",
        "STUMBLES",
        "NO_BREATHE",
        "FILTHY",
    },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zlesiosaurus_fungus",
    name = ccb.content.plural_text("fungal plesiosaurus zombie", "fungal plesiosaurus zombies"),
    description = ccb.content.text("This was once a huge aquatic dinosaur the size of a car, with a crocodile-like head, a long neck, and swimming fins.  Fungal tendrils now sprout from its mouth, eyes, and other orifices, holding together a foul mass of mold-covered scales and teeth."),
    copy_from = "mon_zlesiosaurus",
    default_faction = "fungus",
    species = { "FUNGUS" },
    difficulty_adjustment = 2,
    color = "light_gray",
    bleed_rate = 0,
    vision_day = 5,
    vision_night = 5,
    attacks = {
        { reference = "FUNGUS", cooldown = 200 },
        { reference = "scratch", cooldown = 10 },
        { cooldown = 5, kind = "bite" },
    },
    upgrade = false,
    flags = { "SEES", "HEARS", "SWIMS", "AQUATIC", "POISON", "STUMBLES", "NO_BREATHE", "FILTHY" },
    inheritance = {
        scale = { hp = 0.75, speed = 0.65 },
        offset = { melee_skill = -1, melee_dice = -1, melee_sides = 3, armor = { bash = 3 } },
    },
}
