local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "corpse_generic_boy",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A dead body of a little boy."),
        looks_like = "corpse_generic_human",
        source_monster = "mon_child",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_generic_girl",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A dead body of a little girl."),
        looks_like = "corpse_generic_human",
        source_monster = "mon_child",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_child_calm",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("The dead body of a small child.  Their corpse bears a calm facial expression, as if they died instantly."),
        looks_like = "corpse_generic_human",
        source_monster = "mon_child",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:corpse_child_gunned" }
    snippets:entry {
        id = "child_gunned_01",
        text = ccb.content.text("The dead body of a child, riddled by bullets to the extent that you can no longer tell their gender."),
    }
    snippets:entry {
        id = "child_gunned_02",
        text = ccb.content.text("The corpse of an infant.  A single small-caliber bullet has been put through its skull."),
    }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "corpse_child_gunned",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("The dead body of a child, riddled by bullets to the extent that you can no longer tell their gender."),
        looks_like = "corpse_generic_human",
        source_monster = "mon_child",
        snippet_category = "auto:corpse_child_gunned",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_scorched",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("An awful, almost unidentifiable mass of charred flesh."),
        looks_like = "corpse_generic_human",
        source_monster = "mon_human_scorched",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:corpse_stabbed" }
    snippets:entry {
        id = "generic_stabbed_01",
        text = ccb.content.text("A dead body with a gaping stab wound in its back."),
    }
    snippets:entry {
        id = "generic_stabbed_02",
        text = ccb.content.text("The bloody corpse of a young man.  He has been stabbed repeatedly in the jugular and throat with a small blade."),
    }
    snippets:entry {
        id = "generic_stabbed_03",
        text = ccb.content.text("The dead body of a person.  They look to have been skewered with a large, sharp implement."),
    }
    snippets:entry {
        id = "generic_stabbed_04",
        text = ccb.content.text("The corpse of a tall middle-aged woman.  She appears to have many stab wounds up her legs and thighs."),
    }
    snippets:entry {
        id = "generic_stabbed_05",
        text = ccb.content.text("The corpse of a small old lady, her face caked in blood and missing an eye."),
    }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "corpse_stabbed",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A dead body with a gaping stab wound in its back."),
        looks_like = "corpse_generic_human",
        snippet_category = "auto:corpse_stabbed",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:corpse_generic_gunned" }
    snippets:entry {
        id = "generic_gunned_01",
        text = ccb.content.text("The dead body of a person.  Their forehead bears a large bullet entrance wound.  An even larger exit wound is present on the back of their head."),
    }
    snippets:entry {
        id = "generic_gunned_02",
        text = ccb.content.text("The corpse of a young blonde woman shot several times in the back with a low-caliber weapon."),
    }
    snippets:entry {
        id = "generic_gunned_03",
        text = ccb.content.text("An androgynous-looking corpse gored by bullet wounds from chest to thighs, leaving the face eerily pristine."),
    }
    -- canoeing
    snippets:entry {
        id = "generic_gunned_04",
        text = ccb.content.text("The corpse of a seemingly older man.  He appears to have been shot in the forehead at very close range, leaving you a good view of his brain matter."),
    }
    snippets:entry {
        id = "generic_gunned_05",
        text = ccb.content.text("The corpse of a middle-aged woman, her legs and arms covered in blood.  She appears to have been shot in the thigh."),
    }
    snippets:entry {
        id = "generic_gunned_06",
        text = ccb.content.text("The corpse of a young man who appears to have been shot to death.  His right arm is only barely still attached to his shoulder."),
    }
    snippets:entry {
        id = "generic_gunned_07",
        text = ccb.content.text("The corpse of a tall woman unblemished but for the bloody hole atop her head, her thick black hair intermixed now with brain, viscera and shotgun pellets."),
    }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "corpse_generic_gunned",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("The dead body of a person.  Their forehead bears a large bullet entrance wound.  An even larger exit wound is present on the back of their head."),
        looks_like = "corpse_generic_human",
        volume_ml = 40000,
        mass_milligrams = 52000000,
        snippet_category = "auto:corpse_generic_gunned",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:corpse_generic_infected" }
    snippets:entry {
        id = "generic_infected_01",
        text = ccb.content.text("The dead body of a person.  There is a bloody bite wound on their forearm.  Dry filth surrounds it but the body seems otherwise unharmed."),
    }
    snippets:entry {
        id = "generic_infected_02",
        text = ccb.content.text("One of this deceased persons shoulders is disfigured by a deep bite wound with a distinct shape, obviously caused by a human."),
    }
    snippets:entry {
        id = "generic_infected_03",
        text = ccb.content.text("This unlucky fellow has a deep, straight cut wound on their hand.  The blackened veins suggest it got infected."),
    }
    snippets:entry {
        id = "generic_infected_04",
        text = ccb.content.text("This lifeless body is covered in myriads of uneven scratches.  Some of them look pretty swollen."),
    }
    content.add(snippets)
end

do
    -- Died due to an untreated, infected wound.
    local item = content.Item {
        id = "corpse_generic_infected",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("The dead body of a person.  There is a bloody bite wound on their forearm.  Dry filth surrounds it."),
        looks_like = "corpse_generic_human",
        snippet_category = "auto:corpse_generic_infected",
    }
    item:material("hflesh", 1)
    content.add(item)
end
