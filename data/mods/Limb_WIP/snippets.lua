local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "<eyes_blind>" }
    category:text(ccb.content.text("Something snaps behind your eyes, and the world turns black."))
    category:text(ccb.content.text("A sudden sharp pain in your eyes, then you are lost in the darkness."))
    category:text(ccb.content.text("Your eyes fail you, and everything turns dark."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<eyes_glare>" }
    category:text(ccb.content.text("The lights grow uncomfortably bright."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<eyes_stun>" }
    category:text(ccb.content.text("The world starts turning wildly, and you stumble."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<arm_itch>" }
    category:text(ccb.content.text("Your arms start itching."))
    category:text(ccb.content.text("Something is crawling under your skin."))
    category:text(ccb.content.text("You pause for a moment.  The movement under your skin doesn't."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<arm_pain>" }
    category:text(ccb.content.text("Your arms hurt!"))
    category:text(ccb.content.text("Your arms cramp!"))
    category:text(ccb.content.text("Something shifts in your arm, painfully."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<arm_drop>" }
    category:text(ccb.content.text("Your hands seize up for a moment, and you drop your weapon!"))
    category:text(ccb.content.text("Your arms fall down paralyzed, and your weapon tumbles to the ground!"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<bird_dream>" }
    category:text(ccb.content.text("You are but a child again, fighting over the dinner's remains with your brothers and sisters.  There were times for mirth and playfulness, but this is not one of those - the time nears when the smallest will be cast aside, and you're all terrified of being chosen."))
    category:text(ccb.content.text("You soar above the plains, but the pickings are slim today.  The shadows lengthen already, and you turn homewards with a flick of your wings, steeling yourself to the disappointed cries of your chicks and another hungry night.  You must do better tomorrow, lest this year's brood will be lost too."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<bird_failure>" }
    category:text(ccb.content.text("You long for the skies, to watch the tiny problems of the ground disappear below you."))
    category:text(ccb.content.text("You remember feeling less attached to the ground.  What are you missing?"))
    category:text(ccb.content.text("You need more if you are to fly South before the cold comes.  Much more."))
    category:text(ccb.content.text("Is your beak strong enough?  Your feathers long?  No, you need more."))
    category:text(ccb.content.text("You need enough bird primer and catalyst in your system while you are sleeping to complete your change."))
    category:text(ccb.content.text("You won't be able to change without enough catalyst, the right primer and being asleep."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<raptor_dream>" }
    category:text(ccb.content.text("You prowl the forest with your nestmates in search of prey - you're a strong brood with bright feathers and sharp talons, but fortune seems to elude you lately.  You take them towards the edge of the forest, where the air always smells of smoke, and sneak up on a pack of monkeys with too-colorful fur sitting on a fallen tree and chattering amongst themselves.  The smallest notices you and waves excitedly, just before you pounce."))
    category:text(ccb.content.text("You dream of blood on your talons, and the air catching your feathers as you try to balance on your struggling prey.  It feels almost like a game, something you'd have played in a previous life.  Lost in thought you almost miss the moment when the threshing grows still, until your brothers' screech brings you back to the present - time to eat."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<raptor_failure>" }
    category:text(ccb.content.text("Slow.  Too slow.  Slower than prey."))
    category:text(ccb.content.text("You'll never wet your talons at this rate.  You need to become better."))
    category:text(ccb.content.text("Scenes of a chase, claws, blood on the leaves flash before your eyes.  You need more to truly understand it."))
    category:text(ccb.content.text("Not a care in the world, only the hunt.  How you wish you were that far gone already."))
    category:text(ccb.content.text("You need enough raptor primer and catalyst in your system while you are sleeping to complete your change."))
    category:text(ccb.content.text("You won't be able to change without enough catalyst, the right primer and being asleep."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<arm_feathers_dream>" }
    category:text(ccb.content.text("<bird_dream>"))
    category:text(ccb.content.text("<raptor_dream>"))
    category:text(ccb.content.text("You are desperate to stop your disgusting ape hands from pulling out handfuls of your beautiful feathers, but they move on their own accord.  You manage to hold one of the useless things between your talons, and bring your beak down on it…Just a dream.  Still, food for thought."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<arm_feathers_success>" }
    category:text(ccb.content.text("You wake to a sudden itch in your arms, and you shake them vigorously.  To your painful surprise a new cover of long, strong feathers broke the surface, bloody dead skin and plumage falling on the ground."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<wings_bird_dream>" }
    category:text(ccb.content.text("<bird_dream>"))
    category:text(ccb.content.text("Clouds surround you as you soar through the sky.  You look down and see the wilderness stretching out as far as the eye can see, but you can't stay here.  You need to go somewhere else, to the land of warmth and plenty.  Your eyes wander over your beautiful wings propelling you along, and you're mesmerized by their rhythmic beating.  Much better than your…hands.  You have hands, not wings.  Not yet."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<wings_bird_success>" }
    category:text(ccb.content.text("You dream of jumping from a cliff for your first flight, but the feathers on your clumsy arms can't hold you.  You hit the ground, and your hands are mangled beyond recognition.  After waking, the pain persists, and you're startled to see your useless fingers snap and disappear in your rich plumage.  Good riddance, you think, before falling unconscious."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<insect_failure>" }
    category:text(ccb.content.text("You need the right nectar, otherwise you will never be queen."))
    category:text(ccb.content.text("You long for a safe, dark place to complete your change."))
    category:text(ccb.content.text("You could build a hive, if only you were better.  What are you missing?"))
    category:text(ccb.content.text("More of the <color_yellow> good nectar</color>.  That's what you need."))
    category:text(ccb.content.text("You can't be expected to metamorphose with so little.  You need more."))
    category:text(ccb.content.text("You need enough insect primer and catalyst in your system while you are sleeping to complete your change."))
    category:text(ccb.content.text("You won't be able to change without enough catalyst, the right primer and being asleep."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<insect_dream>" }
    category:text(ccb.content.text("You and your sisters have worked diligently, made your home safe and prosperous.  You felt so proud.  But lately Mother has been growing slower, and more cells are empty than with brood.  You see hesitation on your sisters as well…does the hive need you to step up?  Would they follow?  Could you defeat Her?"))
    category:text(ccb.content.text("You dream of a dark, damp place permeated by the smell of sawdust.  You feel like this is all you've ever known, each bend in the walls and scratch on the floor your handiwork.  It feels like home, but deep down you know that you'll have to change and emerge into the dangerous, light-battered outside."))
    category:text(ccb.content.text("You have stuffed yourself to bursting for the fourth time today, but your hunger doesn't abate.  You would need to escape your too-small skin to be able to eat enough, you're sure of it.  Take the knife to one of the stretch marks on your back, and part the skin - it springs to the side readily and with no pain.  You work your way down your sides, changing the knife between hands as needed and free your <color_light_green>new skin</color> from its fleshy prison."))
    category:text(ccb.content.text("Getting the bodybag was harder than you would have thought, and ordinary garbage bags would just not do.  You eat your fill for the last time with this mouth, undress (you won't need clothes after the change), and climb in the bag.  Closing the zipper from the inside is a challenge, but you need complete darkness for what comes now.  You wait.\nAnd wait.\nAnd wait.\n\nCould you have been wrong?  You were so sure the time was right.\nYou need to get out of here, but you can't move your…anything.  Do you even have anything to move?"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<insect_eye_dream>" }
    category:text(ccb.content.text("<insect_dream>"))
    category:text(ccb.content.text("Your try going about your day as usual, but your vision seems to dim every few seconds for no reason.  You reach to your eyes in annoyance and feel a disgusting fleshy membrane periodically covering them with a squeaky, wet motion.  You grasp them tightly and pull hard despite the pain until they tear off with a shower of red ichor coating your eyes.  You lick it away, and finally you can see clearly."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<insect_eye_success>" }
    category:text(ccb.content.text("After another day of dazed mundanity you make your way back home to your dingy cellar apartment, but miss a step and fall down the stairs, landing on your face with a wet thud.  Consciousness fades, but the pain stays.  The pain, and the feeling of myriad cockroach legs running on your skin, coating your wounds in a skittering, biting cloak.\n\nYou wake, shedding the weird apey memories, and you are stunned by a dizzying cavalcade of colors you could never have imagined before.  This is a step in the right direction, you decide, regarding your newly-expanded perspective with appreciation before the vertigo takes you."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<insect_eye_2_success>" }
    category:text(ccb.content.text("<insect_eye_success>"))
    category:text(ccb.content.text("You dream of a throbbing headache, and the feeling of an imminent molt.  You find a suitable recess, freeze in place and **push**, trying to rip your old exoskeleton up with you pressure of your new armor but nothing happens.  All the pressure seems to well up into your head, and finally you feel a wet snap and a shower of too-warm mammal ichor on your feelers.\n\nYou wake up in a puddle of your own blood under your head, a puddle you can see despite looking straight up.  It will be some time before your eyes' crystals harden properly, but already the colors are even richer than they were before, and the world seems somehow sluggish."))
    ccb.content.add(category)
end
