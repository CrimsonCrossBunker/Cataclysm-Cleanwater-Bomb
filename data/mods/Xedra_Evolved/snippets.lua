local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "Anathema_Warnings_Snippets" }
    category:text(ccb.content.text("You shudder at the thought of vampire hunters.  Knowing your luck, one is probably tracking you as this very moment."))
    category:text(ccb.content.text("You long for the safety of a warm uncontrolled blaze, burning away the thing stalking you from the shadows."))
    category:text(ccb.content.text("Your instincts warn you about something far more dangerous than you are, wandering the shadows to find you."))
    category:text(ccb.content.text("You long for proximity to vast waters and holy ground, no matter how uneasy you might be about them."))
    category:text(ccb.content.text("You feel a threatening presence.  Someone who desires nothing but killing vampires has their sights on you."))
    category:text(ccb.content.text("You have a passing thought about standing in unblocked sunlight, and how you would be safer in it than you currently are here."))
    category:text(ccb.content.text("Someone is coming to kill you.  You can feel them knowing where you are, waiting for the right moment to strike."))
    category:text(ccb.content.text("You are filled with the fear that a vampire will soon drink you dry.  You know that vampire blood is inedible to vampires, but you're still unsettled."))
    category:text(ccb.content.text("For a moment, the darkness doesn't feel like home.  It feels like a slaughterhouse, and you're next in line to be killed."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "blood_addiction" }
    category:entry {
        id = "blood_addiction_1",
        text = ccb.content.text("You need blood to survive."),
    }
    category:entry {
        id = "blood_addiction_2",
        text = ccb.content.text("A blood spattered charnel room flashes in front of your eyes."),
    }
    category:entry {
        id = "blood_addiction_3",
        text = ccb.content.text("You lick your teeth thinking about blood."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "blood_addiction_dream" }
    category:entry {
        id = "blood_addiction_dream_1",
        text = ccb.content.text("You dream of sneaking into a home through an open window late at night.  Walking through the darkened hallways, unerringly finding your way to a bedroom.  You stand at the foot of the bed staring down at the person sleeping in it.  Are they a man, woman or child?  You can't tell, all you know is they are filled with blood and you need it."),
    }
    category:entry {
        id = "blood_addiction_dream_2",
        text = ccb.content.text("In your dream, an early evening storm begins with you outside.  You feel the rain hitting you but it is thicker than water, more viscous.  You smell it first, before you look at your hands and realize the rain is blood.  You lean your head back and open your mouth wide to the rain falling into it."),
    }
    category:entry {
        id = "blood_addiction_dream_3",
        text = ccb.content.text("You float above a house late at night watching someone enter through an open window.  You blink and you are now in a bedroom seeing a disturbing scene.  Someone who's face is shadowed where you can't see them is standing over a person lying on the bed.  You startle when you realize that you are the person lying on the bed.  You scream helplessly as the shadowed person bites into sleeping you's throat and blood sprays across the room.  You wake as your struggles slow and lessen."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lotus_addiction" }
    category:entry {
        id = "lotus_addiction_1",
        text = ccb.content.text("You are sure you saw movement at the edge of your vision."),
    }
    category:entry {
        id = "lotus_addiction_2",
        text = ccb.content.text("The hair on the back of your neck rises as you hear a voice you remember from just out of sight."),
    }
    category:entry {
        id = "lotus_addiction_3",
        text = ccb.content.text("Your eye twitches on its own for several minutes.  From the top corner near your temple down into the cheek."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lotus_addiction_dream" }
    category:entry {
        id = "lotus_addiction_dream_1",
        text = ccb.content.text("You dream about watching TV, it's a documentary about some bioweapon that got loose in Newfoundland.  A doctor is talking about how containment failed and health campaigns failed to eradicate it.  You recognize the voice, it's your voice.  As the credits play you see listed '<full_name> M.D.'  This seems worrying."),
    }
    category:entry {
        id = "lotus_addiction_dream_2",
        text = ccb.content.text("You dream of walking down a long hallway with no definite beginning or end, portraits and mirrors alternate on the sides of the hallway.  Slowly you have a sneaking suspicion that your reflections aren't quite reflecting you.  Sometimes you spot out of the corner of your eyes distorted features, a mouth full of sharp teeth, different hair styles and colors, even horns.  Each time you turn and look though it's just your own reflection looking back at you.  You try one last time to catch your reflection and while you are staring into its eyes, you see the pupils track towards the portrait reflected behind you.  You turn your eyes to focus on the portrait reflection and there you are climbing out of the portrait mouth agape, full of too many needle sharp teeth, you quickly focus back at your reflection in the mirror and see only clear glass.  Before you can turn you feel a sharp pain in your shoulder."),
    }
    category:entry {
        id = "lotus_addiction_dream_3",
        text = ccb.content.text("You lounge in sunny glades, eating lotus blossoms while others frolic through the breeze.  You wake feeling calmer than normal and go back to less pleasant sleep."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "faewild_addiction" }
    category:entry {
        id = "faewild_addiction_1",
        text = ccb.content.text("You taste the magic, both bitter and sweet as if you had just dosed up."),
    }
    category:entry {
        id = "faewild_addiction_2",
        text = ccb.content.text("If you take some faewild now, the world will be brighter, your focus sharper, your odds of survival… higher."),
    }
    category:entry {
        id = "faewild_addiction_3",
        text = ccb.content.text("Once upon a time, there was a brave and stalwart knight, he partook of the dust of the faeries and knew peace everlong."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "faewild_addiction_dream" }
    category:entry {
        id = "faewild_addiction_dream_1",
        text = ccb.content.text("You wake up to the sounds of music outside of the house you are in.  When you exit the house, it is still the dead of night, but you can see a house across the way, well lit and open with people moving between the open doors.  Your dead relatives find you at the buffet and berate you for eating the food and drinking the drink at this party."),
    }
    category:entry {
        id = "faewild_addiction_dream_2",
        text = ccb.content.text("Hope is dead, it rode alone up to the gates of Hell.  It was crushed in a mass of people.  You were pushed away to the edges of the crowd.  The last you saw was hope pulled down screaming.  Nothing will ever have meaning again."),
    }
    category:entry {
        id = "faewild_addiction_dream_3",
        text = ccb.content.text("An otherworldly lover takes your heart, your passion, your desire.  Clad in diaphonous clothing, they take what you both want of you but soon you wake and realize you are alone in an empty bear's den."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "note_bloodthorne_druid" }
    category:entry {
        id = "xe_bloodthorn_note_01",
        text = ccb.content.text("The elders want me to write down what I feel during weekly meditations but I don't see the point.  I've never been good at concentrating.  I go out into the forest and I sit and pretty soon there's some bugs crawling on me or my back itches or I get a cramp in my leg and it breaks my concentration.  I've gotten pretty used to the heartvines moving, that's not the problem, it's the *other* stuff I can't get past.\n\nIt's weird, right?  You'd think that having a plant in my blood would be all I can think about but I got used to it in a week.  ̶A̶n̶y̶t̶h̶i̶n̶g̶ ̶i̶f̶ ̶I̶ ̶c̶a̶n̶  No, not yet.  I have to find the thing that did it, then I'll write it all down.  Now I just have to stop getting those cricks in my neck when I'm looking up through the leaves."),
        name = ccb.content.text("Meditations"),
    }
    category:entry {
        id = "xe_bloodthorn_note_02",
        text = ccb.content.text("Day 1: 1L.  Day 7: 1L.  Day 9: 1L.  Day 10: 3L donated blood provided.  Day 15: 1L.  Day 18: 1L.  Day 19: 3L donated blood provided.\n\nWe've been doing this for who knows how long and we still don't understand basic principles like \"How much do we get out based on what we put in?\"    Animal blood doesn't work, though, that's a constant.  We've tried cows, sheep, dogs, cats, pigs, rats, bats, everything we could think of and it just spat it all out.  Only human blood will do.\n\nI don't know why the elders allow this.  All the leeches need to die."),
        name = ccb.content.text("blood draws"),
    }
    category:entry {
        id = "xe_bloodthorn_note_03",
        text = ccb.content.text("Garlic does nothing and neither do holy symbols, at least not the ones we have access to though there are rumors of other vampire hunter groups that can make them work, sometimes.  They cross running water without problem.  One thing that does work is pulling them with our heartvines out into the sun.  The Elder Druid's have told the story of how Sol Invictus takes vengeance upon all vampires in punishment for a group of vampires violating his shrine and its supplicants during the Roman Republic.  Before that you needed to either annihilate the body or drain the blood of a vampire until it died.  Both methods still work, but sunlight is safer and easier."),
        name = ccb.content.text("vampire weaknesses"),
    }
    category:entry {
        id = "xe_bloodthorn_note_04",
        text = ccb.content.text("The sylvan spirits we have to hunt and kill to power our growth seem to be no allies to the vampires but also they don't seem to care enough to stamp out the vampire menace.  They seem to have little to no animosity against humanity but their sacrifice is made necessary by their refusal to act.  If they won't use their powers to destroy the vampires, we will."),
        name = ccb.content.text("nature spirits"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_BAD_DREAMS" }
    category:text(ccb.content.text("You have bad dreams."))
    category:text(ccb.content.text("Your dreams are terrifying."))
    category:text(ccb.content.text("In your dream, odd creatures circle you."))
    category:text(ccb.content.text("You dream a demon under your bed brushes your hand."))
    category:text(ccb.content.text("In your dream, your heart races like you just faced a bogeyman."))
    category:text(ccb.content.text("You dream panic seizes you suddenly with no discernible reason."))
    category:text(ccb.content.text("In your dream, a torrent of cold sweat runs down your back."))
    category:text(ccb.content.text("You dream; not sleeping might be the preferable option."))
    category:text(ccb.content.text("Fear grips you in your dreams."))
    category:text(ccb.content.text("In your dream, terrifying creatures surround you."))
    category:text(ccb.content.text("An infinitely hot wind scorches your face in your dream, leaving nothing but charred bone."))
    category:text(ccb.content.text("Enormous gravity crushes you against the ground in your dream until your bones are reduced to fine dust."))
    category:text(ccb.content.text("A strong wind lifts you up into the sky in your dream, only to let you plummet to your death."))
    category:text(ccb.content.text("Inhuman giants relentlessly hunt you in your dreams."))
    category:text(ccb.content.text("You are a toy of an unspeakable power in your dreams."))
    category:text(ccb.content.text("No one is willing to help you in your dream."))
    category:text(ccb.content.text("A shot to the face jolts you awake from your dream."))
    category:text(ccb.content.text("In your dream, you feel no better than the shambling dead."))
    category:text(ccb.content.text("You dream it might be better to be dead than existing in constant agony."))
    category:text(ccb.content.text("In your dream, there is no one to ask for help."))
    category:text(ccb.content.text("The night is so bright but you are all alone.  Voices from the darkness tell you to join them.  But your pride won't let you."))
    category:text(ccb.content.text("The world loses all its colors in your dream, leeching yours as well."))
    category:text(ccb.content.text("In your dream, pitch-black darkness surrounds you, with something pursuing you."))
    category:text(ccb.content.text("A sea of blood drowns you in your dream, rendering you unable to scream for help."))
    category:text(ccb.content.text("Shadows come to life in your dream, whispering your darkest fears."))
    category:text(ccb.content.text("You dream of endlessly falling through a void with no escape."))
    category:text(ccb.content.text("Your skin peels away in your dream, revealing nothing but emptiness underneath."))
    category:text(ccb.content.text("A room with no doors or windows traps you in your dream, the walls closing in."))
    category:text(ccb.content.text("You run through a forest in your dream where the trees are twisted faces screaming in agony."))
    category:text(ccb.content.text("A swarm of insects crawls out of your mouth and eyes in your dream."))
    category:text(ccb.content.text("You are buried alive in your dream, hearing the dirt being shoveled over you."))
    category:text(ccb.content.text("Strapped to a chair in your dream, a figure with a blank face approaches."))
    category:text(ccb.content.text("Reliving your worst memories on an endless loop haunts you in your dream."))
    category:text(ccb.content.text("Snakes slowly tighten their grip around you in your sleep."))
    category:text(ccb.content.text("In a house of mirrors in your dream, decaying versions of yourself stare back."))
    category:text(ccb.content.text("Your loved ones turn into monsters right before your eyes in your dream."))
    category:text(ccb.content.text("Lost in a labyrinth in your dream, the paths keep shifting and changing."))
    category:text(ccb.content.text("A train speeds towards a broken track with no way to stop it in your dream."))
    category:text(ccb.content.text("Naked and vulnerable on a stage, everyone laughs at you in your dream."))
    category:text(ccb.content.text("A shadowy figure chases you in your dream, and you can never escape."))
    category:text(ccb.content.text("In a graveyard in your dream, the tombstones have your name on them."))
    category:text(ccb.content.text("Paralyzed and unable to move, something approaches your bed in your dream."))
    category:text(ccb.content.text("Looking in a mirror in your dream, a stranger stares back."))
    category:text(ccb.content.text("Your teeth fall out one by one in your dream, leaving you unable to speak."))
    category:text(ccb.content.text("Surrounded by whispering voices in your dream, you can't understand what they say."))
    category:text(ccb.content.text("Your limbs turn to stone in your dream, making you unable to run from danger."))
    category:text(ccb.content.text("Stuck in an elevator in your dream, it keeps dropping and rising uncontrollably."))
    category:text(ccb.content.text("A field of dead flowers bursts into flames around you in your dream."))
    category:text(ccb.content.text("Lost at sea with no land in sight, something brushes against your leg in the water in your dream."))
    category:text(ccb.content.text("In a dark alley in your dream, every turn leads to a dead end."))
    category:text(ccb.content.text("An abandoned hospital's walls bleed in your dream."))
    category:text(ccb.content.text("Trapped under ice in your dream, people pass by above, unable to see you."))
    category:text(ccb.content.text("In a deserted city in your dream, footsteps follow you."))
    category:text(ccb.content.text("Surrounded by laughter that turns to screams in your dream."))
    category:text(ccb.content.text("Covered in a thick, suffocating fog in your dream, you can't find your way out."))
    category:text(ccb.content.text("Running, but your legs feel like they are made of lead in your dream."))
    category:text(ccb.content.text("Seeing your own grave in your dream, something is digging its way out."))
    category:text(ccb.content.text("Locked in a cage suspended over a bottomless pit in your dream."))
    category:text(ccb.content.text("In a forest in your dream, the trees have eyes that watch your every move."))
    category:text(ccb.content.text("A house where the floors creak and groan as if alive in your dream."))
    category:text(ccb.content.text("A room where the walls ooze black, tar-like substance that smells of death."))
    category:text(ccb.content.text("A giant spider weaves a web around you, and you can't move as it draws closer."))
    category:text(ccb.content.text("Your body starts to melt in your dream, and you can feel every excruciating moment."))
    category:text(ccb.content.text("You wake up in a morgue drawer, and you can hear the whispers of the dead around you."))
    category:text(ccb.content.text("In a dilapidated asylum, the patients with grotesque deformities reach out for you."))
    category:text(ccb.content.text("You see your reflection in a puddle, but it's someone else grinning back at you."))
    category:text(ccb.content.text("You are chained to a wall as water slowly fills the room, drowning you inch by inch."))
    category:text(ccb.content.text("In an old mansion, faceless children hold your hand, leading you to a dark cellar."))
    category:text(ccb.content.text("You find yourself in a butcher's shop, and you're the one being carved up."))
    category:text(ccb.content.text("Walking through a field of corpses, their eyes follow your every step."))
    category:text(ccb.content.text("You are in a church, and the congregation turns to reveal hollow, gaping mouths."))
    category:text(ccb.content.text("You fall into a pit of writhing maggots that consume you alive."))
    category:text(ccb.content.text("A carousel of dismembered bodies spins faster and faster around you."))
    category:text(ccb.content.text("Your limbs are twisted and contorted, leaving you unable to escape the horrors around you."))
    category:text(ccb.content.text("You are hunted by a monstrous creature that mimics the voices of your loved ones."))
    category:text(ccb.content.text("A plague of rats swarms over you, biting and clawing at your flesh."))
    category:text(ccb.content.text("Your skin turns to glass, and every movement causes it to crack and shatter."))
    category:text(ccb.content.text("You are trapped in a house where every door leads to a room filled with horrors."))
    category:text(ccb.content.text("The floor beneath you turns to quicksand, dragging you into the depths of darkness."))
    category:text(ccb.content.text("You are on an operating table, and the surgeon has no face, only a blank, smooth surface."))
    category:text(ccb.content.text("You are in a museum where the exhibits come to life and hunt you down."))
    category:text(ccb.content.text("Your veins fill with ice, freezing you from the inside out."))
    category:text(ccb.content.text("You are forced to watch as your loved ones are tortured and you are unable to help."))
    category:text(ccb.content.text("You find yourself in a carnival where the clowns are grotesque monsters that feast on flesh."))
    category:text(ccb.content.text("You are in a forest where the trees have faces that scream in agony as you pass by."))
    category:text(ccb.content.text("You are in a small boat in the middle of a storm, and the waves are made of blood."))
    category:text(ccb.content.text("Your body starts to rot while you are still alive, flesh falling away in chunks."))
    category:text(ccb.content.text("You are in a classroom where the teacher is a corpse, and the lesson is your own demise."))
    category:text(ccb.content.text("You are in a hospital where the doctors and nurses are stitched together from different bodies."))
    category:text(ccb.content.text("You are in a burning building, and the flames have faces that mock your pain."))
    category:text(ccb.content.text("You are in a maze where the walls close in, crushing you slowly."))
    category:text(ccb.content.text("You are buried alive in a coffin, and you can hear the dirt being shoveled on top."))
    category:text(ccb.content.text("You are in a dungeon where the torturer is a shadowy figure with no eyes."))
    category:text(ccb.content.text("You are in a library where the books scream when you open them."))
    category:text(ccb.content.text("You are in a graveyard where the tombstones bear your name, and the graves are open."))
    category:text(ccb.content.text("You are in a swamp where the water is filled with hands that try to drag you under."))
    category:text(ccb.content.text("You are in a laboratory where the experiments are on you, and the pain is excruciating."))
    category:text(ccb.content.text("You are in a house where the walls bleed, and the floors are made of bones."))
    category:text(ccb.content.text("You are in a factory where the machines have a mind of their own, and they want to crush you."))
    category:text(ccb.content.text("You are in a forest where the animals speak in riddles and threats, mocking your fear."))
    category:text(ccb.content.text("You are in a cave where the walls close in, and the darkness is alive."))
    category:text(ccb.content.text("You are in a room where the floor is covered in spiders, and they are crawling up your legs."))
    category:text(ccb.content.text("You are on a bridge where the ropes snap, and you fall into an abyss with no end."))
    category:text(ccb.content.text("You are in a field where the scarecrows come to life and chase you with knives."))
    category:text(ccb.content.text("You are in a house where the paintings change every time you look away, showing your worst fears."))
    category:text(ccb.content.text("Bones regrow flesh, then form laughing faces."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_SWEET_DREAMS" }
    category:text(ccb.content.text("You drift in gentle dreams."))
    category:text(ccb.content.text("Your sleep is wrapped in quiet wonder."))
    category:text(ccb.content.text("Strange but kind beings circle you like constellations."))
    category:text(ccb.content.text("Someone near the bed hums a lullaby and fades."))
    category:text(ccb.content.text("Your heart moves like a tide—steady, unafraid."))
    category:text(ccb.content.text("A sudden calm finds you, with no need for reason."))
    category:text(ccb.content.text("You dream that rest itself is a gift."))
    category:text(ccb.content.text("Peace takes your hand and does not let go."))
    category:text(ccb.content.text("Figures gather around you, warm as candlelight."))
    category:text(ccb.content.text("A golden wind passes over you, leaving only comfort."))
    category:text(ccb.content.text("The earth holds you gently, as if remembering your name."))
    category:text(ccb.content.text("You rise briefly, then return softly, unharmed."))
    category:text(ccb.content.text("Great shapes watch from afar, guardians rather than hunters."))
    category:text(ccb.content.text("An unexpected kindness changes the world for you."))
    category:text(ccb.content.text("Whenever you look up, help is already there."))
    category:text(ccb.content.text("You wake smiling, though you don't know why."))
    category:text(ccb.content.text("Your body feels lighter than thought."))
    category:text(ccb.content.text("You dream that living is enough."))
    category:text(ccb.content.text("Every question feels answered here."))
    category:text(ccb.content.text("Color seeps back into everything, richer than before."))
    category:text(ccb.content.text("Darkness folds around you like a blanket, not a threat."))
    category:text(ccb.content.text("You float in warmth, breathing without effort."))
    category:text(ccb.content.text("Shadows murmur encouragement and drift away."))
    category:text(ccb.content.text("You fly endlessly, but never downward."))
    category:text(ccb.content.text("Your form feels whole, seamless, complete."))
    category:text(ccb.content.text("A room without edges cradles you safely."))
    category:text(ccb.content.text("Trees lean in, faces softened into smiles."))
    category:text(ccb.content.text("Small wings stir the air with quiet joy."))
    category:text(ccb.content.text("You rest like a seed, knowing spring will come."))
    category:text(ccb.content.text("A presence sits with you, asking nothing."))
    category:text(ccb.content.text("Your best memories replay, gentler each time."))
    category:text(ccb.content.text("Something coils near you, not to bind but to warm."))
    category:text(ccb.content.text("Reflections meet your gaze and nod in approval."))
    category:text(ccb.content.text("Loved ones glow, unchanged and near."))
    category:text(ccb.content.text("Paths rearrange themselves to guide you home."))
    category:text(ccb.content.text("The journey moves forward without urgency."))
    category:text(ccb.content.text("You stand exposed and are met with applause."))
    category:text(ccb.content.text("Someone runs beside you, laughing, never chasing."))
    category:text(ccb.content.text("Stone markers bloom flowers instead of bearing names."))
    category:text(ccb.content.text("Stillness finds you, and it is kind."))
    category:text(ccb.content.text("The mirror shows you exactly as you are."))
    category:text(ccb.content.text("Your smile stays where it belongs."))
    category:text(ccb.content.text("Voices blend into a wordless song."))
    category:text(ccb.content.text("Your limbs remember how to move with ease."))
    category:text(ccb.content.text("You rise and fall smoothly, without fear."))
    category:text(ccb.content.text("Petals ignite into color, not flame."))
    category:text(ccb.content.text("The water carries you, asking nothing in return."))
    category:text(ccb.content.text("Every turn opens into light."))
    category:text(ccb.content.text("Walls glow with the promise of healing."))
    category:text(ccb.content.text("Footsteps match yours, friendly and familiar."))
    category:text(ccb.content.text("Laughter stays laughter."))
    category:text(ccb.content.text("Mist thins, revealing a path already waiting."))
    category:text(ccb.content.text("Running feels like flying, briefly remembered."))
    category:text(ccb.content.text("You see how far you've come, and rest."))
    category:text(ccb.content.text("Suspended, you are perfectly safe."))
    category:text(ccb.content.text("The house breathes slowly, patient with calm."))
    category:text(ccb.content.text("Dark stains fade into shadow and then nothing."))
    category:text(ccb.content.text("Silk threads shimmer, never tightening."))
    category:text(ccb.content.text("Your body loosens, pain forgotten."))
    category:text(ccb.content.text("You wake among quiet voices wishing you well."))
    category:text(ccb.content.text("Broken places show signs of repair."))
    category:text(ccb.content.text("The face in the water smiles back, true."))
    category:text(ccb.content.text("Water lifts instead of filling."))
    category:text(ccb.content.text("Small hands guide you upward, laughing."))
    category:text(ccb.content.text("Knives become tools, then vanish."))
    category:text(ccb.content.text("The field is quiet; nothing watches now."))
    category:text(ccb.content.text("Hollow mouths fill with song."))
    category:text(ccb.content.text("The earth receives you and gives you back."))
    category:text(ccb.content.text("The spinning slows into music."))
    category:text(ccb.content.text("Your shape returns to itself."))
    category:text(ccb.content.text("Familiar voices call you safely home."))
    category:text(ccb.content.text("Animals pass without fear, eyes bright."))
    category:text(ccb.content.text("Every door opens into wonder."))
    category:text(ccb.content.text("The ground is firm beneath your feet."))
    category:text(ccb.content.text("Hands mend rather than break."))
    category:text(ccb.content.text("Still figures move only to teach."))
    category:text(ccb.content.text("Cold turns crisp, refreshing."))
    category:text(ccb.content.text("You watch others thrive and feel no loss."))
    category:text(ccb.content.text("Painted faces laugh and mean no harm."))
    category:text(ccb.content.text("Trees sing, and you understand none of it—yet still smile."))
    category:text(ccb.content.text("Waves glow dark red, beautiful and distant."))
    category:text(ccb.content.text("Your body renews itself in quiet increments."))
    category:text(ccb.content.text("Lessons end in understanding, not confusion."))
    category:text(ccb.content.text("Many hands work together to heal."))
    category:text(ccb.content.text("Fire becomes warmth, light without pain."))
    category:text(ccb.content.text("The walls retreat, granting space."))
    category:text(ccb.content.text("You rest enclosed, completely safe."))
    category:text(ccb.content.text("Shadows thin and dissolve."))
    category:text(ccb.content.text("Books sigh with old wisdom."))
    category:text(ccb.content.text("Names fade into flowers and memory."))
    category:text(ccb.content.text("The water releases you gently."))
    category:text(ccb.content.text("Experiments end in restoration."))
    category:text(ccb.content.text("Riddles become jokes you almost understand."))
    category:text(ccb.content.text("Stone opens to let light in."))
    category:text(ccb.content.text("Small legs scatter, harmless and gone."))
    category:text(ccb.content.text("The bridge holds though the earth shakes."))
    category:text(ccb.content.text("The chase becomes a game."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "snippet_drained_by_lilit" }
    category:text(ccb.content.text("You dream of falling through darkness."))
    category:text(ccb.content.text("You dream of whistling winds as you stand on a mountaintop."))
    category:text(ccb.content.text("You dream of the moon growing larger and larger, filling the sky."))
    category:text(ccb.content.text("You dream of walking through the forest and suddenly seeing an owl fly past you, so close you could touch it."))
    category:text(ccb.content.text("You dream of something sitting on your chest, suffocating you."))
    category:text(ccb.content.text("You dream of slipping under dark water, none of your attempts to swim keeping you afloat."))
    category:text(ccb.content.text("You dream of standing in a dark room, being buffeted by silent wings."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "undead_wake_up" }
    category:text(ccb.content.text("You wake to the next night of forever."))
    category:text(ccb.content.text("You wake having had no dreams."))
    category:text(ccb.content.text("Dreams?  Dreams are for the living."))
    category:text(ccb.content.text("Blood!  You must have it."))
    category:text(ccb.content.text("Some nights you miss dreams, like you miss the sun."))
    category:text(ccb.content.text("Why don't you dream?  Is it a gift from the soul and yours is gone?"))
    category:text(ccb.content.text("Will you dream again after the final death?"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lilin_wake_up" }
    category:text(ccb.content.text("The deep heart of the night."))
    category:text(ccb.content.text("An endless cycle of moons."))
    category:text(ccb.content.text("An empty barn, an abandoned warehouse, both call to you the same."))
    category:text(ccb.content.text("Owls diving at their prey."))
    category:text(ccb.content.text("Night after night the coughing grows louder in the village below until slower the village becomes quieter until one night it is silent."))
    category:text(ccb.content.text("Flight over and out of the desert, to the places where men live."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "fae_wake_up" }
    category:text(ccb.content.text("Seasons pass and change without end."))
    category:text(ccb.content.text("The leaves change colors, fall, and bloom again."))
    category:text(ccb.content.text("The song of the world humms in your bones, whistles past your ears and burrows into your eyes."))
    category:text(ccb.content.text("A memory of iron… Is it yours or some kind of racial memory?"))
    category:text(ccb.content.text("Water erodes the rock into soil and sand, the sapling pushes up through the cracks, lighting strikes the tree and sets it on fire, a human looking hand picks up the fire blackened staff."))
    category:text(ccb.content.text("What will you do with eternity if you can grasp it?"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "gracken_wake_up" }
    category:text(ccb.content.text("…"))
    category:text(ccb.content.text("…"))
    category:text(ccb.content.text("…."))
    category:text(ccb.content.text("…"))
    category:text(ccb.content.text("…………"))
    category:text(ccb.content.text("…bzzzpt…"))
    category:text(ccb.content.text("…kachunk……"))
    category:text(ccb.content.text("mi-go chan"))
    category:text(ccb.content.text("darkness, endless darkness"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "vampire_infected_fae_wake_up" }
    category:text(ccb.content.text("Your dreams are filled with nothing but blood and drinking it.  As long as you are a vampire, your growth as a fae will be blocked."))
    category:text(ccb.content.text("Your dreams are those of the undead.  Until you cure yourself from their infection, your dreams will not help you grow."))
    category:text(ccb.content.text("You wake up from a dreamless sleep.  You must purge that illness if you wish to have your fae dreams back."))
    category:text(ccb.content.text("Your nascent vampirism is muddling your dreams, making them unfit to empower you."))
    category:text(ccb.content.text("Nothing in this dream but blood and darkness.  Only curing this illness can restore your ability to grow."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "local_files_xedra" }
    -- Messages, logs and videos, that xedra agent may have on it's laptop
    category:entry {
        id = "local_files_xedra_1",
        text = ccb.content.text("*A half-hour-long tape that films a static building in the middle of nowhere with a bright, clean sky in the background.  The building is tall, thick, and covered in some white mush, while the windows move in a zigzag pattern.  Twenty minutes later, the camera captures a heavy aircraft that starts to move in circles around the building.  In a few minutes, a massive volley erupted from the plane, which made the building rip and burn apart, and its dwellers - small spike-like creatures that move by rolling - quickly ran away, screaming in piercing shrieks while their white spikes melted.*"),
        name = ccb.content.text("bombing run"),
    }
    category:entry {
        id = "local_files_xedra_2",
        text = ccb.content.text("need_to_discuss.mp4\n*It seems to be a part of some video for a newcomer mortician.*\nHost: … Oh, and also, do you remember those small pieces of metal we found covering the skin?  I recommend not throwing it away, but cleaning it up and storing it in some bag - apparently zebra departments really like to buy some of them for a whopping price.\nCameraman: Do you know why?\nHost: I don't give a shit actually, but 50 bucks per month is 50 bucks per month."),
        name = ccb.content.text("morticians apprenticeship"),
    }
    category:entry {
        id = "local_files_xedra_3",
        text = ccb.content.text("record_17.06.mp3\n[Voice 1]: I'm here.\n[Voice 2]: And?\n[Voice 1]: As the report said.\n[Voice 2]: Fuck.\n*few seconds of complete silence*\n[Voice 2]: So it's completely impossible to move it?\n[Voice 1]: Correct, completely glued.\n*another few seconds of complete silence*\n[Voice 1]: So, in summary, we have a bullet, stuck in the air and completely immovable, in the middle of fucking nowhere.  I think I've seen something similar before…"),
        name = ccb.content.text("the immovable bullet"),
    }
    category:entry {
        id = "local_files_xedra_4",
        text = ccb.content.text("*cached messages in some chat app*\nB0yscout(Bravo 7): so, do you guys know what's going on?\nJackTrader(PD): wdym?\nB0yscout(Bravo 7): i mean the fuck is going on with the world?  when i just came here, you guys tried to solve a vampire disease, then a shifter overpopulation, and yesterday my unit happened to fight A MOTHERFUCKING ANGEL!  ANGEL!!!\nB0yscout(Bravo 7): am i tripping, or are we living in some junk novel, written by idiots without any sense of… eeh… you get it\nJackTrader(PD): oh\nJackTrader(PD): …\nJackTrader(PD): hmm, what do i say\nJackTrader(PD): it's actually pretty serious topic\nJackTrader(PD): i'd even say it's impossible to solve, because we can't really measure why this happens, and why that happens\nJackTrader(PD): but\nB0yscout(Bravo 7): :eyes:\nJackTrader(PD): we talked about it with @WHO and a few other folks from the paranormal department, and we think there are a few possibilities\nJackTrader(PD): the official one is that the portal shit is so massive, that the probability of us meeting something, that resembles our folklore is not that small\nJackTrader(PD): like you met a wheeled ball with feathers yesterday, but did you see a square of light, that spoke perfect english?\nJackTrader(PD): i did\nB0yscout(Bravo 7): i'm not surprised\nB0yscout(Bravo 7): i guess the juice is in the unofficial versions?\nJackTrader(PD): the first unofficial version, that we hope is correct, is that there were portal outbreaks before, and it's just not the first time planet Earth fights the vampire invasion or shit\nB0yscout(Bravo 7): why isn't it official?\nJackTrader(PD): because people are idiots, mostly.  Imagine if POTUS made a speech saying \"do you remember all this shit about satan and unicorns and loch ness?  well it's actually true.  except satan.  maybe\"\nB0yscout(Bravo 7): and?\nJackTrader(PD): you'd be surprised how much overlap there is between people who ~~think~~  thought unicorns are real, and people who think we should kill all jews\nB0yscout(Bravo 7): okay that makes sense\nB0yscout(Bravo 7): that's the only unofficial theory you discuss?\nJackTrader(PD): we thought about another one, but it's much, much worse\nJackTrader(PD): that the stuff, that invades our world, can connect to some sort of noosphere and thing, and can read our thoughts\nJackTrader(PD): as they know everything we are afraid of\nJackTrader(PD): demons\nJackTrader(PD): vampires\nJackTrader(PD): diseases\nJackTrader(PD): nuclear war\nB0yscout(Bravo 7): …\nB0yscout(Bravo 7): …\nB0yscout(Bravo 7): is it classified?\nJackTrader(PD): …oh shit "),
        name = ccb.content.text("messages that shouldn't have been sent in the open"),
    }
    category:entry {
        id = "local_files_xedra_5",
        text = ccb.content.text("SAATUIOW_1/6.mp4\n*The video seems to be a record of some drill in a large classroom.  The first few minutes are spent preparing the projector, then a person comes to the lectern*\nGood morning everyone, my name is *illegible*, and I am the assistant of doctor *illegible*.\nToday's lesson would be pretty general, because it's a theme on which we still lack information and a lot must be discussed.  We also don't have proper terms, so don't be surprised if part of it is picked from game slang and part from fantasy novels.  The lesson would be more than experimental.\nOkay.  You saw the name of the lesson before, it has a long, unreadable name, but overall it is described as \"magic\".  Yes, magic, because we still don't know why and don't know how it works.  You may hear a story about an altered objects that doesn't work, works in the wrong way, does something different, or even harms the user, but most of you don't know - No, Jamey, I know you know it, you are our consultant here, not a student.\nYes, I forgot to present: this is Jamey, he is our retired field agent and a pretty experienced eater.  More on that later.\nSo yes, you don't know… *The lecturer silently watches at Jamey for a few seconds*… that some \"subjects\" - I say \"subjects\", because some of them are not humans, we saw a similar result from apes, dogs, rats, and even, uh, was it a computer program?… Anyway, some \"subjects\" can not only touch these items without self-harm, but they can also, eh, use them?  It's not really \"using\", we think they'd rather \"redirect\" their paranormal properties into a more acceptable form.  Yes, they \"redirect\" the power, energy, mana, you name it, into a direction that gives them supernatural abilities.  They are not really limited, some individuals are able to use all of them, but most are not - the rules of these processes are unclear, so we classified them into a few branches…"),
        name = ccb.content.text("Supernatural Abilities And Their Usage In Operative Work_5/6.mp4"),
    }
    category:entry {
        id = "local_files_xedra_6",
        text = ccb.content.text("SAATUIOW_2/6.mp4\n…The first branch utilizes \"the knowledge\", people of this type \"know\" how to make tools, that seem impossible without decades of development or that violate a huge part of the physical laws we all know.  They are our most valuable resource: engineers that can build a railgun using M16 parts, assemble an EMP bomb using only a PlayStation and a few tools, a phone camera that sees through the walls, a Humvee engine that can use whiskey as fuel *cough cough*… yeah, the list of their abilities is pretty huge, and they can provide these tools to other users.  Sadly, they do not last long outside of their hands, breaking apart in a few weeks.\n- *illegible*\nNo, there is no correlation between the user's IQ and the time it stopped working, we thought about it already.\n- *illegible*\nYes, I know about Worm, and yes, it is surprisingly accurate in this part…\n…\n…\nOverall, their abilities are really wide, but it is really hard to differentiate them from their usefulness - currently we have only a few prototypes, useful for field agents like you, and a dozen of toothbrushes, modified to clean teeth better.  Two of them expect to be lethal.  Currently, most of them are busy with the \"Legion\" project in an attempt to turn the table, you may check about it later…"),
        name = ccb.content.text("Supernatural Abilities And Their Usage In Operative Work_2/6.mp4"),
    }
    category:entry {
        id = "local_files_xedra_7",
        text = ccb.content.text("SAATUIOW_3/6.mp4\n…The second branch utilizes, eh, \"the ethereal\" or \"extradimensional\" thingy, we like to name them \"dealers\".  Now I think it's a bad idea to split them like this, but anyway.  So yeah, it is easy to detect dealers, because some interdimensional creatures, usually hostile to humans, do not attack them.  We think they can kind of make a \"deal\" with sapient creatures, and yes, every creature they deal with is sapient, in one form or another, and I also don't understand how it works, that's what they told me.  Eeh, yeah, they \"deal\" with these creatures from the other side, they spend their life energy to merc them.  The one who was capable of talking said it was a pleasant dish, the same as our pancakes.  The ability to use such things is not cheap, and many dealers disappeared in unknown circumstances, but let's not talk about it…"),
        name = ccb.content.text("Supernatural Abilities And Their Usage In Operative Work_3/6.mp4"),
    }
    category:entry {
        id = "local_files_xedra_8",
        text = ccb.content.text("SAATUIOW_4/6.mp4\n…Another one is our hard workers - our smiths.  They are not as dreadful as technicians in their abilities, they can not create a nuke out of a microwave, but they can create something that even technicians can't understand.  At least the best of them, most of our smiths produce common tools and armor we use in our work.  You may think they are \"worse\", or \"weaker\" than other branches, or you may think they are some dumb blue collars.  And that's mostly right.  Mostly.  But… But…\nDid you ever see an anti-tank bow?  The bow that can throw arrows at a rifle distance, penetrate the armored vehicle, and kill a whole squad inside, while being completely silent?  I saw one, and it was a damn great experience.\n- *illegible*\nAre you a smith?\n- *illegible*\nYou are pretty smart, then.  Yes, that's their biggest advancement - their products do not fade as fast as technicians' work.  The second most beneficial part of their work is the material they use.  It has a complicated, unpronounceable name, but we simply call it \"dross\".  There is a group of people that like to call it \"dreamdross\" and overall have some \"dream\" fetish with this arcane stuff, but hell we are serious organizations if our researchers are inspired by some \"dreams can come true\" bullshit.  Anyway, dross is the main part of two branches: for smiths and for eaters.  The substance-producing process is pretty tricky, because you need to find a person with a magic inclination - usually it's a person touched by altered objects, creatures, or altered event victims, but there are exceptions: our consultant Jamey has had no contact with portals before yet happened to be a talented eater…  *illegible* *cough cough*…  So yes, you need to find such a person and teach them how to produce it.\n- *illegible*\n- Yes, there is situations, where common people produce some amount of dross after death, why do you ask?\n- *illegible*\n- [Lector stares at the questioner for a good ten seconds.]\n…How useful… may be the strategy… where we… kill… innocent people… just to find some dross?\n…\n…\n…I think I'll be fired… If I do not say \"we will never kill an innocent to get some resources\", but okay, theorizing, it's not viable still - the amount of dross we can obtain in such a way is negligible.  But again, don't even ask about it again.\nTurning back to dross, the exact characteristics of the material…  are not great.  It's pretty fragile, loose, and light - totally not a thing you can use to make a weapon - strong and sturdy.  But of course, it's not the main property of metal.  The main feature of the metal is its ability to accept and process magic.  Any magic, I'd say, but it's not true, some stuff we can't do at all, and some stuff can only be done by high level smiths.  It's not a big surprise, but even the senior smiths are able to make a huge variety of stuff with improved effects.  The most popular option is hardening, of course.  So, most items that are made fully from dross or use dross inserts are usually not that much stronger than steel stuff but lighter - sometimes so much lighter it has no weight at all - if I recall correctly, our DSAPI has a weight of like 500 grams or so?  You get the idea…"),
        name = ccb.content.text("Supernatural Abilities And Their Usage In Operative Work_4/6.mp4"),
    }
    category:entry {
        id = "local_files_xedra_9",
        text = ccb.content.text("SAATUIOW_5/6.mp4\nAnd the last branch we separate is a branch of eaters.  There is nothing really special about them; compared to any other branch, they do not have some really odd abilities like summoning creatures or throwing fireballs.  Instead, all magic that happens with them is limited to their own bodies, and oh god, how good they are at this.  They are meat tanks.  Not in the sense that they transform their bodies or something like this, no.  Totally not.  They just can do the same stuff as tank - break asphalt while running at 60 miles per second and throw fifty kilo balls with sniper precision.\nA simple example for you: do you see our friend here?  How strong do you think he is?  I mean, right now, when there is an army of soldiers, SWAT, and people from the police department, if you have your weapon with you, how many of you may a single Jamey kill?\n- *illegible*\n- Two?\n - *illegible*\n- Five?\n- *illegible*\n- Dozen?\n- *illegible*\nOkay.  Believe me, even without his right hand, Jamey can kill all of you.  Then he can move to the office room next to us and kill all the people there, and then next, and then next, and then he can just demolish this whole building.  Yes, it is reinforced, can survive the 155-millimeter shot.  Yes, Jamey still has only one hand.  Yes, nothing will be left behind.  Am I right, Jamey?\n-*illegible*\nOh, you are not an operative, so you won't do it.  Yeah, you also know it's bullshit and they won't kick you off because of one failure, do you?"),
        name = ccb.content.text("Supernatural Abilities And Their Usage In Operative Work_5/6.mp4"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "local_files_simple" }
    -- This is extending the vanilla snippets belonging to mostly work of random people: chat logs, SMSes, popular photos and videos that people share, or something they can film by themselves.
    category:entry {
        id = "xe_local_files_simple_1",
        text = ccb.content.text("hunternetvulfgar.mp4\nThe video cuts in as a montage of school security cameras in hallways, as a young man and woman break into the school.  As they walk past each camera, that image drops and the others rearrange larger, while a popular song from the 90's begins playing.  The young adults enter a classroom and are clearly flirting.\nAwoo oooh, got you where I want you\nplays over top of the video.  The man laughs at something the woman says, and throws his head back laughing while she is clearly annoyed.  His face elongates as his body grows, shredding the clothes he is wearing as limbs change and sprout thick fur.  She has backed away from him and put the students' and teacher's desks between them.  Fully transformed into a hideous wolfman, he begins his approach towards his once date now prey, smashing chairs and students' desks out of his way.  Suddenly the wolfcreature pauses and its ears prick up.  It turns and looks at the wall of windows in the classroom.  Glass erupts into the room as the darkness outside the window shows the muzzle flare of at least a dozen different guns firing.  The wolfcreature is hit more times than you can count in a span of seconds and falls to the ground.\nThe song reaches a crescendo 'Got you where I want you, got you, yeahhhhh!' as his date pulls a large caliber pistol out of the teachers desk, walks over to the fallen beast and calmly puts three bullets in its skull.  The video ends."),
        name = ccb.content.text("cryptid sighting werewolf"),
    }
    category:entry {
        id = "xe_local_files_simple_2",
        text = ccb.content.text("hunternetlinda.mp4\nElectronic music plays on a black screen.  Text appears on the screen\n'Stand still, pause clocks, we can make the world stop'\nA video montage follows a woman across multiple days and outfits.  On errands, at work, traveling in different cities.  About a minute into the montage of video there are short cuts to her violently attacking people in secluded settings.  Those gradually become the dominant images until it's only video of her feasting on the blood of her fallen victims.  The final image is her looking up; face covered, blood dripping down onto her ruined outfit; eyes staring straight into the camera as the image freezes.  On the now black screen, a name and address appear."),
        name = ccb.content.text("cryptid sighting vampire"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<XE_NIGHT_MESSAGES_GENERAL_1>" }
    category:text(ccb.content.text("The clopping of hooves pass you by with a swift breeze, yet you did not see anything except for local flora brushed by the wind."))
    category:text(ccb.content.text("As you are walking you suddenly hear a woman singing mournfully.  As you look around trying to see where the sound is coming from you slowly realize that if you take more than a step and a half in any direction the song fades away.  Eventually you are unable to find it again."))
    category:text(ccb.content.text("Something roars in the night, similar sounding to one of the Kaiju you heard destroying a nearby town during the Cataclysm."))
    category:text(ccb.content.text("The night suddenly goes dead silent."))
    category:text(ccb.content.text("You hear a wolf howl in the distance, swiftly joined by several others.  After a moment of silence, you hear another series of howls, and then another.  It's only after the third set fades that you realize the howls were all in exactly the same pattern; two long, three short."))
    category:text(ccb.content.text("You hear a scream in the distance.  Probably a deer or a bobcat, but it sure sounded like a human."))
    category:text(ccb.content.text("Disturbed by your approach, a small animal darts away into the underbrush.  It's only after it disappears that you realize it had six legs."))
    category:text(ccb.content.text("Your ears pop, leaving behind a high-pitched whine that fades as normal sounds slowly return."))
    category:text(ccb.content.text("For a moment, the air smells so strongly metallic that you can almost taste it."))
    category:text(ccb.content.text("You hear a rush of unfelt wind."))
    category:text(ccb.content.text("The wind makes a low murmur that sounds almost like words.  When you stop to pay attention to it, it falls silent."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_NIGHT_MESSAGES_CLEAR_1" }
    category:text(ccb.content.text("<XE_NIGHT_MESSAGES_GENERAL_1>"))
    category:text(ccb.content.text("<XE_NIGHT_MESSAGES_GENERAL_1>"))
    category:text(ccb.content.text("<XE_NIGHT_MESSAGES_GENERAL_1>"))
    category:text(ccb.content.text("<XE_NIGHT_MESSAGES_GENERAL_1>"))
    category:text(ccb.content.text("<XE_NIGHT_MESSAGES_GENERAL_1>"))
    category:text(ccb.content.text("Winged shadows cross the ground, but when you look into the sky you can't see any movement or shapes."))
    category:text(ccb.content.text("There is a bright red star with a dark heart that looks like a pupil, staring down on you from the sky above.  Is that star in the sky every night?  Is it coming closer to the planet?"))
    category:text(ccb.content.text("A helicopter passes by overhead.  All its running lights have been blacked out and you suspect the rotors have been muffled.  If it hadn't passed right over you, you'd have never known it was there."))
    category:text(ccb.content.text("Something passes across the moon for a moment, completely blotting it out."))
    category:text(ccb.content.text("A shooting star flashes across the sky."))
    category:text(ccb.content.text("A pair of owls flies by, so close that they're almost wingtip to wingtip."))
    category:text(ccb.content.text("For a moment, all the stars turn a dim reddish color."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_NIGHT_MESSAGES_CLOUDY_1" }
    category:text(ccb.content.text("<XE_NIGHT_MESSAGES_GENERAL_1>"))
    category:text(ccb.content.text("<XE_NIGHT_MESSAGES_GENERAL_1>"))
    category:text(ccb.content.text("<XE_NIGHT_MESSAGES_GENERAL_1>"))
    category:text(ccb.content.text("<XE_NIGHT_MESSAGES_GENERAL_1>"))
    category:text(ccb.content.text("A single raindrop falls on your exposed skin.  You look up, but no further droplets fall."))
    category:text(ccb.content.text("Something above the clouds glows, creating a hazy patch of light.  It stays in place for a few moments before speeding away to the <random_direction>."))
    category:text(ccb.content.text("You see the vague outlines of a humanoid figure in the distance.  As soon as you catch sight of it, there is a blur of motion and it vanishes."))
    category:text(ccb.content.text("You step in a small puddle, but when you bend down to look, there's nothing there."))
    category:text(ccb.content.text("You feel something tap on your shoulder but when you spin around to look, there's no one there."))
    category:text(ccb.content.text("You hear a slithering sound in the distance.  It's far enough away that whatever is making it must be very large."))
    category:text(ccb.content.text("You hear a cracking sound and then the night falls totally silent."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_DAY_MESSAGES_1" }
    category:text(ccb.content.text("You realize that all of your empty pockets have been turned inside out.  How long ago this happened you can't say."))
    category:text(ccb.content.text("You hear a tinkling sound on the wind."))
    category:text(ccb.content.text("A horn plays somewhere far in the distance; deep, mournful, and low."))
    category:text(ccb.content.text("Suddenly you smell rotten wood and tobacco."))
    category:text(ccb.content.text("You hear a distant explosion.  You can't tell if it came from one of the tendrils of smoke at the edge of your vision or if it's new."))
    category:text(ccb.content.text("A single shot fires in the distance then silence."))
    category:text(ccb.content.text("The birds are no longer singing here.  It's quiet, scary quiet."))
    category:text(ccb.content.text("A rare plane leaves contrails high in the sky.  You wonder where it could be coming from and where it could possibly be going."))
    category:text(ccb.content.text("The sunlight seems to dim for a moment.  When you blink, it's as bright as it was before."))
    category:text(ccb.content.text("Your footstep suddenly crunch loudly.  When you look down, the ground beneath you is carpeted with dead insects."))
    category:text(ccb.content.text("The grass nearby is trampled down in a sinuous pattern."))
    category:text(ccb.content.text("The air suddenly smells sickly sweet."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_SCRAGGY-BOO_MESSAGES_1" }
    category:text(ccb.content.text("<color_light_blue>You see a Russian sheepdog off at the edge of your vision.  It walks past some scenery and vanishes.</color>"))
    category:text(ccb.content.text("<color_light_blue>You hear a deep guttural howl, faintly across the way.</color>"))
    category:text(ccb.content.text("<color_light_green>In your mind you hear a voice, as if a big dog were speaking English.  'It's dangerous here, this whole world is dangerous now'.</color>"))
    category:text(ccb.content.text("<color_light_green>Scraggy-boo speaks in your mind.  'The real mystery is how to survive this place'.</color>"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_BOOK_LIES_CARRIED" }
    category:text(ccb.content.text("<color_light_red>You catch a small glimpse of something.  The only thing you understand is how disturbed it makes you feel.</color>"))
    category:text(ccb.content.text("<color_light_red>You imagine yourself reading that creepy book.  Your mind reels at the idea.</color>"))
    category:text(ccb.content.text("<color_light_red>For the smallest instant, the veil hiding the truth shows a crack.  What little you see shocks you to your very core.</color>"))
    category:text(ccb.content.text("<color_light_red>Your proximity to this damned book is slowly melting your mind.</color>"))
    category:text(ccb.content.text("<color_light_red>You feel a deep longing to leave a certain book behind you.</color>"))
    category:text(ccb.content.text("<color_light_red>Your mind is on fire.  You must get rid of this book or the fire won't end.</color>"))
    category:text(ccb.content.text("<color_light_red>How cathartic it would be to tear the pages from that cursed book.  You ache to get rid of it as soon as possible.</color>"))
    category:text(ccb.content.text("<color_light_red>Your mind can only think about that book for a moment.  You skull fills with pressure like a balloon about to pop.</color>"))
    category:text(ccb.content.text("<color_light_red>That book you found near a shredded corpse makes you dread being shredded in turn.</color>"))
    category:text(ccb.content.text("<color_light_red>You suddenly feel saddened.  Maybe dropping that blood-stained book would make you feel better?</color>"))
    category:text(ccb.content.text("<color_light_red>The Lies hate that you're carrying that book and decided to make their sentiment known.</color>"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "nightmares_book_lies" }
    category:text(ccb.content.text("<color_light_red>You dream of a world of burning paper below a single intact book.</color>"))
    category:text(ccb.content.text("<color_light_red>You awaken from a nightmare about a book eating your brain.</color>"))
    category:text(ccb.content.text("<color_light_red>You stand on a line of letters above a bottomless pit.  They crack.  You fall.  You wake up.\nThis time.</color>"))
    category:text(ccb.content.text("<color_light_red>You wake up knowing that you will soon pay for what you've done.</color>"))
    category:text(ccb.content.text("<color_light_red>You dream about being torn apart by unseen claws.</color>"))
    category:text(ccb.content.text("<color_light_red>In your dream, you had a cat.  Like the cat, curiosity killed you.  Unlike the cat, you had far less lives and died far more times.</color>"))
    category:text(ccb.content.text("<color_light_red>You dream about white-hot nails burrowing in your head, each of them whispering things you do not want to hear.</color>"))
    category:text(ccb.content.text("<color_light_red>You wake up with a phrase resounding in your skull over and over: CLEAVE THROUGH THE WORLD OF LIES.</color>"))
    category:text(ccb.content.text("<color_light_red>You dream about being unraveled, the strands making you falling to the ground.</color>"))
    category:text(ccb.content.text("<color_light_red>You dream about silent voices ordering other things to kill you.</color>"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "book_lies_taint_resisted" }
    category:text(ccb.content.text("<color_light_red>The Lies are unraveling you as you dared resist them.</color>"))
    category:text(ccb.content.text("<color_light_red>Small strands of skin and muscle are leaving your body and piling on the floor.</color>"))
    category:text(ccb.content.text("<color_light_red>Strand by strand, you are slowly unmade by the Lies.</color>"))
    category:text(ccb.content.text("<color_light_red>You do not know enough to avoid what is happening to you, but you know enough for it to happen.</color>"))
    category:text(ccb.content.text("<color_light_red>Another small strand is plucked from you and discarded.</color>"))
    category:text(ccb.content.text("<color_light_red>If you stop reading this book, you will stop unraveling.</color>"))
    category:text(ccb.content.text("<color_light_red>Better stop provoking the Lies, before they take something important.</color>"))
    category:text(ccb.content.text("<color_light_red>If the eyes cannot stop you from reading this, the claws will.</color>"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "book_lies_claw" }
    category:text(ccb.content.text("<color_light_red>You've gone too far, and the Lies will destroy you for it.</color>"))
    category:text(ccb.content.text("<color_light_red>An unseen claw grievously rends your flesh.</color>"))
    category:text(ccb.content.text("<color_light_red>You notice a gaping wound you did not had a second ago.  Reading this book is killing you.</color>"))
    category:text(ccb.content.text("<color_light_red>You know too much about the Lies, and they are trying to remedy to that.</color>"))
    category:text(ccb.content.text("<color_light_red>Five invisible blades tear open your skin, leaving a horrible wound.</color>"))
    category:text(ccb.content.text("<color_light_red>A horrendous wound opens on its own as you read another word from this book.</color>"))
    category:text(ccb.content.text("<color_light_red>Reading this book feels like a dagger against your sanity.  Its effects on your body are more tangible.</color>"))
    category:text(ccb.content.text("<color_light_red>The Lies are sending a clear message: stop reading the book or die by their hand.</color>"))
    category:text(ccb.content.text("<color_light_red>A chunk of flesh is torn from your body by something you cannot perceive.</color>"))
    category:text(ccb.content.text("<color_light_red>You will be cleaved before you can cleave anything unless you stop reading this book.</color>"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<hunter_reason_a>" }
    -- They're all about why hunters can't do much against vampires currently, explaining why they're enlisting the player and sending them alone for the non-hardest missions.
    category:text(ccb.content.text("the zombies"))
    category:text(ccb.content.text("the encroaching fungus"))
    category:text(ccb.content.text("the walking murderous plants"))
    category:text(ccb.content.text("the creatures from the holes in existence"))
    category:text(ccb.content.text("the hostile changelings"))
    category:text(ccb.content.text("the roaming bandits"))
    category:text(ccb.content.text("the mutated animals"))
    category:text(ccb.content.text("the giant insects"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<hunter_reason_b>" }
    category:text(ccb.content.text("the collapse of society"))
    category:text(ccb.content.text("supplies being much harder to obtain"))
    category:text(ccb.content.text("the electrical grid being down"))
    category:text(ccb.content.text("having lost contact with other hunter groups"))
    category:text(ccb.content.text("food being much harder to find"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<hunter_reason_c>" }
    category:text(ccb.content.text("most vampires being ignored by the zombies"))
    category:text(ccb.content.text("the remaining survivors being more open to collaborating with vampires"))
    category:text(ccb.content.text("the harder times increasing the amount of potential vampires"))
    category:text(ccb.content.text("the vampires' brainwashed slaves seeking hunters to kill for their masters"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "museum_plaques_items" }
    category:entry {
        id = "museum_plaques_items_1",
        text = ccb.content.text("Discovered in an estate sale in upper Chappaquiddick these baubles were labeled as the owners most precious possessions and proof of other worlds."),
        name = ccb.content.text("Alternate Worlds Exhibit 1"),
    }
    category:entry {
        id = "museum_plaques_items_2",
        text = ccb.content.text("Found in a Boston pawn shop, the owner claimed that late one night a strange person entered the establishment and handed over this collection of items for 'whatever is in the register'."),
        name = ccb.content.text("Alternate Worlds Exhibit 2"),
    }
    category:entry {
        id = "museum_plaques_items_3",
        text = ccb.content.text("Found in an archaeological dig in the Memphis Delta.  How did these objects arrive there?"),
        name = ccb.content.text("Alternate Worlds Exhibit 3"),
    }
    category:entry {
        id = "museum_plaques_items_4",
        text = ccb.content.text("A home in Norton caught and burned with all inhabitants inside, the only thing not destroyed was an old sailors chest that contained these items."),
        name = ccb.content.text("Alternate Worlds Exhibit 4"),
    }
    category:entry {
        id = "museum_plaques_items_5",
        text = ccb.content.text("Natives in Vermont traded these anachronistic objects to early missionaries."),
        name = ccb.content.text("Alternate Worlds Exhibit 6"),
    }
    category:entry {
        id = "museum_plaques_items_6",
        text = ccb.content.text("Found in a smugglers stash in a cave in Rhode Island."),
        name = ccb.content.text("Alternate Worlds Exhibit 7"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "museum_plaques_visitors" }
    category:entry {
        id = "museum_plaques_visitors_1",
        text = ccb.content.text("These items were worn by an unidentified man who walked out of a swamp with amnesia after an eclipse."),
        name = ccb.content.text("Strange Travelers Exhibit 1"),
    }
    category:entry {
        id = "museum_plaques_visitors_2",
        text = ccb.content.text("Missing person reappeared in the alleyway they disappeared from twelve years before, they appeared to have only aged a few of those years."),
        name = ccb.content.text("Strange Travelers Exhibit 2"),
    }
    category:entry {
        id = "museum_plaques_visitors_3",
        text = ccb.content.text("A woman went missing for six hours.  During the next 7 hours an elderly woman attempted to convince people there, that she was the missing woman.  DNA evidence suggests she is a half sister or aunt to the much younger woman.  No family records suggest this relation exists."),
        name = ccb.content.text("Strange Travelers Exhibit 3"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "many_years_old_news" }
    category:entry {
        id = "xe_many_years_old_news_1",
        text = ccb.content.text("UPTICK IN UFO SIGHTINGS CONCERN THE PUBLIC.  There has been a decidedly large increase in UFO sightings among the general public, among all ages, races, and classes.  Government spokesperson Jamie Vargas had the following to say.  \"All these UFO sightings are due to climate change impacting the Aurora Borealis,\" she told an assembled press.  \"There certainly aren't any aliens making contact with the US government and there aren't any aliens flying around.  You can count on that!\""),
    }
    category:entry {
        id = "xe_many_years_old_news_2",
        text = ccb.content.text("Announcement of rare elements discovery near the Canadian border.  The US government has discovered what they are calling an unexpected windfall of rare elements on the border with Canada.  At these sites large domes with irising roofs have been erected before anti-satellite measures were enacted.  The government claims that these domes were built  \"In order to protect the natural environment surrounding these mineral deposits\"  Some people living nearby the domes have claimed increased UFO activity after the domes began, but satellite images no longer seem able to view these regions and drones attempting to enter the restricted areas cease to work."),
    }
    category:entry {
        id = "xe_many_years_old_news_3",
        text = ccb.content.text("GOVERNMENT ANNOUNCES NEW RESEARCH DIVISION.  The US government has announced a new research push into esoteric and fringe sciences.  \"We've decided that based on the new medicines and treatments that have been coming out of Asia from leads in Traditional Chinese Medicine and other Asian cultural histories to institute some additional research into less recent avenues.  This research group is receiving its funding as part of the budget windfall brought on by rare mineral deposits near the Canadian border.\"  Many geologists are still asking for access to these mineral deposits as these formations fly in the face of previously known geology."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "years_old_news" }
    category:entry {
        id = "xe_years_old_news_1",
        text = ccb.content.text("STRANGE LIGHTS IN WOODS AND SWAMPS: Locals have stated that near the deep woods and swamps strange lights and sounds have occurred.  \"Late at night I see and hear things coming from the deep swamp, where it wouldn't be safe to go in the dark\", Steve 'Goatman' Mulroy said.  Local police claim that the legalization of various cannabinoids is likely the root cause of these late night occurrences."),
    }
    category:entry {
        id = "xe_years_old_news_2",
        text = ccb.content.text("BOTANISTS FIND SEVERAL NEW SPECIES: Botanists across the country are finding new plants in established ecosystems at a record pace.  \"These plants seem to have evolved in a slightly different place than where we are finding them\", Jurgen Jurgensen remarked.  \"Is this climate change related, some kind of widespread invasive species replacement, previously extinct species finding new conditions to grow in?  We just don't know yet.\""),
    }
    category:entry {
        id = "xe_years_old_news_3",
        text = ccb.content.text("BORDER PATROL EXPANSION AND REFORMATION: The Border Patrol has been expanded and reformed as part of several new laws.  Several new divisions with differing chains of command have been created and tens of thousands of new agents are expected to be hired over the next decade.  When asked for comment on this Senator Fisk of Maine said the following \"The old Border Patrol was a hammer and was used as such.  The new border patrol departments are going to be a toolbox.\""),
    }
    category:entry {
        id = "xe_years_old_news_4",
        text = ccb.content.text("STRANGE NEW BIOMES CONTINUE TO EXPAND.  The strange biomes of never before seen plants continue to spread.  One of the new border patrol divisions has been assigned to investigate and manage these locations that now appear all across America.  \"These climate change biomes have appeared globally but we will investigate them locally,\" said a spokesperson for Border Patrol.  \"Once we've determined the cause of these locations we will go about figuring out how to exploit or reverse these changes.\""),
    }
    category:entry {
        id = "xe_years_old_news_5",
        text = ccb.content.text("NEW BORDER PATROL DIVISIONS HAVE NO NAMES: In an unnerving development for civil society advocates none of the new Border Patrol Divisions have publicly identified names.  Agents have barcode based identification badges that per Homeland Security \"Are significantly harder to forge than other badge designs.\"  The ACLU has filed suit calling the 'Zebra Agents' unconstitutional."),
    }
    category:entry {
        id = "xe_years_old_news_6",
        text = ccb.content.text("NEW STREET DRUG: There is a new drug flooding New England.  DEA Agent Walter Grayfield made the following comment \"It appears to be produced locally somewhere in New England probably in a lab in Boston.\"  The drug called 'faewild' causes extreme hyperfocus with a resultant loss of manual dexterity and slowed movements."),
    }
    category:entry {
        id = "xe_years_old_news_7",
        text = ccb.content.text("BRIDGEWATER TRIANGLE MOST ACTIVE IN CENTURIES: The Bridgewater Triangle is more active than it has been in centuries with strange sightings and experiences multiple times a week.  The local Wampanoag people have begun issuing warnings about the return of Puck-wudj-ininee to their places on this Earth from before their long ago banishment."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "one_year_old_news" }
    category:entry {
        id = "xe_one_year_old_news_1",
        text = ccb.content.text("LIVING NEAR SPILLAGE ZONES.  Are you willing to live near a spillage zone?  Some people have encountered horrific diseases while others claim that they've met intelligent creatures from the other side.  \"These zones and anything that crosses over from them should be considered extremely dangerous,\" said a spokesperson for Border Patrol.  \"Why would I trust the Border Patrol.  They certainly haven't stopped everything crossing over and yet the world is still ticking on one day at a time.\"  said Richard Clarke from Norton, MA"),
    }
    category:entry {
        id = "xe_one_year_old_news_2",
        text = ccb.content.text("MISSING HUSBAND WALKS OUT OF EXCLUSION ZONE TWENTY YEARS OLDER: Area man John Paul Godfrey has been missing for over a year since he chased an animal into the Maine Exclusion Zone.  He walked out today and pictures suggest he aged by twenty years while in there.  Local hospital believes he must have experienced extreme stress to have aged so quickly in such a short time."),
    }
    category:entry {
        id = "xe_one_year_old_news_3",
        text = ccb.content.text("TOWN OF JEROME AZ DISAPPEARS OVER NIGHT!  The population of Jerome AZ has been declared missing today.  A tourist passing through the town found it completely empty of people and all buildings covered in disturbingly large cobwebs.  The FBI and Border Patrol are both investigating."),
    }
    category:entry {
        id = "xe_one_year_old_news_4",
        text = ccb.content.text("NEW CANDY MAKER OPENS:  Activity at the old Reed and Barton Complex in Taunton, MA has been ongoing for several months.  Locals wondered what exactly was going on at the abandoned complex, but now there are answers!  The entire complex has been taken over by a foreign candy maker known as Wyld Candies.  A spokesperson for the company stated that 'We believe there will be explosive growth opportunities here in New England in the very near future.'  Local children thrilled to try out the new flavors."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "months_old_news" }
    category:entry {
        id = "xe_months_old_news_1",
        text = ccb.content.text("JODDIT FACES SIGNIFICANT BACKLASH: Joddit, the 'paper of record for the internet' is undergoing significant upheaval as their volunteer workforce began organizing for less interference in their communities from the site owners.  The current CEO of Joddit continues to fan the flames beyond any reasonable length by calling volunteer workforce 'entitled'."),
    }
    category:entry {
        id = "xe_months_old_news_2",
        text = ccb.content.text("WAREHOUSE FULL OF BLOOD DRAINED BODIES FOUND IN BOSTON: A horrific discovery in Boston this morning with a discovery of a downtown warehouse full of dead bodies.  The bodies were found in two states, completely drained of blood or decapitated with the hearts torn out.  The police haven't released the total number of bodies discovered but it is believed that this must the work of a gang war.  Our source said that they believe that the two different body states suggest that one type of death is for people who are in the gang versus those who are outside of the gang but work for it."),
    }
    category:entry {
        id = "xe_months_old_news_3",
        text = ccb.content.text("ZEBRA HIRING SPREE: The border patrol divisions known collectively as Zebra Divisions seem to have gone on an impressive hiring spree judging by the quantity of office buildings and agency marked vehicles in New England, not part of the country historically considered a dangerous border in need of patrols.  However, in this new world where seepage events are regular occurrences and rumors of strange creatures crossing over are commonplace these new teams seem important."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "weeks_old_news" }
    category:entry {
        id = "xe_weeks_old_news_1",
        text = ccb.content.text("WHAT LIES AT THE RAINBOWS END: \"Stories about parties of fantastical warriors marching out from rainbow bridges are pure balderdash.\", the commissioner of Customs and Border Protection said in a press conference today.  \"Also pure lies are the stories of people who's family history has been touched by the supernatural being gathered up by long dead relatives to go to so-called rainbow bridges.  Surely, you can't be giving this credence?\""),
    }
    category:entry {
        id = "xe_weeks_old_news_2",
        text = ccb.content.text("DREAMS FEEL MORE REAL: Everyone seems to agree that dreams feel more real than they ever have previously.  The idea that you might be able to do something downright magickal if you just figured out how to turn the right knobs in your dreams seems to be spreading."),
    }
    category:entry {
        id = "xe_weeks_old_news_3",
        text = ccb.content.text("CARNIVAL ARRIVES FROM EUROPE.  Mr Shade's Hurly Burly Carnival has arrived back in New England after having spent the last thirty years traveling Olde Europe as they say.  The sights to be seen at this carnival were called 'Once in a generation' by this journalist's grandfather.  I'll be making plans to attend and I hope you do too."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "newest_news" }
    category:entry {
        id = "xe_newest_news_1",
        text = ccb.content.text("FATEFUL OBJECTS GRAND FINALE SALE: The pawnshop of princes, the auctioneer of artifacts, Clove Payne has declared that he is holding a 'Grand Finale Sale for the World' at his store Fateful Objects.  He welcomes everyone to come for 'One last round of dealmaking before it all goes to pieces!'"),
    }
    category:entry {
        id = "xe_newest_news_2",
        text = ccb.content.text("WAMPANOAG TRIBE DECLARES RETURN HOME FOR NEW ENGLAND NATIVE AMERICANS!  The Wampanoag Tribe of Aquinnah (Land under the hill) have sent out messages across every medium that all of the peoples descended from the Wampanoag Confederation are welcome to join them in their federal land trust reservation on Martha's Vineyard.  It is unknown as of press time how long they are planning to play host to the potentially thousands of people that could answer this call."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_CHANGELING_NOBLE" }
    category:text(ccb.content.text("You dream of dancing in a palace made of ice and feasting on delicate sugar candies in the shapes of birds and fish."))
    category:text(ccb.content.text("You dream of riding at the head of a hunting party, the hounds panting as they chase after fleeing humanoid forms."))
    category:text(ccb.content.text("You dream of a duel in the rain, fought with swords made of lightning."))
    category:text(ccb.content.text("You dream of sitting on a throne as criminals are brought before you for judgement."))
    category:text(ccb.content.text("You dream of changing colors with the leaves and letting the wind come shake you down."))
    category:text(ccb.content.text("You dream of oaths, vows, and promises made to the seasons, tides, and moon."))
    category:text(ccb.content.text("In your dream, the bonfire speaks your name and tells you secrets it has learned."))
    category:text(ccb.content.text("You dream of stepping in between the standing stones and walking the path to the Dying Lands."))
    category:text(ccb.content.text("You dream of secret councils meeting around a brazier filled with frozen flames."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_CHANGELING_COMMONER_BROWNIE" }
    category:text(ccb.content.text("You dream of repairing shoes."))
    category:text(ccb.content.text("You dream of a well-kept house, everything in its place."))
    category:text(ccb.content.text("You dream of spinning straw into gold."))
    category:text(ccb.content.text("In your dreams, you watch from above the fire in the hearth as the children play with blocks and the dog sleeps in the kitchen."))
    category:text(ccb.content.text("You dream of creeping through the halls while everyone is asleep, making sure everything is in order."))
    category:text(ccb.content.text("You dream of eating delicious crusty bread and washing it down with fresh milk, set out just for you."))
    category:text(ccb.content.text("You dream of stealing all the buttons from an ungrateful mortal's clothes."))
    category:text(ccb.content.text("You dream of putting on the coat the householders left for you walking out the door for the last time."))
    category:text(ccb.content.text("You dream of finding a farmhand sleeping on the job and tying his shoes together."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_CHANGELING_COMMONER_POOKA" }
    category:text(ccb.content.text("You dream of flying through the night on raven's wings."))
    category:text(ccb.content.text("You dream of running on all fours through a field of wheat."))
    category:text(ccb.content.text("You dream of tracking a badger's scent back to its lair."))
    category:text(ccb.content.text("You dream of a raven landing on your outstretched arm and telling you what it saw while on the wing."))
    category:text(ccb.content.text("You dream of branches whipping your face as you sprint through the forest, away from the crashing sounds behind you."))
    category:text(ccb.content.text("You dream of perching in a tree while an unsuspecting group of mortals passes by underneath."))
    category:text(ccb.content.text("You dream of giving a message to a squirrel and watching as it scampers off to deliver it."))
    category:text(ccb.content.text("In your dreams, you sit in a parliament of owls, debating issues of the forest."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_CHANGELING_COMMONER_SELKIE" }
    category:text(ccb.content.text("You dream of looking up at the sun from beneath the surface of the water."))
    category:text(ccb.content.text("You dream of frolicking in the seafoam."))
    category:text(ccb.content.text("You dream of slipping on your skin and the shiver as your skin turns to fur and your hands to flippers."))
    category:text(ccb.content.text("You dream of bumping a fishing boat and giggling as the rod falls in the water."))
    category:text(ccb.content.text("You dream of singing to the clouds and watching lightning bolts crash through the heavens."))
    category:text(ccb.content.text("You dream of following schools of fish, herding them like a shepherd."))
    category:text(ccb.content.text("You dream of a walk along the beach under the moon."))
    category:text(ccb.content.text("You dream of a mortal holding your skin, gloating at you as you step away from the sea."))
    category:text(ccb.content.text("You dream of running as a hound and shifting back as you leap for the kill."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "XE_CHANGELING_COMMONER_TROW" }
    category:text(ccb.content.text("Your dreams are filled with the round of pickaxes striking rock."))
    category:text(ccb.content.text("You dream of finding a rich vein of ore."))
    category:text(ccb.content.text("You dream of watching the moon set from the mouth of a cave."))
    category:text(ccb.content.text("You dream of watching a pair of humans pass by, oblivious to you among the rocks."))
    category:text(ccb.content.text("You dream of tapping out a message on the rock wall and listening for the reply."))
    category:text(ccb.content.text("Your dreams are filled with the glow of hot metal and the pounding of hammers."))
    category:text(ccb.content.text("You dream of the darkness and silence within the depths of the earth."))
    category:text(ccb.content.text("You dream of holding a finished blade, the work of months of hard labor."))
    category:text(ccb.content.text("You dream of mining songs unheard by mortal ears."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "radio_scan_no_stations" }
    -- This is extending the vanilla snippets belonging to mostly work of random people: chat logs, SMSes, popular photos and videos that people share, or something they can film by themselves.
    category:entry {
        id = "xe_radio_1",
        text = ccb.content.text("A voice cuts in across the static, 'And for the next hour we'll be playing the last Deftones album Through the Green Door.  I wonder if we collectively went through a green door before the world went crazy.'  The radio blasts Deftones music until you lose the station a few songs in."),
        name = ccb.content.text("voices on the radio:deftones"),
    }
    category:entry {
        id = "xe_radio_2",
        text = ccb.content.text("You find a faint signal: 'This is [unintelligible] bringing you Darkest of the Hillside Thickets' new single Don't Talk with the Voice in the Storm!  I'm not really sure how new this single is as I never heard it before the Cataclysm and it showed up in an envelope stapled to the station door one morning after a reality storm.  I suppose there are creepier ways to bring me new music but I don't know what they are, and I'm begging you not to enact them."),
        name = ccb.content.text("voices on the radio:darkest of the hillside thickets"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "fae_organs_desc" }
    category:entry {
        id = "fae_organs_1",
        text = ccb.content.text("These organs came from a glittering nether beast, and you really aren't sure what to make of them.  There are things you've possibly seen in an anatomy book, but in colors and shapes that leave you doubtful."),
    }
    category:entry {
        id = "fae_organs_2",
        text = ccb.content.text("These might be a kidney equivalent but they smell of rosemary at your touch."),
    }
    category:entry {
        id = "fae_organs_3",
        text = ccb.content.text("The lung looking organs are oozing a shimmering green substance."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "spy_note" }
    category:entry {
        id = "spy_note_1",
        text = ccb.content.text("I've tracked down rumors an intradimensional contact unit based out a local government building.  I'm going to go recon it, see you in a few days."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "note" }
    category:entry {
        id = "xe_survnote_1",
        text = ccb.content.text("The weird creatures that seem to come out of peoples nightmares don't seem to be able to track by smell like so many of the other monsters.  I wonder if that's because smell isn't a strong sense in dreams?"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "inventor_success" }
    category:text(ccb.content.text("After some work, you came to the solution that satisfies you."))
    category:text(ccb.content.text("You spent a lot of time, and the result looks good now."))
    category:text(ccb.content.text("Huge amount of time transferred into a knowledge you will utilize well."))
    category:text(ccb.content.text("Finally, your work came to something good."))
    category:text(ccb.content.text("yes, Yes, YES!"))
    category:text(ccb.content.text("That was stupid, but it did work."))
    category:text(ccb.content.text("The job is done."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "inventor_fail" }
    category:text(ccb.content.text("You did a lot of research and calculations, but the result do not satisfy you."))
    category:text(ccb.content.text("Nope."))
    category:text(ccb.content.text("That's bad."))
    category:text(ccb.content.text("It won't work."))
    category:text(ccb.content.text("It was a good idea, but you picked a wrong approach."))
    category:text(ccb.content.text("Why did you start it?  It is obviously not possible."))
    category:text(ccb.content.text("How did I…?  Ugh, nevermind."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "changeling_march_lord_report" }
    category:entry {
        id = "changeling_march_lord_1",
        text = ccb.content.text("Field Report CO001141: We've managed to capture one of what we are calling the nobles of these people.  It claims to be a 'March Lord' and that it rules a small barony right across the border between our worlds."),
        name = ccb.content.text("Field Report CO001141"),
    }
    category:entry {
        id = "changeling_march_lord_2",
        text = ccb.content.text("Interrogation Report: CO001141-a1: Chapfax Æelgar Llywelyn, as our prisoner has identified himself can both speak and write our language.  Chapfax had listened to use speak about him for days and only today did he respond to any of our questions.  He claims this is because we just now began to interest him."),
        name = ccb.content.text("Interrogation Report: CO001141-a1:"),
    }
    category:entry {
        id = "changeling_march_lord_3",
        text = ccb.content.text("Interrogation Report: CO001141: The creature has spent three days sitting and watching our attempts to communicate.  It has made no attempts to communicate back to us."),
        name = ccb.content.text("Interrogation Report: CO001141:"),
    }
    category:entry {
        id = "changeling_march_lord_4",
        text = ccb.content.text("Interrogation Report: CO001141-b2: Chapfax has only spoken with specific staff members and ignores any interaction from others.  We are trying to find a pattern of who he is choosing and why."),
        name = ccb.content.text("Interrogation Report: CO001141-b1:"),
    }
    category:entry {
        id = "changeling_march_lord_5",
        text = ccb.content.text("Interrogation Report: CO001141-f7: In the last 24 hours half of the staff members Chapfax interacted with have gone missing.  Some even disappeared from this office, we have no idea what has happened to them and if this is some kind of kidnapping to ransom back Chapfax.  The so-called March Lord, has said that he doesn't imagine it is anyone from his barony but that there are many across the borderlands.  And that beyond those border lands are the great states of the 'Far Lands'."),
        name = ccb.content.text("Interrogation Report: CO001141-f7:"),
    }
    category:entry {
        id = "changeling_march_lord_6",
        text = ccb.content.text("Interrogation Report: CO001141-f75: Chapfax has been unusually talkative since we informed him of the missing staff, I finally asked him why he was being so talkative suddenly and he looked at me right in the eyes and sorrowfully said 'I don't imagine anything I say will matter soon, I can feel a change coming in your world and I'd prefer to watch it from my home.  I'll grant you and your family safe passage if we leave before nightfall.'  I know the riots and weirdness have been escalating *the report stops midsentence*."),
        name = ccb.content.text("Interrogation Report: CO001141-f75:"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "desk_postit_field_agent" }
    category:entry {
        id = "desk_postit_field_agent_1",
        text = ccb.content.text("Remember to make the mortgage payment every month by the 5th!"),
        name = ccb.content.text("green post-it note"),
    }
    category:entry {
        id = "desk_postit_field_agent_2",
        text = ccb.content.text("Password: J@ckboot1"),
        name = ccb.content.text("green post-it note"),
    }
    category:entry {
        id = "desk_postit_field_agent_3",
        text = ccb.content.text("Call neighbors and try to identify date the McFarland's went missing."),
        name = ccb.content.text("green post-it note"),
    }
    category:entry {
        id = "desk_postit_field_agent_4",
        text = ccb.content.text("Cultists?  Foreign Agents?  Pod people?"),
        name = ccb.content.text("green post-it note"),
    }
    category:entry {
        id = "desk_postit_field_agent_5",
        text = ccb.content.text("Carcosa?  Leng?"),
        name = ccb.content.text("green post-it note"),
    }
    category:entry {
        id = "desk_postit_field_agent_6",
        text = ccb.content.text("Delta Green?  Majestic 12?"),
        name = ccb.content.text("green post-it note"),
    }
    category:entry {
        id = "desk_postit_field_agent_7",
        text = ccb.content.text("Surveillance to continue on home until Jamison returns."),
        name = ccb.content.text("green post-it note"),
    }
    category:entry {
        id = "desk_postit_field_agent_8",
        text = ccb.content.text("Suspect appears to have hung from the ceiling waiting for the Smith's to return home."),
        name = ccb.content.text("green post-it note"),
    }
    category:entry {
        id = "desk_postit_field_agent_9",
        text = ccb.content.text("Local doctor said it looked like viral cancer similar to some stories he'd seen out of Tazmania."),
        name = ccb.content.text("green post-it note"),
    }
    category:entry {
        id = "desk_postit_field_agent_10",
        text = ccb.content.text("Requisition heavier weaponry"),
        name = ccb.content.text("green post-it note"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "agent_postit_gray" }
    category:entry {
        id = "agent_postit_gray_1",
        text = ccb.content.text("Several of the victims appear to have been exsanguinated and the others were killed while they fled.  Suspicion that the first victims in the club were killed by exsanguination and only upon their death did the other club goers recognize the danger and attempt to flee."),
        name = ccb.content.text("gray post-it note"),
    }
    category:entry {
        id = "agent_postit_gray_2",
        text = ccb.content.text("Every scene is permeated by the smell of rosemary and mint.  All victims set on fire after their death."),
        name = ccb.content.text("gray post-it note"),
    }
    category:entry {
        id = "agent_postit_gray_3",
        text = ccb.content.text("Three different types of shapechangers found in the last month?  Separate successful experiments from one power or different incursions that we should expect more from each type?"),
        name = ccb.content.text("gray post-it note"),
    }
    category:entry {
        id = "agent_postit_gray_4",
        text = ccb.content.text("Does Danvers State have room for more guests?"),
        name = ccb.content.text("gray post-it note"),
    }
    category:entry {
        id = "agent_postit_gray_5",
        text = ccb.content.text("Field Office in Utah was recently hit by some kind of strike team unsure if it was a foreign squad trying to grab something specific or if they had attracted the attention of other forces that decided to cross over."),
        name = ccb.content.text("gray post-it note"),
    }
    category:entry {
        id = "agent_postit_gray_6",
        text = ccb.content.text("Need more armor piercing rounds."),
        name = ccb.content.text("gray post-it note"),
    }
    category:entry {
        id = "agent_postit_gray_7",
        text = ccb.content.text("Victims found decapitated and staked.  Send bodies out for autopsy."),
        name = ccb.content.text("gray post-it note"),
    }
    category:entry {
        id = "agent_postit_gray_8",
        text = ccb.content.text("Folklore says to burn any remains and then scatter the ashes in running water."),
        name = ccb.content.text("gray post-it note"),
    }
    category:entry {
        id = "agent_postit_gray_9",
        text = ccb.content.text("Shapeshifter Suspect is *NOT* allergic to salt."),
        name = ccb.content.text("gray post-it note"),
    }
    category:entry {
        id = "agent_postit_gray_10",
        text = ccb.content.text("Call requisitions to find out about silver rounds?"),
        name = ccb.content.text("gray post-it note"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "agent_postit_migo" }
    category:entry {
        id = "agent_postit_migo_1",
        text = ccb.content.text("Any missions that end up discovering 'mi-go' class aliens require approval from an external agency before engagement."),
        name = ccb.content.text("pink post-it note"),
    }
    category:entry {
        id = "agent_postit_migo_2",
        text = ccb.content.text("Aliens are mirrorshades territory, and you know how they feel about us. Cowboys and adventurers they call us."),
        name = ccb.content.text("pink post-it note"),
    }
    category:entry {
        id = "agent_postit_migo_3",
        text = ccb.content.text("Off books, there are bonuses available to any agent that is able to execute any 'mi-go' and make it disappear."),
        name = ccb.content.text("pink post-it note"),
    }
    category:entry {
        id = "agent_postit_migo_4",
        text = ccb.content.text("Memo: Several agents appear to have broken protocols and gone rogue in regards to mi-go interactions.  They have been missing for three weeks and became presumed dead after pieces of their bodies totalling 30% of their weight had been mailed home in individual packages."),
        name = ccb.content.text("pink post-it note"),
    }
    category:entry {
        id = "agent_postit_migo_5",
        text = ccb.content.text("They seem to be here to take captives and animals to go back to their homeworld/s."),
        name = ccb.content.text("pink post-it note"),
    }
    category:entry {
        id = "agent_postit_migo_6",
        text = ccb.content.text("Off books, we need more intel on the mirrorshades so we can avenge Tony, Martell, and Picarelli."),
        name = ccb.content.text("pink post-it note"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "border_patrol_files" }
    category:entry {
        id = "incursion_zero_report",
        text = ccb.content.text("Date: 07/13/2008\nLocation: Old Cain Springs, Kentucky\nIncident: Faerie Incursion\nDescription: Our department has received reports of strange occurrences in the area, including sightings of small, barkskinned creatures that match the description of faeries from folklore.  Witnesses have reported missing objects, strange noises, and unexplained lights in the vicinity.\nResponse: Our team has been dispatched to the area to investigate.  We are working closely with local law enforcement and other relevant agencies to determine the nature of the incursion and to neutralize any potential threats.  We advise residents to stay indoors and report any suspicious activity to the authorities.\nStatus: The situation is ongoing.  We have set up a temporary command center in the area and are conducting a thorough investigation.  Our team is equipped with specialized equipment to detect and track interdimensional activity.  We will provide further updates as the situation develops.\nRecommendation: Based on our findings, we recommend that the area be designated as a potential hotspot for interdimensional activity.  We suggest that ongoing surveillance and monitoring be put in place to ensure the safety of local residents and to prevent any further incursions.  We also recommend that education programs be put in place to help residents understand the nature of these creatures and how to avoid potential conflicts."),
        name = ccb.content.text("incursion zero"),
    }
    category:entry {
        id = "abduction_report_1",
        text = ccb.content.text("Date: 07/25/2008\nLocation: Old Cain Springs, Kentucky\nIncident: Abduction of Locals\nDescription: Our team has received reports of several local residents who have gone missing under mysterious circumstances.  Witnesses have reported seeing small, floating lights in the area around the time of the disappearances, leading us to believe that fae-class cryptids may be involved.\nResponse: Our team has launched a full investigation into the matter, working in close coordination with local law enforcement.  We have engaged significant animal based tracking resources, and are gathering intelligence from witnesses and other sources to build a comprehensive picture of the situation.\nStatus: The situation is ongoing.  At this time, we have not been able to locate the missing individuals or definitively establish the involvement of fae-class cryptids.  However, we are actively pursuing all leads and are dedicating significant resources to this investigation.\nRecommendation: Based on our findings to date, we recommend that the area be designated as a high-risk zone for fae cryptid activity.  We urge all residents to exercise caution and report any suspicious activity to the authorities.  Additionally, we recommend that public awareness campaigns be initiated to educate the public about the potential dangers of fae cryptids and how to avoid potential conflicts.  Our team will continue to provide updates as the investigation progresses."),
        name = ccb.content.text("abduction report"),
    }
    category:entry {
        id = "lights_in_swamp_report",
        text = ccb.content.text("Date: 04/29/2016\nLocation: Norton, Massachusetts wetlands\nIncident: Strange lights and sounds in bogs at night\nDescription: Sam 'Goatman' Simmons, has reported numerous strange lights and sounds emanating from the bogs on the northern edge of Norton, MA on the way to Rehobeth.  He'd been drinking and walking his goat late one night and as he neared the edge of the wetlands he heard strange music and multicolored lights.  He suspected one of his neighbors who's property adjoined the bog of throwing a party but after walking around the edges he couldn't figure out how to get through the various streams and ponds to get to it.  Finally at some point, he remembered stories his grandparents had told about people going missing in the bogs and decided to go home and call the police.  The police passed it on to the Border Patrol who investigated for dimensional spillage.  While they were unable to find any cryptids or artifacts at the bogs, they measured a weakness in reality that suggests that the stories might have basis in fact.  Border Patrol left emergency contact information with the local police in the event of any future incursions."),
        name = ccb.content.text("lights in swamp report"),
    }
    category:entry {
        id = "vilna_shul_letter",
        text = ccb.content.text("During our investigation of a series of illnesses befalling the Beacon Hill community we received this a letter from a local rabbi containing the following quote\n'Rav Pappa said: We hold that a lion does not pounce upon two people.  The Gemara challenges this: But how can that be?  We see that it does pounce upon two people.  The Gemara answers: That statement of Rav Pappa must be in accordance with that which Rami bar Abba said: An animal does not overpower a person until he appears to it as an animal, as it is stated: 'But man does not abide in honor, he is like the beasts that perish' (Psalms 49:13).  However, animals do not attack people who are human in their spiritual character.  In a similar vein, Rabbi Ḥanina said: It is prohibited to sleep alone in a house, and anyone who sleeps alone in a house will be seized by the evil spirit Lilith.'\n None of the victims were suffering their maladies any longer and none of them would speak further to our agents.  Does this have any relevance to the case Rosenberg was talking about?  Needs further investigation."),
        name = ccb.content.text("vilna shul letter"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "bloodthorne_druid_vampire_report" }
    category:entry {
        id = "bloodthorne_vampire_1",
        text = ccb.content.text("Field Report Red Twilight 34: Discovered a partially burnt cabin in the Freetown-Fall River State Forest with multiple sets of victims.  A significant number of victims dating back at least 80 years and then three bodies belonging to what we believe were the owners of the cabin and likely perpetrators of the prior murders and finally a body buried a mile away from the cabin likely belonging to the group that attacked and killed the cabin owners."),
        name = ccb.content.text("Field Report Red Twilight 34"),
    }
    category:entry {
        id = "bloodthorne_vampire_2",
        text = ccb.content.text("Exhumation Report: Red Twilight-a1: Dozens of victims with the oldest identified dating back to the Great Depression.  Comparing to missing persons reports from nearby towns a number of bodies were identified as wearing clothes the missing was last seen in.  The bodies were buried in a group of pits that were clearly dug up repeatedly over the years to add new bodies to.  The most recent body was two weeks old and had developed grave wax preserving evidence of the exsanguination."),
        name = ccb.content.text("Exhumation Report: Red Twilight 34-a1:"),
    }
    category:entry {
        id = "bloodthorne_vampire_3",
        text = ccb.content.text("Exhumation Report: Red Twilight 34-a2: The three bodies of the cabin residents did not appear to be related to one another but there were pictures and portraits of them alone and together throughout the cabin.  The one with the youngest appearance had portraits demonstrating the oldest style of dress and then as the portraits and then pictures become more modern first the woman and then the other man begin appearing.  The few features all three had in common were retractable fangs in the roof of the mouth and a mummification of all organs save the heart, which appeared to be more efficient at pumping blood.  Finally all three had significant wounds consistent with being whipped with thorny vines, though where you would find vines strong enough with thorns large enough to deal fatal wounds is unknown."),
        name = ccb.content.text("Exhumation Report: Red Twilight 34-a2:"),
    }
    category:entry {
        id = "bloodthorne_vampire_4",
        text = ccb.content.text("Exhumation Report: Red Twilight 34-a3: The final body was located at a gravesite over a mile away.  This corpse appeared to have some kind of symbiotic or parasitic bonding with a vine growing inside of the body.  It has sharp retractable thorns that pop out after the coiled vine is removed from the body.  There were scars on the body where it looked as though thorns from the vine had stitched together particularly nasty wounds.  Given the difference in how this body was buried and the distance from the cabin, we suspect that this body belonged to one of the attackers who killed the cabin inhabitants.  His companions finished the battle and then carried him away for a quiet burial."),
        name = ccb.content.text("Exhumation Report: Red Twilight 34-a3:"),
    }
    category:entry {
        id = "bloodthorne_vampire_5",
        text = ccb.content.text("Summary: We suspect that the cabin was inhabited by vampires similar to ones we have found elsewhere though either this group was particularly prone to murdering their blood donors or other vampires we've discovered are much more adept at disposing of bodies in ways that can't be tied back to them.  We will need to have further investigation into this subject.  The man infested with vines however is unlike anything else we've encountered before.  Appearing to be a normal human, his body contained significant secrets.  Organs and features from both the plant and animal kingdoms not found in humans were discovered during the autopsy and review of cellular material."),
        name = ccb.content.text("Field Report Red Twilight 34 b-1"),
    }
    category:entry {
        id = "bloodthorne_vampire_6",
        text = ccb.content.text("Summary (cont): In conclusion we appear to have stumbled upon some kind of factional war between the blood drinkers and the possessors of these symbiotic vines.  Is this a  turf squabble between two local groups or is this something larger?"),
        name = ccb.content.text("Field Report Red Twilight 34 b-2"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_notes" }
    category:entry {
        id = "lab_notes_interdimensional_magick_1",
        text = ccb.content.text("Excerpt from 'Infinite Dimensions, Finite Magickal Systems by Tyco Arendt':\n\nThrough the efforts of our Offworld Aquisitions Teams and especially the efforts of our Specter Agents we have become aware of numerous worlds where different 'supernatural milieus' exist.  These are worlds what can be lumped together as magick exists but depending on the dimension the process of use and effects can be vastly different."),
        name = ccb.content.text("excerpt 1, Infinite Dimensions, Finite Magickal Systems"),
    }
    category:entry {
        id = "lab_notes_interdimensional_magick_2",
        text = ccb.content.text("Excerpt from 'Infinite Dimensions, Finite Magickal Systems by Tyco Arendt':\n\nWe have encountered dimensions running the gamut of imagined systems of supernatural abilities, ranging from Vancian style Magicians, mana pool systems, and psionically empowered individuals, all the way to what can only be termed as Super Heroic worlds."),
        name = ccb.content.text("excerpt 2, Infinite Dimensions, Finite Magickal Systems"),
    }
    category:entry {
        id = "lab_notes_interdimensional_magick_3",
        text = ccb.content.text("Excerpt from 'Infinite Dimensions, Finite Magickal Systems by Tyco Arendt':\n\nVia our aquisition teams we have brought numerous practitioners back to Cradle-Earth with an incredible variety of results as to whether or not their powers function in our dimension.  Most strangely the broad form which their powers manifest as tends to have little bearing on whether their abilities function here.  We have yet to determine causation of this phenomena nor achieved any control of it."),
        name = ccb.content.text("excerpt 3, Infinite Dimensions, Finite Magickal Systems"),
    }
    category:entry {
        id = "lab_notes_interdimensional_magick_4",
        text = ccb.content.text("Excerpt from 'Infinite Dimensions, Finite Magickal Systems by Tyco Arendt':\n\nThreat Classification: Vancian Magick\nJetIota\n\nVancian Magick is any system that requires the practitioners to learn/memorize a spell and then forget it upon casting at which point it must be relearned again prior to being able to cast again.  Preparation is key for these types of thaumaturgic assets and without being properly prepared for what they face they can be no more threatening than your average citizen.  Conversely we have found that more users of this type of magick retain their powers on Cradle-Earth than any other type than superhumans."),
        name = ccb.content.text("excerpt 4, Infinite Dimensions, Finite Magickal Systems"),
    }
    category:entry {
        id = "lab_notes_interdimensional_magick_5",
        text = ccb.content.text("Excerpt from 'Infinite Dimensions, Finite Magickal Systems by Tyco Arendt':\n\nThreat Classification: Superhuman\nRubyNu\n\n***QUARANTINE***\n\nUpon identification of any subjects manifesting true superhuman abilities all agents and aquisition teams must immediately return to Xedra Facilities on Cradle-Earth within 12 hours or be written off when the dimensional coordinates are permanently blacklisted in our transportation system.  This reaction may seem extreme but any planet that develops superhuman attributes such as strength and endurance is at risk of also developing superintelligent, superperceptive individuals.  We are titling this hypothetical superhuman type as Sphinxes because Sphinxes eat the people who are less intelligent than themselves.  These individuals could potentially identify our presence on their dimension through variables we cannot even comprehend.  Whether our morality viewed them as good or evil would be irrevalent as we have no defense against this type of cultural/intellectual domination."),
        name = ccb.content.text("excerpt 5, Infinite Dimensions, Finite Magickal Systems"),
    }
    -- should override lab_notes_interdimensional_magick_6, but mods cannot override snippets yet
    category:entry {
        id = "lab_notes_interdimensional_magick_6a",
        text = ccb.content.text("Excerpt from 'Infinite Dimensions, Finite Magickal Systems by Tyco Arendt':\n\nThreat Classification: Psionics\nOpalPsi\n\nPsionically empowered individuals can often be disarmed using specific methods common across dimensions.  Identification of empowered individuals can be difficult in civilizations that either refuse or lack the knowledge of how to identify psionic individuals."),
        name = ccb.content.text("excerpt 6, Infinite Dimensions, Finite Magickal Systems"),
    }
    category:entry {
        id = "lab_notes_gracken_first_contact_1",
        text = ccb.content.text("Alternative Physics Realm UMB-16 is a high energy, low ambiently lit dimension.  Colloquially known among the Aquisitions teams as a 'shadow realm'.  High energy refers to the amount of various radiations emanating from unknown sources that provide an equivalent amount of energy to multiple Sols.  This has resulted in an ecosystem where predation shouldn't need to exist but does.  Every creature we dissected appears to absorb tens of thousands of calories worth of ambient radiation every cycle.  Our observations over time showed that despite this abundance of energy, every lifeform we encountered also had a predation cycle they would undergo in which they prey on one or more of the other shadow creatures."),
        name = ccb.content.text("XE843 First Contact Notes: Section A"),
    }
    category:entry {
        id = "lab_notes_gracken_first_contact_2",
        text = ccb.content.text("UMB-16 is populated by a wide variety of creatures and many of them are harvestable for rare isotopes found in their organs.  Offworld Aquisition Team: Immanentized Eschaton were harvesting isotope rich organs at 1315 Cradle-Time when a humanoid shadow creature approached unnoticed.  It spoke to them in English with a mishmash of accents, (later identifed as accents belonging to teams that had deployed to UMB-16) and that it was authorized to negotiate our presence in it's home dimension.  A return location and date were set and all teams were withdrawn and planned missions for before that date were scrapped.  Debate at the highest levels raged."),
        name = ccb.content.text("XE843 First Contact Notes: Section B"),
    }
    ccb.content.add(category)
end
