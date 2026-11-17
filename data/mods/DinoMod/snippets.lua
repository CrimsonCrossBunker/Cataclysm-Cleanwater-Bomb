local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "general_graffiti_snippets" }
    -- This graffiti is generally assumed to come from before the Cataclysm but post dino
    category:entry {
        id = "general_graffiti_dino_1",
        text = ccb.content.text("Rejoice.  The great eaters have returned"),
    }
    category:entry {
        id = "general_graffiti_dino_2",
        text = ccb.content.text("There is a detailed drawing of a predator dinosaur with an arrow pointing at the mouth and the note 'INSERT HERE'."),
    }
    category:entry {
        id = "general_graffiti_dino_3",
        text = ccb.content.text("<given_name> is dinosaur lunch"),
    }
    category:entry {
        id = "general_graffiti_dino_4",
        text = ccb.content.text("<given_name> + troodon"),
    }
    category:entry {
        id = "general_graffiti_dino_5",
        text = ccb.content.text("Dinos, zombies, it doesn't matter"),
    }
    category:entry {
        id = "general_graffiti_dino_6",
        text = ccb.content.text("Learn to fly!  Mess with a big dino!"),
    }
    category:entry {
        id = "general_graffiti_dino_7",
        text = ccb.content.text("T REX ET ME"),
    }
    category:entry {
        id = "general_graffiti_dino_8",
        text = ccb.content.text("I give up, I'm joining the dinosaurs"),
    }
    category:entry {
        id = "general_graffiti_dino_9",
        text = ccb.content.text("This is a cartoon rendition of a long necked four legged dinosaur."),
    }
    category:entry {
        id = "general_graffiti_dino_10",
        text = ccb.content.text("This is a cartoon rendition of a long necked reptile with four fins for swimming."),
    }
    category:entry {
        id = "general_graffiti_dino_11",
        text = ccb.content.text("This is a crudely spray painted tag adorned with dinosaur skulls."),
    }
    category:entry {
        id = "general_graffiti_dino_12",
        text = ccb.content.text("KILL ALL DINOSAURS"),
    }
    category:entry {
        id = "general_graffiti_dino_13",
        text = ccb.content.text("Don't believe the government, the dinosaurs are real!"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "grave_label" }
    category:text(ccb.content.text("Good soldier.  Killed 40 dinos."))
    category:text(ccb.content.text("Bad soldier.  Killed 3 dinos."))
    category:text(ccb.content.text("Fed the great Eaters.  Will be honored for all time."))
    category:text(ccb.content.text("Meh scientist but a good friend."))
    category:text(ccb.content.text("Loved dinosaurs.  Should have run."))
    category:text(ccb.content.text("Died tragically rescuing his family from a burning tyrannosaurus."))
    category:text(ccb.content.text("Died wrestling a mosasaurus.  It was not just a big gator."))
    category:text(ccb.content.text("Built a beautiful farm and filled it with dangerous dinosaurs."))
    category:text(ccb.content.text("Life did not find a way."))
    category:text(ccb.content.text("The greatest dinosaur expert of our times.  Crushed to death by an apatosaurus."))
    category:text(ccb.content.text("Fool hid in a cardboard box from a deinonychus, shouting Dino Dave!  Didn't work."))
    category:text(ccb.content.text("Here lies a dinosaur, don't know what kind.  Hated shovels."))
    category:text(ccb.content.text("Alonso did not know her, but she was beautiful and majestic and she deserved the proper burial.  Alonso will remember this dinosaur for some of the time."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "hint" }
    category:text(ccb.content.text("I've seen some big dinosaurs out there.  I know that should be scary, but all I felt was hungry."))
    category:text(ccb.content.text("I think those little dinosaurs are kind of cute, like a cat kind of.  Do you think they eat cat food?"))
    category:text(ccb.content.text("Dinosaurs are a bow hunter's best friend.  Feathers forever!"))
    category:text(ccb.content.text("I saw one of those feathered dinosaurs up close and it had these beautiful soft downy feathers under the big ones.  I bet if you could pluck one you could make a nice dino feather mattress."))
    category:text(ccb.content.text("Those big dinosaurs make a big mess.  If only there was some way to harness the power of those poops for the uplift of all mankind.  Maybe a renewable energy source, or a construction material, or super dino fertilizer"))
    category:text(ccb.content.text("A buddy of mine wandered close to the swamps and was eaten by a T-Rex, a big lizard.  I'd be careful unless you have a gun and plenty of ammo."))
    category:text(ccb.content.text("I hear the zombies have been in the swamps.  Bad news if they bite a dinosaur before it bites them."))
    category:text(ccb.content.text("I know there aren't alligators in the sewer, but I heard there was some kind of big lizard down there.  Probably not a good idea to check."))
    category:text(ccb.content.text("Some of those big dinosaurs seem halfway all right.  I bet if you fed them something nice and gave them a pet you could ride them like a pony.  Or maybe they'd eat you instead."))
    category:text(ccb.content.text("I saw something with a large fin in the water.  It was the size of a whale and gave me a menacing feeling.  I'm gonna think twice before going back there."))
    category:text(ccb.content.text("One time I found a strange egg out in the woods.  It was probably a dinosaur, but I cooked it and it was pretty good!"))
    category:text(ccb.content.text("One time I found a giant egg out in the woods.  I ate it raw all at once and then got sick all over.  Maybe I should have cooked it and eaten it bit by bit?"))
    category:text(ccb.content.text("I got a bunch of these big lizards to follow me around and it was great and then they smashed up the place I was staying and then a bunch of other places I wanted to set up camp in.  Maybe I should have tied them down?"))
    category:text(ccb.content.text("I heard some loud smashing outside a cabin I was in out in the swamp and figured it was nothing.  Then a hungry dinosaur smashed right through the wall and I ran!"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "flier" }
    category:entry {
        id = "flier_dinomod_1",
        text = ccb.content.text("This is an advertisement for a local wildlife exhibit, claiming to have new and exciting animals on display.  Strangely, the only imagery on it is a stylized silhouette of a T. Rex.  The flier reads \"Witness the rebirth of the extinct, grand opening this week!\""),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "note" }
    category:entry {
        id = "note_dinomod_1",
        text = ccb.content.text("\"SWAMPS BAD TEETH HUGE OHGOD\""),
    }
    category:entry {
        id = "note_dinomod_2",
        text = ccb.content.text("\"Why is that place just fucking crawling with lizards?\""),
    }
    category:entry {
        id = "note_dinomod_3",
        text = ccb.content.text("\"I bet dinosaurs can read and play chess so don't eat us because we can teach you important things like magnets and ramen\""),
    }
    category:entry {
        id = "note_dinomod_4",
        text = ccb.content.text("\"where's some .700 t-rex medicine when you need it?\""),
    }
    category:entry {
        id = "note_dinomod_5",
        text = ccb.content.text("\"So is this what happens when you stray off the path and step on a butterfly?\""),
    }
    category:entry {
        id = "note_dinomod_6",
        text = ccb.content.text("\"But even a much older gent  Sees itself forced to wander  He goes by the name Diplodocus  And belongs among the fossils  Mr. Carnegie packs him joyfully  Into giant arks  And sends him as gift  To several monarchs\""),
    }
    category:entry {
        id = "note_dinomod_7",
        text = ccb.content.text("\"What the hell is a brown and magenta 4 legged juvenile?!  Fucker took a dozen or more .308 rounds to put down.  Gives a ton of fucking meat\""),
    }
    category:entry {
        id = "note_dinomod_8",
        text = ccb.content.text("\"I saw the most beautiful dinosaur today.  I must dress her.\""),
    }
    category:entry {
        id = "note_dinomod_9",
        text = ccb.content.text("\"I saw this one dinosaur and I was like gorge.  And then I saw this other dinosaur and I was like gooorge!  And then I saw this other one and I was like gorgosaurus!  Like for real.\""),
    }
    category:entry {
        id = "note_dinomod_10",
        text = ccb.content.text("\"KILL ALL DINOSAURS.  DO NOT TAKE THEIR DRUGS.  DO NOT LISTEN TO THEIR LIES.  THEY ARE BEAUTIFUL AND WE WILL KILL THEM UNTIL WE DIE AND THEN WE WILL RISE AGAIN AND KILL THEM SOME MORE.  ANYONE WHO SAYS DIFFERENT IS THE ENEMY.\""),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "newest_news" }
    category:entry {
        id = "dinomod_newest_news_1",
        text = ccb.content.text("MANY MISSING: A wave of missing persons reports have shaken an already troubled nation, especially among members of the popular Swampers religion and hotel and casino chain.  Asked to comment, their charismatic CEO Bo Baronyx refused to explain their whereabouts, saying only 'The great eaters have returned and they will be sated' and winked and smiled in the most charming way.  The Swampers are doing their part in this crisis and are accepting donations of meat and money to feed the hungry."),
    }
    category:entry {
        id = "dinomod_newest_news_2",
        text = ccb.content.text("CUTEST VISITORS: A mysterious portal of shimmering blue energy and flashing lights opened above Cretaceous Kindergarten today, showering children with the cutest tiny fuzzy dinosaurs and dinosaur babies.  Local paleontologist and exotic dancer Othniel Marsh expressed skepticism that dinosaurs had not died out millions of years ago but 'at this point why not, at least they're cute'.  And cute they are!"),
    }
    category:entry {
        id = "dinomod_newest_news_3",
        text = ccb.content.text("DENIES DINOSAURS: FEMA official Ernst Stromer said late last night that the cities are not safe and reports of dinosaurs outside the cities are wrong and 'possibly drug-related' but cautioned refugees to 'get all the guns you can' because 'it's bad out there'."),
    }
    category:entry {
        id = "dinomod_newest_news_4",
        text = ccb.content.text("NEVER HUMANS?: Swamper scientists report that in every historical simulation they have run, humans never evolve, with dinosaurs remaining the dominant life form to present day in every model unless an artificial disaster event is introduced.  'Fear not, this world is healing, we will return to normal soon' reports Swamper CEO Bo Baronyx confidently.  Sounds like good news ahead!"),
    }
    category:entry {
        id = "dinomod_newest_news_5",
        text = ccb.content.text("GOD IS A DINOSAUR?:  Colorful FEMA official and slug mutant Ernst Stromer reported this morning that he has 'seen god and she is a hungry torvosaurus too beautiful for this world'.  He says that she 'cannot be harmed by bullets' and that she is 'made of beautiful golden light from above' and she demands human flesh.  Stromer says that every fighting man and woman must go to her to be destroyed by her 'atomic majesty'.  Good news America!"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "dino-reports" }
    category:entry {
        id = "dino-reports_1",
        text = ccb.content.text("\nIMMERSION LOG: 30D-A\n\nPRELIMINARY REPORT:\n\nSUMMARY:\nExploration into sub-scape 30-D revealed biosphere similar to prime, similar to previous sub-scapes in same frequency.  Expedition team reported visual contact with several reptoids ('dinosaurs') and warm, humid conditions.  Though one reptoid made visual contact with the expedition team and approached, all members were returned with no incident.  Refer to previous sub-scape system 30 reports and meta-comparison report for further information."),
    }
    ccb.content.add(category)
end
