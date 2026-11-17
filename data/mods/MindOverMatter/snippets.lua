local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "local_files_simple" }
    -- mostly work of random people: chat logs, SMSes, popular photos and videos that people share, or something they can film by themselves.
    category:entry {
        id = "local_files_mom_1",
        text = ccb.content.text("flashbang.mp3\n\nThe video starts with a man running away from three police.  One of them catches up to him and pushes him to the ground.  As the other two catch up they begin kicking and beating him with batons.  Suddenly a blinding flash of light and sound erupt right near the victims hands and the police are stunned.  The man gets up and runs away.\n\nYou watch it a couple of times and can't see any flashbang grenade before the explosion."),
        name = ccb.content.text("Police stunned with their own flashbang!"),
    }
    category:entry {
        id = "local_files_mom_2",
        text = ccb.content.text("nowyouseeme.mp3\n\nFootage from what looks like a lab with a person trapped in a clear glass box.  The scientist drones on 'Experiment 65: Escape from a sealed enclosure'.  When the scientist says 'Begin' the subject inside the glass enclosure gets a very focused look on their face.  It gets more strenous for ten seconds and then the subject starts to take a step directly into the glass, vanishing before they bump into it.  Almost instantaneosly reappearing about six feet outside of the enclosure."),
        name = ccb.content.text("Magic Trick"),
    }
    category:entry {
        id = "local_files_mom_3",
        text = ccb.content.text("arsongirl.mp3\n\nIncredibly this is footage of the Cataclysm during the height of the portal storms.  It looks like Bar Harbor, Maine.  Some kind of godzilla sized squid lashes the docks with tentacles hundreds of feet long, while a Heritage class Coast Guard cutter fires its 57mm naval gun at the giant squid.\n\nThat is the background of the footage.  The foreground is at the top of the hill overlooking the road down to the docks.  Here people have taken shelter in stores on the main road down to the docks, but a young girl with bloodshot eyes giggles as she walks towards a storefront.  Her clothes are singed and the air around them shimmers like a summer heat haze.  Suddenly she squeals in delight as flames erupt from her arms and engulf the storefront.  She moves from one store to the next working her way down to the chaos of the docks, driving fleeing civilians from their shelter or melting the flesh from their bones when they move too slowly."),
        name = ccb.content.text("Arson Girl"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "shelter_graffiti_snippets" }
    category:entry {
        id = "shelter_graffiti_psi_1",
        text = ccb.content.text("I can see now.  This place isn't safe.  Leave."),
    }
    category:entry {
        id = "shelter_graffiti_psi_2",
        text = ccb.content.text("<given_name> come find me.  What you told me about, it's real.  I can do it too."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "general_graffiti_snippets" }
    category:entry {
        id = "general_graffiti_psi_1",
        text = ccb.content.text("VOS OMNES SPECULAMUR"),
    }
    category:entry {
        id = "general_graffiti_psi_2",
        text = ccb.content.text("This is a detailed drawing of a pyramid with an eye in it.  Below is written \"We see now.\""),
    }
    category:entry {
        id = "general_graffiti_psi_3",
        text = ccb.content.text("We greet the new dawn"),
    }
    category:entry {
        id = "general_graffiti_psi_4",
        text = ccb.content.text("Dawn is breaking"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "newest_news" }
    category:entry {
        id = "newest_news_psi_1",
        text = ccb.content.text("BURNING MAN!  Eyewitnesses at the recent Bank Rhode Island fire in Cranston stated that they saw a man standing in the burning building, waving his arms as though directing the flames.  The fire raged out of control for nearly four hours before local firefighters were able to extinguish it, but never spread beyond the bank building.  No human remains were found in the debris; investigation is ongoing."),
    }
    category:entry {
        id = "newest_news_psi_2",
        text = ccb.content.text("THE END.  I have written the horoscopes column for almost a decade now but this is the first true prediction of the future I have written.  The end of the world is at hand, in weeks if not in days.  Take your loved ones, leave the cities, head for the hills.  The government will not save you.  This will be my last column."),
    }
    category:entry {
        id = "newest_news_psi_3",
        text = ccb.content.text("LOCAL MAN DISAPPEARS.  Jackson Townsend of Bangor was reported missing this morning.  According to his wife Julie, he was eating breakfast with his family before work when he suddenly looked up and then disappeared.  No foul play is suspected at this time."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "note" }
    category:entry {
        id = "note_psi_1",
        text = ccb.content.text("\"Amazing I lived through whatever the fuck happened to the sky but I should be glad.  Ever since then I've been in the best health of my life.  I got caught by a Z while foraging--fucking stupid of me I know--and it bit me.  I put it down and by the time I was done beating it to hell the wound had already stopped bleeding.  It's almost gone now and I won't even have a scar.  No infection, no fever, nothing.  Not sure what's going on but maybe I should go outside again.\""),
    }
    category:entry {
        id = "note_psi_2",
        text = ccb.content.text("\"I call the fire and it comes.  I send the fire and they burn.  Glorious.\""),
    }
    category:entry {
        id = "note_psi_3",
        text = ccb.content.text("\"I put that crystal I found under my pillow and all I got was nightmares.  Burning cities, the dead walking, horrible monsters, things kidnapping people.  I threw it away but it didn't help.  Now I have nightmares when I'm awake too.\""),
    }
    category:entry {
        id = "note_psi_4",
        text = ccb.content.text("\"Jumping is definitely the reason I'm still alive.  Feels awful but only for a moment.  When that thing grabbed me I bet it thought its dinner was made.  I kind of wish I could have seen the look on its face when I just disappeared.\""),
    }
    category:entry {
        id = "note_psi_5",
        text = ccb.content.text("\"Using the Force is way easier than going into the houses.  Stand out in a storm.  You'll thank me later, if you survive.\""),
    }
    category:entry {
        id = "note_psi_6",
        text = ccb.content.text("\"This is it, the next stage in human evolution.  The sheep weren't worthy and will fall before the ascension of Homo Superior.\""),
    }
    category:entry {
        id = "note_psi_7",
        text = ccb.content.text("\"All this meditating has finally paid off.  You need me to get you something, leave me a note at the old gas station south of Ashland on 93.  You'll have what you need in a couple days.\""),
    }
    category:entry {
        id = "note_psi_8",
        text = ccb.content.text("\"Those things, the ones that sound like people, it's not just their claws.  I saw them lift another guy clear off his feet from thirty feet away and take him apart while he screamed and screamed.  All the while saying shit like \"The store is closing in fifteen minutes.\"  I don't care what they have in those towers, I'm never going anywhere near them again.\""),
    }
    category:entry {
        id = "note_psi_9",
        text = ccb.content.text("\"I always knew there was something off about that office building on main.  I'm not going to check it out because downtown is overrun but I saw weird lights from the top floor two nights running.  Something's still happening up there.\""),
    }
    category:entry {
        id = "note_psi_10",
        text = ccb.content.text("\"Met some girl living out in the wilds west of town.  She snuck up perfectly behind me and held me at gunpoint until she was sure I wouldn't try to steal from her.  Once we had that cleared up, told me to skip north and avoid 90 because some assholes had set up a roadblock.  I asked her how she knew where I was going and she said, \"It was revealed to me in a dream.\"  I should have listened to her.\""),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_psych" }
    category:entry {
        id = "lab_file_psych_psi_1",
        text = ccb.content.text("Preliminary approval is given to use successful candidates from Project GREY DAWN who also have therapeutic training to provide counseling for staff.  Candidates must be paired with a non-candidate member of Counseling staff, who will review all of candidates' notes and session records; members of Counseling staff and candidate counselors are forbidden to be in the same room at any time."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_portal" }
    category:entry {
        id = "lab_file_portal_psi_1",
        text = ccb.content.text("Manned immersion dives to sub-planes with the PHAVIAN designation are to be overseen by at least one mathematician from Project COLD BELOW.  Immersion personnel must obey all instructions given by the mathematician, including collection of anomalous samples or aborting an in-progress dive."),
    }
    category:entry {
        id = "lab_file_portal_psi_2",
        text = ccb.content.text("All samples of XE323, whether found in a PHAVIAN-designate sub-plane are not, are to immediately be turned over to XEDRA-23 on cessation of dive."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_postit_portal" }
    category:entry {
        id = "lab_postit_portal_psi_1",
        text = ccb.content.text("When you collect the crystals, use sampling tongs.  Do not touch!"),
        name = ccb.content.text("orange post-it note"),
    }
    category:entry {
        id = "lab_postit_portal_psi_2",
        text = ccb.content.text("Do not calibrate to sub-plane 305PG.  It knows"),
        name = ccb.content.text("orange post-it note"),
    }
    category:entry {
        id = "lab_postit_portal_psi_3",
        text = ccb.content.text("The \"mathematician\" from upstairs wants to watch the immersion today.  Ugh"),
        name = ccb.content.text("orange post-it note"),
    }
    category:entry {
        id = "lab_postit_portal_psi_4",
        text = ccb.content.text("Accidentally touched a sample, now my head's all fuzzy"),
        name = ccb.content.text("orange post-it note"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_postit_psi" }
    category:entry {
        id = "lab_postit_psi_1",
        text = ccb.content.text("Pink for the body, grey for the eyes, green for…hmm"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_2",
        text = ccb.content.text("Don't look into the dull ones"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_3",
        text = ccb.content.text("If the mathematician asks for me, I was never here"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_4",
        text = ccb.content.text("Our clears keep waking up from screaming nightmares.  Higher-ups say it's nothing"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_5",
        text = ccb.content.text("Subject can lift 14.82g.  15g or higher causes migraine"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_6",
        text = ccb.content.text("Note: order some Zener cards"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_7",
        text = ccb.content.text("ONYX LIGHTNING?  GRAY DAWN?  COLD BELOW?  VERDANT HAND?  Oh come on"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_8",
        text = ccb.content.text("I can't believe she wants to call them psi-cops"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_9",
        text = ccb.content.text("Two more subjects overloaded.  Need to request more"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_10",
        text = ccb.content.text("Maybe a teep can communicate with them"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_11",
        text = ccb.content.text("Reminder: Tell the immersion teams we need more samples"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_12",
        text = ccb.content.text("It won't kill you but you'll wish it had"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_13",
        text = ccb.content.text("Brains show no physical differences"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_14",
        text = ccb.content.text("Animal testing approved.  Try the TK on the mice"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_15",
        text = ccb.content.text("Can't wait for cross-testing"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_16",
        text = ccb.content.text("She tried to scan Y65-08.  Now in a coma"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_17",
        text = ccb.content.text("Scanning them doesn't work.  It's just static"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_18",
        text = ccb.content.text("Stay away from those GRAY DAWN guys.  Creepy"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_19",
        text = ccb.content.text("Need to up monitoring of GRAY DAWN candidates.  Who watches the watchers?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_20",
        text = ccb.content.text("<given_name> is up for awakening.  Ban her from the poker game"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_21",
        text = ccb.content.text("A better lightbulb.  What's next, a matrix mousetrap?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_22",
        text = ccb.content.text("So does my PB still count post-awakening?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_23",
        text = ccb.content.text("What's my dog thinking?  I should ask"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_24",
        text = ccb.content.text("COLD BELOW is a bit too on-the-nose"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_25",
        text = ccb.content.text("\"Gentlemen, clinical immortality is within our grasp\". There, if I write it here I won't be tempted to put it in the powerpoint"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_26",
        text = ccb.content.text("They've done it.  Frikkin laser beams"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_27",
        text = ccb.content.text("I get why.  But TIAMAT or SERVITOR would be much cooler than XE157, right?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_28",
        text = ccb.content.text("Better than kings.  Gods"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_29",
        text = ccb.content.text("There has be more out there.  Cryokinesis?  Prescience?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_30",
        text = ccb.content.text("Be careful in subplane R82-34.  Rodriguez nearly blew the entire team up"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_31",
        text = ccb.content.text("SMOKE USHER can't cure zombification.  Had to try"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_32",
        text = ccb.content.text("Snapped as soon as he entered the dive"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_33",
        text = ccb.content.text("Mix with XE037 for better results?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_34",
        text = ccb.content.text("Have we tried it with mice?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_35",
        text = ccb.content.text("But what is the medium?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_36",
        text = ccb.content.text("I am not going through that training.  Safe?  Yeah, no"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_37",
        text = ccb.content.text("Why does no one else remember <family_name>?  And why isn't he in the employee roster?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_38",
        text = ccb.content.text("We finally find real superpowers and then it all goes to hell"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_39",
        text = ccb.content.text("Brain injections make no difference"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_40",
        text = ccb.content.text("She ran a marathon on a treadmill.  That better be enough data"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_41",
        text = ccb.content.text("Not meeting with that mathematician again.  Once was too much"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_42",
        text = ccb.content.text("All of them, witches"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_43",
        text = ccb.content.text("Need to dive again.  It's better on the other side"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_44",
        text = ccb.content.text("Those poor mice"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_45",
        text = ccb.content.text("We should have just used regular cards"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_46",
        text = ccb.content.text("Going to put \"Psi-cop\" on my resume"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_47",
        text = ccb.content.text("Five percent increase in lifting across the board.  Why?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_48",
        text = ccb.content.text("Can't block them out anymore"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_49",
        text = ccb.content.text("Can they go through halfway?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_50",
        text = ccb.content.text("Same dream, every night"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_51",
        text = ccb.content.text("Great, some of the mice escaped"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_52",
        text = ccb.content.text("It's like a shadow and it won't go away"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_53",
        text = ccb.content.text("SMOKE USHER found something.  It's everywhere.  It's in us"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_54",
        text = ccb.content.text("Zombies can't awaken.  What a surprise"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_55",
        text = ccb.content.text("She hurled a quarter 45.8 smoots"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_56",
        text = ccb.content.text("Highest recorded temperature at 1247°C"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_57",
        text = ccb.content.text("Eyes, always watching from outside"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_58",
        text = ccb.content.text("We're definitely sailing the black seas of infinity"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_59",
        text = ccb.content.text("So how many jigawatts is that?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_60",
        text = ccb.content.text("Never have to worry about a 3% phone again"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_61",
        text = ccb.content.text("Where does all the energy GO?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_62",
        text = ccb.content.text("So is there some kind \"light dimension\" out there too?"),
        name = ccb.content.text("yellow post-it note"),
    }
    category:entry {
        id = "lab_postit_psi_63",
        text = ccb.content.text("Best part of all this is I don't have to memorize passwords anymore."),
        name = ccb.content.text("yellow post-it note"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_biokinesis" }
    -- Phavian designation for biokinetic study is BURNT NOVEMBER.  Designation for use in combat is VERDANT HAND
    category:entry {
        id = "lab_file_biokinesis_01",
        text = ccb.content.text("At 1756 (dive time), Sergeant Eric Collins's team came under attack by an XE157 entity near the end of scheduled in-phase time.  Despite the expenditure of most of their ordinance, XE157 suffered no significant damage and continued its attack.  Despite the known combat capabilities of XE157 and with no regard for his own safety, Sergeant Collins ordered his team to retreat to the dive breachhead and engaged it in hand-to-hand combat, holding it off for several minutes while his team exited the dive.  The aperture was held open for an additional minute afterward, allowing just enough time for a severely-injured Sergeant Collins to exit the dive and preventing the exit of XE157.  Sergeant Collins suffered severe lacerations, the loss of two fingers, and burns across fifty percent of his arms and upper body; he has since volunteered to be a test subject for SMOKE USHER.  In lieu of a medal, we have authorized a meritorious service bonus to be applied retroactive to the beginning of the year."),
        name = ccb.content.text("AAR ID# V78-08"),
    }
    category:entry {
        id = "lab_file_biokinesis_02",
        text = ccb.content.text("Treadmills?  Blood ox tests?  Have them try to punch through walls or something\nAny cellular difference?  Should check\nBrains show no difference but what about organs?  Lactic acid production, inflammation, blood flow, etc.\n\nOutrun a horse?\n\nYeah, yeah, faster than a speeding bullet.  VERDANT HAND vs ONYX LIGHTNING?\nOh come on.\nWhat about jumping distance?  Height?\n\n\n*a doodle of two stick figures engaged in a martial arts battle*\nActually do the shoryuken.  Too bad gun still beats fist\nHadoken?  Wouldn't surprise me at this point\nGrip strength tests?  Charts?  zzzzz  *a surprisingly-detailed picture of a curled-up sleeping cat*\nSummary: Ban them from the Olympics"),
        name = ccb.content.text("Notes written on the back of an unimportant memo"),
    }
    category:entry {
        id = "lab_file_biokinesis_03",
        text = ccb.content.text("The battle of the century!  H84 and E94 will fight to determine the true greatest VERDANT HAND graduate!  No holds barred, no attacks banned, no referee, don't sit in the front row or you might ruin your clothes!  Be there or be square!\n\n*below the text is an picture of a man and a woman striking a boxing pose at each other in an ordinary office room.  Both are wearing street clothes and baring their teeth at each other.  The date of the fight is one week before the end of the world*"),
        name = ccb.content.text("Come One, Come All!"),
    }
    category:entry {
        id = "lab_file_biokinesis_04",
        text = ccb.content.text("Upon leaving for the evening, Dr. Erickson neglected to seal cage #3, allowing one of the experimental mice (#748562) to gain access to the matrix crystal supplies.  One crystal discharged, affecting 748562 and apparently causing an awakening.  748562 escaped the room, squeezing under the door, and is currently loose within the facility.\n\nDr. Erickson has been placed on administrative leave pending a full investigation and new procedures for storing matrix crystals are currently being implemented.  A search for 748562 is still underway."),
        name = ccb.content.text("incident report: 385924"),
    }
    category:entry {
        id = "lab_file_biokinesis_05",
        text = ccb.content.text("They wanted me to keep a logbook of my daily exercise but I don't understand the point.  I run, I lift, I sleep, that's about all these have me do here.  What, they want \"5:40 a.m.: 30 reps 250 lbs, run 20 minutes, 100 burpees (10 sets)\" blah blah who cares?  That shit doesn't matter.  We're all trapped here and things are going to hell and we got some kind of poison in our bodies that's going to bring us back when we die so we can eat brains.\n\nWell, fine, here's my log: 6:05 a.m.: 50 reps 400 lbs, sprint 10 minutes, 200 pull-ups, triple somersault from a standing start.  Put me in the Olympics right now."),
        name = ccb.content.text("torn notebook page"),
    }
    category:entry {
        id = "lab_file_biokinesis_06",
        text = ccb.content.text("They demanded that I include that title on this report even though it's pretentious as hell.  This isn't some superweapon that will change the face of modern warfare, it's just a better form of hand-to-hand combat.  They can't dodge bullets.  They can't punch through brick walls.  They can't do that movie thing where the hero hits a bad guy and the bad guy goes flying twenty feet.  They're just faster and stronger and hit harder, all good things, but they aren't going to beat someone with a gun.  There's a reason we invented guns and why functional martial arts training is about defending yourself and getting away, not about going on the offense.\n\nSo is it worth training people?  That's the wrong question.  This isn't a codified martial art, it's just using dimensional metaphysics to enhance existing methods of combat.  A VERDANT HAND candidate will be better at Muay Thai than anyone who hasn't gone through BURNT NOVEMBER but they still need the actual martial arts training.  This is just another tool.  I'm not sure why there's so much focus on this, to be honest.  With the cost of retrieving materials, surely we could spend that money better elsewhere.  Modern warfare does not rely on single superheroes winning battles."),
        name = ccb.content.text("The VERDANT HAND combat protocols"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_clairsentience" }
    -- Phavian designation for clairsentience study is NOBLE HORIZON.  Phavian designation for use of clairsentience to find appropriate portal targets for immersion dives is COLD BELOW
    category:entry {
        id = "lab_file_clairsentience_01",
        text = ccb.content.text("I'm looking up at the sky.  I can see the same constellations on Earth, but they're shimmering somehow, like there's a haze or a fog or something between us.  Then, the stars start to slowly go out.  Not in a wave, but randomly--one here, one there, faster and faster until the entire sky was dark.  Then the moon disappeared as well and everything went black.\n\nI'm standing on the edge of a cliff.  Below me is the churning sea, the waters black under the stormclouds.  The sea rises slowly as rain falls in sheets, lightning striking the waters.  They break over the edge of the cliff, then over my head.  I drown.\n\nI am standing in a forest.  The trees rustle all around me and the birds sing, and then clouds pass over the sun.  The sun dims and then starts to go black.  It's an eclipse.  The light fades and all the birdsong dies.  I stand in pitch blackness with the rustle of leaves around me."),
        name = ccb.content.text("Notes scribbled on notebook paper"),
        weight = 600,
    }
    category:entry {
        id = "lab_file_clairsentience_02",
        text = ccb.content.text("O21 was placed blindfolded in a completely dark room with a deck of shuffled playing cards, instructed to remove the blindfold, and asked to sort them in standard order: clubs, diamonds, hearts, spades, each in numerical order.  Task was completed in 6:03 with 18/52 cards in the proper order and minor to major ordering errors in all other cards.  O21 was then asked to drink from the coffee cup in the room.  Cup was placed on a shelf above the door to prevent movement around the room from discovering it, but task was completed in 1:14, with the only difficulty being their's height (158 cm) making it harder to reach the shelf.  O21 was then asked to cross the room to the table, pick up the paper, and read the sequence of numbers written on it.  O21 was unable to do so, only correctly reciting the first two digits.\n\nExperiment does uphold the thesis that successful NOBLE HORIZON mathematicians perceive their surroundings through means other than light.  As O21 was unable to read the document, their sense is not \"sight\" as such.  Further experimentation to determine its limits is necessary."),
        name = ccb.content.text("testing report N2-8129"),
        weight = 800,
    }
    category:entry {
        id = "lab_file_clairsentience_03",
        text = ccb.content.text("Dr. Richardson,\nAfter all of the time and money I wish I had more promising news to report.  Netherum mathematics is an inexact science, as you well know, so it's very hard to find a protocol that will work the same every time.  Melchior has the advantage of processing speed but our mathematicians have to put in the hours, but they can make connections Melchior cannot because he can only work with the data he's given, whereas NOBLE HORIZON provides new data.  But, unpredictably.  We've discovered any number of immersion destinations where the physical laws are so different even the probes wouldn't work, much less a dive team.  The majority of them, even BURNT NOVEMBER wouldn't be sufficient to sustain a diver.  There's no value in exotic materials that will probably not survive the transition.\n\nOn the other hand, COLD BELOW did discover Plane 398RG and we got quite a few awakenings out of it before testing was prohibited.  And on the other other hand, they found 9472P where the entire world's biomass had been assimilated by XE157 and we lost the entire dive team because XE157 ignored the probes.  It's like that bell curve meme where Melchior is in the middle and COLD BELOW is both ends.  If only we had a better way to get the far side."),
        name = ccb.content.text("COLD BELOW progress report"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_clairsentience_04",
        text = ccb.content.text("In the interests of testing Dr. Al-Masri's hypothesis, we assembled a group of NOBLE HORIZON and GRAY DAWN mathematicians and had them both attempt to conduct a simple number guessing game.  Melchior provided a six-digit number and both teams attempted to guess it.  GRAY DAWN were competitive when the number was overseen by a third party, as expected, but when both teams were provided with a terminal interface and instructed to enter their guesses, GRAY DAWN scored no better than chance.  On the other hand, NOBLE HORIZON consistently managed to guess at least three digits and successfully guessed the entire six-digit sequence twice (out of ten total sequences).  This disparity was maintained when both groups were placed in empty rooms, instructed to write down their guesses on a sheet of paper, and place it into a box before leaving the room.  Finally, NOBLE HORIZON attained a better than chance score on the final test, when both groups were instructed to guess the sequence before Melchior was asked to provide a sequence.\n\nThis leads to two conclusions.  The first is that the alarmists are wrong; Melchior is not secretly harboring a genius intellect and plotting to control XEDRA from within, it is a computer, capable of processing vast amounts of data and using Netherum mathematics to process that data much faster than would otherwise be possible.  The second is that while GRAY DAWN requires a specific source from which to attain new information, NOBLE HORIZON does not.  Even in situations where no information transfer would be possible, such as the final two testing scenarios, NOBLE HORIZON still had a better-than-chance rate of correctly determining the sequence."),
        name = ccb.content.text("GRAY DAWN vs. NOBLE HORIZON testing"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_clairsentience_05",
        text = ccb.content.text("Dr Richardson,\nLast night, both J99 and V27 approached me with a concern.  As is consistent with NOBLE HORIZON protocol, they have been keeping a dream journal and noticed during the weekly meeting that a few nights ago they had exactly the same dream, down to the smallest details.  You can find the exact details in the weekly report but the gist of it was a giant hand reaching out of the sky and covering the entire Earth and squeezing the Earth until it cracked.  Looking back through previous journals, I found that W88 and P61 had similar dreams within the last week.  I'm still trying to track down if there was a \"patient zero\", so to speak, and if this is some kind of contagious imagery or there is some other obvious explanation, but in the meantime, I'm baffled.  NOBLE HORIZON visions are usually filtered through the individual psyche of the mathematician, and I have no explanation for why in this case multiple mathematicians would exhibit the exact same manifestation.\n\nI'm going to get to the bottom of this.  We already have bad morale after 947188 and this is not going to help.\nJohn Goldberg\nResearcher"),
        name = ccb.content.text("Note on official XEDRA stationary"),
        weight = 500,
    }
    category:entry {
        id = "lab_file_clairsentience_06",
        text = ccb.content.text("J99 was blindfolded and placed in a dark room, spotlit from above, and several members of security were given one dozen ping-pong balls with instructions to throw them at J99 when the signal was given.\n\nTest 1: One security guard as thrower, five seconds advance warning.  J99 avoided every single ball.\nTest 2: Three security guards as throwers, five seconds advance warning.  J99 avoided 25 balls before being grazed by one on the upper arm.\nTest 3: Three security guards as throwers, one second advance warning.  Similar results to test 2, though J99 avoided 20 balls this time.\nTest 4: Three security guards as throwers, no warning.  J99 avoided 18 balls before being hit, though their movements were notably lest coordinated than in previous tests.\nTest 5: Five security guards as throwers, no warning.  J99 avoided 8 balls before being hit.  As expected, with a high enough volume of fire the human body simply cannot move fast enough to avoid them all even if their paths are known."),
        name = ccb.content.text("testing report N5-5519"),
        weight = 800,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_electrokinesis" }
    -- Phavian designation for electrokinetic study is RUBY LOOP
    category:entry {
        id = "lab_file_electrokinesis_01",
        text = ccb.content.text("The testing mathematician was provided with a standard smartphone and instructed to turn on and leave on the flashlight, share their location with multiple provided addresses, and repeatedly delete and re-download several very large testing files (each over 10gb in size).  During breaks, the phone was left streaming HD movies over the cellular network.\n\nResults were very consistent; while the phone's battery rapidly drained while unattended, despite not being connected to power, the battery slowly refilled when the phone was being handled by T47, often reaching or being close to 100% when the time came for a break.\n\nFollowing this, the experiment was modified to have T47 sit and read a book in the same room, but never approach closer than two meters to the phone, which was again set to stream HD movies over the cellular network.  The phone discharged its battery and shut off completely within four hours.  Further testing shows the approximate range of the effect (in T47's case) to be 8 centimeters from their body and that barriers (both conductive and non-conductive) do not impede the effect in any way.  Attempts to use a multimeter to directly measure the strength of the effect were inconclusive, as it changed rapidly up to several times per second and often the multimeter simply could not register any current at all.  I have already submitted a request for further testing to determine the exact parameters of the effect, include its strength and the full variety of devices subject to it, and will submit an update with my results as soon as I have them.\n-Charlotte Manning\nResearcher"),
        name = ccb.content.text("testing report R2-1711"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_electrokinesis_02",
        text = ccb.content.text("I did some work on your proposal to power the facility using RUBY LOOP in the event of continued disruptions over a long timescale and I can say that it's just not going to work.  Sure, a RUBY LOOP guy can keep their phone running basically forever, but it can't scale up.  We finally have the data on those caloric expenditures and yes, I know they don't add up and nothing makes sense, but the \"how much they need to eat\" and the \"how much power they output\" lines do not ever cross no matter what we try.  And yes, I know you're going to bring up A80, but even though she can now throw lightning bolts like an X-man her efficiency rating on power generation is not actually that high among RUBY LOOP mathematicians.  And no, before you ask, hooking up a lightning rod and having her just blast it repeatedly wouldn't generate enough power either.  I thought of it and we did try it, but no dice.\n\nWe're going to have to hope that COBALT THORN comes through if we're stuck in here for too long."),
        name = ccb.content.text("re: power"),
        weight = 800,
    }
    category:entry {
        id = "lab_file_electrokinesis_03",
        text = ccb.content.text("\"Double double toil and trouble\n\"little Jenny wants to play\n\"flash of lightning very frightening\n\"Thunder drive our fears away\n\"Shadows waiting not abating\n\"Hope to all who fear the dark\n\"Shines a light in dark of night\n\"Ever glowing one bright spark\"\nA smear of blood and scorch marks hide any further words that may have been written."),
        name = ccb.content.text("note on the back of a testing report"),
        weight = 400,
    }
    category:entry {
        id = "lab_file_electrokinesis_04",
        text = ccb.content.text("Immediately after immersion into 471XE, the dive team confirmed probe observations that despite not being in any kind of chamber or underground, there were no visible light sources anywhere.  Sgt Simmons ordered the team to turn on their flashlights, and after doing so the team almost immediately came under attack by multiple XE338 entities.  Due to 471XE's effects on Netherum energy, Sgt Simmons ordered V78 to deter the attack using mathematics and the dive team formed a defensive formation while V78 fended off the XE338 attackers with repeated bolts of lightning.  While the attacks were effective, the light itself seemed to function as a deterrent and the dive team was able to withdraw through the aperture in short order with only Dr. Rodriguez suffering any injuries that required more than first aid.\n\nBased on this incident, further travel to 471XE is prohibited without a CRYPTIC FORGE mathematician present and backed up by several high-powered light sources."),
        name = ccb.content.text("AAR ID# Q85-77"),
        weight = 900,
    }
    category:entry {
        id = "lab_file_electrokinesis_05",
        text = ccb.content.text("I flow through the data and watch the patterns stream around me.  I turn and choose between them.  A confidential email exchange, perhaps.  A receipt from a delivery.  A junk email for performance enhancement.  The secret plans of XEDRA management.  All is laid bare before my electronic gaze.  Passwords do not even slow me down.  I hear the voices of the satellites as they chatter in ones and zeroes.  I am a true inhabitant of the digital age, at home on the waves of the sea of information.\n\n*Handwritten below in red are the words, \"Refer I32 for psychological evaluation.\"*"),
        name = ccb.content.text("I am the One"),
        weight = 650,
    }
    category:entry {
        id = "lab_file_electrokinesis_06",
        text = ccb.content.text("I32 was provided an air-gapped, recently-formatted desktop on which a series of text files containing a set of alphanumeric codes had been entered, as well as a notebook and a pen.  The desktop was not equipped with either a mouse, a keyboard, or a monitor.  Despite these limitations, I32 began writing after 23 seconds and within two minutes had transcribed the complete sequence of codes.\n\nFor the follow-up, I23 was provided with the same materials but had no physical access to the desktop.  Timing was similar to the first iteration of the experiment (22 seconds).\n\nFor a second follow-up, I32 also had no line of sight to the desktop due to it being placed in an adjacent room.  While I32 did eventually transcribe the sequence successfully, it took significantly longer (1 minute 15 seconds).  A further experiment to see if a Faraday cage or a shield of particular materials can block the effect is in the planning stage."),
        name = ccb.content.text("testing report R5-3317"),
        weight = 1000,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_pyrokinesis" }
    -- Phavian designation for pyrokinetic study is COPPER PRIME.
    category:entry {
        id = "lab_file_pyrokinesis_01",
        text = ccb.content.text("Z87 was instructed to kindle a flame above his palm, doing so successfully after approximately ten seconds of effort.  Measurements showed the temperature near the flame to exceed 200°C, though Z87 showed no discomfort despite his proximity.  Following instruction of testing authority, subject maintained the flame for 11 minutes and 38 seconds before it dissipated.  A second test showed similar results, though on this second attempt, Z87 could only maintain the flame for 7 minutes and 8 seconds.  While the fire burned with no apparent need for fuel, oxygen concentration measurements taken before, during, and after the test showed that the oxygen content of the room did decrease in line with the apparent size of the flame."),
        name = ccb.content.text("testing report O3-5523"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_pyrokinesis_02",
        text = ccb.content.text("Despite folk wisdom and popular belief, cauterization is ineffective at stopping bleeding or controlling infection compared to nearly any other method.  However, controlled electrocautery is used in modern medicine; can COPPER PRIME show similar levels of effectiveness?\n\nPROCEDURE: Animal testing was done on six cows in order to provide a sufficient volume of blood, since mouse or monkey subjects would be insufficient.  Three mathematicians were used, each augmented with a matrix crystal, to conduct the tests.  Each cow was immobilized and had a series of wounds inflicted using a standard surgical scalpel.\n\nRESULTS: While it was possible to stop bloodflow from non-lacerating wounds and non-arterial bleeding (mathematicians consistently failed to stop arterial bleeding), results were less than promising.  Two cows died immediately after the testing from blood loss and two of the remaining cows showed signs of infection in several of the cuts, showing a higher contamination ratio than electrocautery.  While better than a hot iron, COPPER PRIME is not of high enough effectiveness to consider using for wound treatment, and especially not if SMOKE USHER is available."),
        name = ccb.content.text("Medicinal use of COPPER PRIME"),
        weight = 600,
    }
    category:entry {
        id = "lab_file_pyrokinesis_03",
        text = ccb.content.text("Dr. Richardson,\nAs you requested, I gathered three COPPER PRIME mathematicians for the experiment.  We took them to the walk-in freezer, and provided them with standard physician's examination gowns, ushered them in, and told them to individually knock on the door when they felt ready to come out.  Minimum time was 45 minutes, after which B22 knocked and asked to exit.  The longest was 3 hours, though since I31 reported symptoms of frostbite the following day, he obviously did not follow experimental protocols to exit as soon as he felt significant discomfort.  I admit that some of the fault lies with me, however--I should have chosen a more objective criteria to request exit.  For the next experiment, I intend to equip the mathematicians with temperature monitors and instruct them to leave when their internal body temperature drops to 33.5°.\n\nI'll have a full report written up in the next few days\n-Jacob Sanchez\nResearcher"),
        name = ccb.content.text("testing report O5-8346"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_pyrokinesis_04",
        text = ccb.content.text("Write down my impressions of Netherum mathematics?  How do you describe sight to a blind man?  How do you describe a symphony to a deaf person?  Well, alright, I'll try.\n\nI've heard some of the body people say that they have full awareness, like they're concentrating on every part of their body at once, but that's not what it's like for me.  It's more like focusing on something so hard you lose awareness of your surroundings.  I pick a point in space and I concentrate, and it's like I'm being sucked into it.  I just push on it.  I'm not sure how I can describe it better than that, I push on it with my mind and it starts moving, and when I'm aware of the world again, it's on fire.\n\nWorld on fire.  If I ever get to write about this, that's what I'll call the book.\n\nThe researchers ask me how I know how much energy to add, or how I concentrate, and I just know.  There's a reason we call it \"awakening.\"  I don't even need to think about it, really.  Despite the name it's not like mathematics, where you have to figure out 9 time 34 and carry the 3 and so on, it's like riding a bicycle.  Once I got used to how it worked, I can just do it.  It takes seconds, sometimes less.  I just have to put myself into the right frame of mind and the fire comes.\n\nNot sure how useful that is, but it's what it's like."),
        name = ccb.content.text("V44, experiment impressions"),
        weight = 600,
    }
    category:entry {
        id = "lab_file_pyrokinesis_05",
        text = ccb.content.text("A common question is, why does JUNIPER GOLD have a specific combat-focused division and COPPER PRIME does not?  There are two main reasons.\n\nThe first is that fire spreads.  The use of JUNIPER GOLD poses little extra risk unless an incautious mathematician causes structural damage sufficient to induce a collapse.  Any use of COPPER PRIME can start a fire, and the ability to extinguish fires is far from universal among COPPER PRIME mathematicians.\n\nThe second is the short range.  This is a consistent problem with all mathematics, but the danger of uncontrolled COPPER PRIME usage provides an extra disadvantage.\n\nIn essence, COPPER PRIME has many of the same disadvantages of flamethrowers that led to them no longer being used in active service without few advantages to counteract this; primarily a lack of fuel requirements.  Unless the range problem is solved, military applications of COPPER PRIME will always take a secondary role behind JUNIPER GOLD."),
        name = ccb.content.text("COPPER PRIME combat implications"),
        weight = 750,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_telekinesis" }
    -- Phavian designation for telekinetic study is JUNIPER GOLD.  Phavian designation for telekinetic study for use in combat is ONYX LIGHTNING
    category:entry {
        id = "lab_file_telekinesis_01",
        text = ccb.content.text("Why is there a distinction between pyrokinesis and telekinesis at all?  Fire isn't a fundamental element, it's the result of heat which is the result of molecular motion.  There's no conceptual reason why a pyrokinetic couldn't make all the molecules of an object move in a particular direction, producing motion of the entire object, or a telekinetic couldn't produce a more chaotic motion that resulted in the object's energy increasing.  Furthermore, in no test has a telekinetic been able to move part of an object unless that part is designed for motion; pulling a lever is possible, but breaking a plate in half is not.  And a pyrokinetic cannot apply the reverse and slow down an object's molecules to reduce heat unless that object is on fire.\n\nMy theory is that it's all psychological.  We've all grown up with modern culture and stories about what psychics are \"supposed\" to be capable of, and so the matrix crystals and Netherum mathematics shape the candidates' abilities toward those pre-determined pathways.  If we could get a SMOKE USHER mathematician from an uncontacted tribe, maybe they'd be able to induce diseases in their targets or steal their soul, in accordance with that tribe's beliefs and practices about supernatural powers.  But since our candidates come from a culture where pyrokinesis and telekinesis are separate things and geokinesis or osteokinesis are very rare to nonexistent in fiction, the former result from awakenings and the latter do not.\n\nI would like to formally request a wider variety of cultural backgrounds for our project candidates to test this theory."),
        name = ccb.content.text("It's all just motion"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_telekinesis_02",
        text = ccb.content.text("Sarah,\nI read your email and you're right--it's not a law anymore if we have such an easily-demonstrable counterexample.  \"Newton's Third Conjecture\" doesn't have the same ring to it but seems more accurate.  We've done a lot of experiments to find some sort of consequences for the TKs and so far there's nothing other than the standard metabolic cost.  Netherum mathematics is work, but the mechanism of the force is unclear.  We've already tried both a scale and water displacement and neither of them showed any measurable counterforce.  That leaves a few possibilities:/n1)There is no counterforce.  That breaks classical mechanics in half but frankly we're already at that point anyway.\n2)The counterforce is exerted elsewhere, such as the Netherum.  This is basically just handwavium, \"well, we can't see it but it must be out there.\"  Must it?  Plus then the counterforce isn't actually acting on the origin point anyway unless you buy Dr. Ho's ridiculous \"The soul is a Nether construct\" theory.\n3)The counterforce applies in some way we aren't looking for, like, I don't know, DNA damage or other microscopic-level areas.  We already had comprehensive checkups and didn't find anything, but we're not entirely sure what we're looking for.\n\n\"we're not entirely sure what we're looking for\" is basically the theme of this whole project, honestly.  It's amazing we've discovered as much as we have.\n\n-Neha"),
        name = ccb.content.text("re: the Third"),
        weight = 700,
    }
    category:entry {
        id = "lab_file_telekinesis_03",
        text = ccb.content.text(".00: No penetration\n9mm: No penetration\n10mm: No penetration\n.357: No penetration\n.22: No penetration\n.308: No penetration\n.30-06: No penetration\n.50: Mathematician refused to continue with experiment despite repeated entreaties from supervisors."),
        name = ccb.content.text("testing report J8-9123"),
        weight = 800,
    }
    category:entry {
        id = "lab_file_telekinesis_04",
        text = ccb.content.text("Dr. Richardson,\nPer request, we assessed the ability of three JUNIPER GOLD mathematicians to affect very small masses.  Subjects were ordered to look into a microscope at water flora, then at bacterial samples, and then at images from electron microscopes.  While it makes intuitive sense that larger masses would require more effort and control to manipulate through telekinesis, its actual behavior does not always follow logical constraints--see the way that barriers react to external forces.  In this experiment, we found that manipulating water flora was possible but bacterial samples and electron microscopes both failed.  Our initial hypothesis was that direct observation was required, but the bacterial test provided that is not sufficient to explain JUNIPER GOLD's limitations.  It is currently unclear if this is a psychological limitation or something inherent to JUNIPER GOLD.  Further testing with a wider variety of mathematicians is required.\nMadeline Robbins\nResearcher"),
        name = ccb.content.text("testing report J4-7707"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_telekinesis_05",
        text = ccb.content.text("Are we still supposed to be doing experiments?  Alright, sure, whatever.  I figured throwing things at the wall would be a good way to let off steam, so I got A̶n̶n̶a̶ ̶a̶n̶ H84 and X90 and had them toss increasingly heavier things at the wall.  Weirdest thing, size and speed don't relate.  X90 can lift 10 kg and H84 can only lift 4 kg, but if they're both throwing pencils, H84 can move them faster.  X90 can even lift himself up, though he can't move except up or down.  On the other hand, H84 can rotate a ball at something-something RPM, it was faster than X90 anyway.  I heard a scream from the labs so I didn't have all my equipment, so I just counted them until I lost count.  So we spent a couple hours doing that and we all felt better.  Maybe someone in the ruins of civilization can use this for something."),
        name = ccb.content.text("Big or small, which is it?"),
        weight = 500,
    }
    category:entry {
        id = "lab_file_telekinesis_06",
        text = ccb.content.text("The benefit of being out here is that despite the lockdown we can still go outside as long as we don't leave the grounds.  It used to be hard enough to pick up a baseball and move it the length of a room, but now I can throw it fast enough that I could play baseball if I wanted, still need some practice hitting a target though.  But the best thing is the floating.  I can hover off the ground, maybe a few inches, and move slowly.  I haven't shown this to the testers yet because with how things are getting they'd probably demand I take a walk off the third floor and time how far I got before I dropped.  But maybe I can use this to get over the fence, if I can practice it enough when they're not watching.  I have to get out of here."),
        name = ccb.content.text("Notes on the inside of a manila folder"),
        weight = 500,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_teleportation" }
    -- Phavian designation for teleportation study is LOST RAIN
    category:entry {
        id = "lab_file_teleportation_01",
        text = ccb.content.text("Let's start with the obvious.  Teleportation is moving faster than light, by definition.  Even though our most powerful mathematicians can currently only teleport a few grams a few meters distant, we've used slow-motion photography and confirmed that while the transit is not instantaneous, it's still faster than c.  So, as the saying goes, relativity, causality, faster than light travel, pick two, right?  Which are we going to pick?\n\nWell, as much as it pains me as a physicist to say it, relativity, at least as it relates in this case.  Now we have a third domain alongside quantum mechanics and general relativity: Netherum mathematics.  While I hesitate to speculate on something that we have collected so little data on, it is possible that the Netherum provides its own reference frame coterminous with our own (or multiple) realities.  If we built our satellites with matrix technology, would they still need to account for time dilation?  Would relativity override Netherum mathematics in that case?\n\nBut to return to the title: there is no evidence time travel is possible despite repeated attempts.  Perhaps if we had a LOST RAIN mathematician capable of moving interstellar distances we could ask them to come back before they left.  Barring that, I'm afraid asking LOST RAIN to retroactively avert any disasters is not on the table."),
        name = ccb.content.text("On Time Travel"),
        weight = 800,
    }
    category:entry {
        id = "lab_file_teleportation_02",
        text = ccb.content.text("The basic question is, are we better than the boys over in VERDANT HAND, and the answer is yes.  They're faster but we don't even need to cross the distance.  They hit harder but we build up twice the momentum in half the time.\n\nOkay, I admit, we can't actual replicate the theoretical avoidance strategy due to the obvious downsides of a failed experiment--and anyway, I really don't think anyone has the reaction time unless they're NOBLE HORIZON and thus aren't actually reacting to anything--but we put K52 up against some of the biggest meatheads (if you'll excuse the phrase) from security we had.  K52 is maybe 95 pounds soaking wet and absolutely could not hold up in a fight against even one of our fine volunteers in an actual combat situation.  Well, this wasn't an actual combat situation, but I instructed the security personnel to incapacitate K52 as quickly as possible.  Fifteen seconds later, she had disarmed and disabled all three attackers and we had to slow-mo the footage to even see what had happened.  The most impressive feat was when she blinked behind Jorgenson to avoid a grapple attempt and kicked him in the back of the knee.  You could tell from his expression he really thought he had her.\n\nI think we're ready to roll this out to any other LOST RAIN mathematicians who want the training.  This isn't going to help any in-phase situations but looking at what's going on we'll probably need it here at home too."),
        name = ccb.content.text("TURQUOISE KEYSTONE progress report"),
        weight = 750,
    }
    category:entry {
        id = "lab_file_teleportation_03",
        text = ccb.content.text("Testing began with an area two meters square, marked on the floor by electrical tape.  A robot set to travel at a constant speed of 0.1 m/s, verified before the experiment began, was set on one side of the testing area before LOST RAIN mathematician D85 used his abilities on the area.  The robot traversed the space in 16 seconds, verified by both its internal measuring software and external measurements.  We repeated the experiment with a request to extend the relative distance, causing the robot to take 25 seconds to traverse the space.  It is currently unclear whether the disparity in relative distance change is a property of LOST RAIN itself or of D85's abilities.\n\nThe only difficulty was caused when Dr. Caldwell crossed through the marked space before D85 had ceased maintaining the distortion and almost immediately collapsed.  She was rushed to the infirmary but in the end was discharged after tests showed that she had fainted but suffered no lasting damage.  Dr. Caldwell explained she had experienced severe vertigo on entering the area, possibly caused by a defect in proprioception caused by actual distance being different than perceived distance.  I have submitted a proposal to further test this characteristic of LOST RAIN--see attached."),
        name = ccb.content.text("testing report L4-9469"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_teleportation_04",
        text = ccb.content.text("Attempt 1: Move pencil at least 400 cm: Successful\nAttempt 2: Move pencil at least 2 m: Failed\nAttempt 3: Move pencil inside sealed, clear plastic bag to outside the bag: Successful\nAttempt 4: Move pencil inside sealed, opaque plastic bag outside the bag: Failed\nAttempt 5: Move eraser without moving the rest of the pencil: Failed\nAttempt 6: Rotate pencil during transit of at least 400 cm so that eraser previously facing the door is now facing away from the door: Successful\nAttempt 7: Move pencil 400 cm into pencil sharpener: Successful\nAttempt 8: Move pencil at least 400 cm into bucket of water: Successful\nAttempt 9: Move pencil at least 400 cm into block of ice: Failed\nAttempt 10: Move stationary pencil 400 cm so that it arrives at destination with upward velocity: Failed\nAttempt 11: Preserve velocity of falling pencil after moving it at least 400 cm: Successful\nAttempt 12: Move pencil gripped firmly in hand at least 400 cm: Successful"),
        name = ccb.content.text("testing report L4-2567"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_teleportation_05",
        text = ccb.content.text("Like we won't be for much longer.\n\nNews outside is a nightmare.  I saw some phone video of a giant monster destroying LA before the net went down.  There's no way I'll be able to report this to Dr. Liu, but I finally made a breakthrough.  Or maybe I should say, a breakthrough was made, because I sure as hell didn't do anything to cause it.  I went to go test QN283 today and it just worked.  I didn't change anything, I didn't make any adjustments, I just turned on the remote and the payload vanished and reappeared near the beacon just like it was supposed to.  Is this because of the end of the world?  I can hear gunfire and shouting in the distance and there's nowhere to run because we've been on lockdown for weeks but I invent functional teleportation, one of the greatest discoveries in human history?  Great.\n\nIf I only had gotten C78 to sneak a beacon outside before lockdown.  If she can get out of here with her powers, maybe I can still escape."),
        name = ccb.content.text("It's alive!  IT'S ALIVE!"),
        weight = 700,
    }
    category:entry {
        id = "lab_file_teleportation_06",
        text = ccb.content.text("At 1238 yesterday during COBALT THORN testing, a malfunction occurred, leading to a power surge in the matrix crystal housing.  While Dr. Simmons immediately engaged the shutdown sequence and prevented any damage to the prototype, smoke began filling the room after her actions.  I hit the alarm button but security did not respond before the appearance of an entity since designated XE754.  XE754 immediately attacked Dr. Simmons and Dr. Rodriguez and, though security did arrive within the ideal 1 minute response time, XE754 seemed to be nearly immune to small-arms fire.  Dr. Simmons suffered serious injuries during the attack and when XE754 retreated it appeared to take her with it.  The smoke vanished soon afterward and the COBALT THORN prototype was successfully returned to an inactive state.\n\nFinally, I must protest at the treatment I have received over my accounting of the incident.  This is the third report I have submitted and I have not changed my story in any way.  I was there.  I know what I saw.  I do not understand why I am being put through this or why sole responsibility is being assigned to me when I was not in charge of the project.  I especially do not understand why Dr. Rodriguez has not been subject to the same process nor why I have not been permitted to speak to him.  I worked with him and Julia on this project for six months!  I refuse to be treated this way.\nArthur Mitchell\nResearcher, COBALT THORN"),
        name = ccb.content.text("Incident report: 2945883 (again)"),
        weight = 500,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_OS647_P" }
    category:entry {
        id = "lab_file_item_OS647_P_01",
        text = ccb.content.text("Dr. Zweidler, I understand your excitement at your breakthroughs in matrix technology, but I hope you understand there is no way I can approve OS647-P for general usage.  You write here that the effect field has a \"94% effectiveness rate\" but this is not comparable to ballistic performance standards because it has no ablative properties.  What if the first shot fired is part of that 6%?  How can an operative trust their life to your device when every possible shot might be the one to penetrate?  That fact that your data shows it provides complete protection against rifle rounds, grenades, and even anti-tank weapons is immaterial in the face of the effect field's failure rate.\n\nSecond, you write that currently OS647-P has a 2.67% device failure rate, over and above the chance of the effect field failing!  You want me to recommend this for general usage when our field operatives could end up not only with a bullet in the chest, but also a box full of burnt plastic while some horror is charging at them on an immersion dive?n\nFurthermore, the active time is simply unacceptable.  Ballistic protection works because it provides passive protection with no additional effort necessary.  When in danger, an operative would need to insert the matrix crystal, flip the toggle, and then hope that the attack occurs within the \"5.65 second median protection time\" in order to gain any benefit at all!  You've read those immersion dive reports too, Matthew.  If an operative is face to face with XE157, what happens on the sixth second?\n\nI'll be frank with you.  I'm amazed that you asked me to approve this given its current device specs.  Matrix crystals--even depleted ones--are extremely valuable, and given their already unacceptably-high failure rate in training new mathematicians, Dr. Liu is not going to accept anything less than 100% effectiveness from an alternative use case.  You're simply going to have to refine OS647-P until it's more reliable.\n\nYours,\nAnna Richardson\nDirector of Research"),
        name = ccb.content.text("OS647-P Response"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_QD944_P" }
    category:entry {
        id = "lab_file_item_QD944_P_01",
        text = ccb.content.text("Dr. Doherty,\nHere's the latest updated version of JUKEBOX TALISMAN.  The first thing I have to say is that it finally works--no headaches, no eyestrain, no expensive prop that requires a mathematician to achieve its stated function, no whatever happened during test J4-6553 (hopefully B55 has made a full recovery).  Someone off the street could put on QD944-P and immediately see any potential targets through walls.\n\nNow, the downsides.  Seeing others through walls is all that it can do.  As of yet, we've been unable to achieve the main goals of JUKEBOX TALISMAN.  The next prototype after this one might have gotten closer to meeting the project goals, but it's impossible to tell because anyone, including a GRAY DAWN mathematician, who puts one on immediately gets a splitting headache.  We have also been unable to miniaturize the power source enough to make the glasses inconspicuous, since COBALT THORN still has not gotten below the \"large generator\" stage, and even with existing battery sizes the power draw is considerable.  Hopefully COBALT THORN reaches the miniaturization stage soon.  That said, I think the existing prototype is still valuable enough to be workable while we further refine the design.\nErin McGrath\nResearcher"),
        name = ccb.content.text("QD944-P Progress Update"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_IG882_P" }
    category:entry {
        id = "lab_file_item_IG882_P_01",
        text = ccb.content.text("PATIENT MOSAIC latest update\nI am pleased to report a major breakthrough in the process of personality updating.  A73 volunteered to be the initial subject to test the updated version of the PATIENT MOSAIC process.  Briefing her on the effects of the process demonstrated by X89 did not deter her, as well as a visit to X89 in the infirmary, and after two weeks of studying the process and practicing its initial protocols, she prepared for her first major effort.  A73 had severe arachnophobia stemming from several incidents in her childhood, which was the proximate reason for her to volunteer for PATIENT MOSAIC.\n\nThe process took most of a day and A73 completed it with no ill effects other than hunger (an IV had been administered to prevent dehydration).  When the process was completed, she unwent an MRI, showing no changes in the physical structure of the brain.  Subsequent to the MRI, A73 voluntarily agreed to submit to a test of her arachnophobia.  She showed no reaction to high-definition images of spiders and was able to remain in close proximity to a spider crawling across a table she was sitting at, and while she declined the researcher's suggestion of allowing the spider to crawl on her arm, her vitals showed no undue distress at the suggestion.\n\nFurther testing is necessary to determine the conditions that led to such disparate outcomes, but the results of A73's tests show exceptional promise.  G59 has also expressed willingness to volunteer for PATIENT MOSAIC and I believe we should grant the request.\nRonald Sanchez-Perez\nResearcher"),
        name = ccb.content.text("IG882-P Report"),
        weight = 600,
    }
    category:entry {
        id = "lab_file_item_IG882_P_02",
        text = ccb.content.text("Greetings,\nThank you for your participation in the development of the PATIENT MOSAIC process.  Your work here will advance the foundation of human understand of the inner workings of the mind.\n\nThe PATIENT MOSAIC personality updating process allows the mathematician to change the fundamentals of their personality.  To turn a wallflower to the life of the party, to get rid of your deepest anxieties or fears, to cure depression instead of managing it with therapy or medication.  With refinement, all of these things will not only be possible, but easy, and you will be one of the people who makes it possible.\n\nAt the moment, PATIENT MOSAIC has two primary points of difficulty which you, as a participant, must be aware of.  The first is that it can only be executed by the mathematician upon themselves.  Despite continued progress in the functioning of the process, PATIENT MOSAIC cannot make even the smallest change on another person as of yet.  The second is that the mind is a complex thing and despite the new understanding that GRAY DAWN has brought to us, there is still much to learn.  Small changes can have unexpected ripple effects, leading to undesirable outcomes.  It should be stressed that none of these outcomes are irreversible, but due to the first point, any adverse effects incurred as as a result of the process must be reversed by you; XEDRA researchers and mathematicians cannot assist you except to diagnose any problems that may have resulted.\n\nWe welcome your assistance on this endeavor to expand the frontiers of human knowledge and thank you for your efforts toward the goals of Project PHAVIAN."),
        name = ccb.content.text("PATIENT MOSAIC introduction: GRAY DAWN eyes only"),
        weight = 1000,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_matrix_research" }
    category:entry {
        id = "lab_file_matrix_research_01",
        text = ccb.content.text("Yes, I saw your design specs for the \"Everglow Lamp\" and I understand that it provides a greatly-increased efficiency over standard off-the-shelf lighting.  But may I remind you that off-the-shelf lighting literally comes from a shelf and you can go down to the hardware store and buy a dozen LED bulbs for $50 and they'll last you ten years.  There is no use case for a matrix-powered lightbulb that makes any sort of sense, even in hostile or in-phase environments.  Until you can achieve a similar cost-benefit ratio using matrix technology--check the budget for a single immersion dive if you need the data--I strongly advise you to take your research in a different direction.\n\nYours,\nAnna Richardson\nDirector of Research"),
        name = ccb.content.text("Response to Proposal 96255-R"),
    }
    category:entry {
        id = "lab_file_matrix_research_02",
        text = ccb.content.text("Dr. Richardson,\nAs you directed, we've been attempting to find a way to increase the strength of mathematicians' powers without having to send them on an immersion and we've made a breakthrough.  With some caveats, I'm afraid.\n\nWe put five volunteers through the OBSIDIAN RING process and achieved complete success with two of them.  LOST RAIN mathematician U23, previously capable of expanding or contracting the effective volume of a space up to two meters across by 15%, is now capable of displacing his entire body up to two-thirds of a meter, effectively allowing him to walk through walls.  CRYPTIC FORGE mathematician V97 displayed similar enhancements, suffering no ill effects when exposed to up to 4 Gy of radiation.\n\nUnfortunately, the process is imperfect.  While B54 underwent the process with no apparent effects, BURNT NOVEMBER mathematician E43 has suffered from persistent tremors and muscle weakness since emerging and NOBLE HORIZON mathematician Q12 is currently on leave after suffering from hallucinatory psychosis.  Both candidates are undergoing SMOKE USHER treatment and hopefully will recover soon.\n\nwhile matrix crystals are a rare resource, the sheer amount of additional power available to an OBSIDIAN RING candidate makes the resource expenditure worthwhile.  ONYX LIGHTNING may soon show real progress.\nAlexandra da Silva\nLead Researcher, OBSIDIAN RING"),
        name = ccb.content.text("Preliminary report: OBSIDIAN RING"),
    }
    category:entry {
        id = "lab_file_matrix_research_03",
        text = ccb.content.text("Initial testing shows that the rate of awakening from matrix crystal exposure is just over 10%, generally with no side effects.  Candidates that failed to awaken complained of headaches and bad dreams but the effects rarely last longer than a week (see fig 4).  In approximately 15% of cases, however, awakening causes serious side effects including hallucinations, high fever exceeding 39.5°C, muscle tremors, unconsciousness, disassociation, and amnesia.  This can occur in either successful or unsuccessful awakening and is a serious danger in certain cases (e.g. incident reports ID39483 and IC49378).\n\nMultiple awakenings are not cost-effective.  Despite a wide range of candidates and repeated attempts, only two incidents have ever occurred and no specific commonality between the mathematicians other than gender exist.  No further attempts should be made until a similar effectiveness to initial awakenings has been achieved.\n\nIn-phase awakenings show variable efficacy, sometimes much lower or much higher than normal.  Efficacy is in general consistent within each plane, though some planes show variable efficacy.  Plane 398RG shows 99% efficacy; however, side effects rise to 85% of cases and so further experimentation with 398RG is prohibited.  Melchior has so far been unable to find any specific characteristics of a plane that would lead to greater or lesser efficacy.  Further testing and sampling are required."),
        name = ccb.content.text("Preliminary Report: Matrix Awakening"),
    }
    category:entry {
        id = "lab_file_matrix_research_04",
        text = ccb.content.text("Human-portable laser weapons suffer from three major problems--high power draw preventing them from easily being transportable or usable in skirmish combat, long dwell times meaning that the operator must remain exposed to return fire in order to do anything more than blind the target, and common atmospheric conditions like dust or haze severely reducing the effectiveness of the beam.  The LV-429 solves all three of these problems.  Before the primary laser is fired, a secondary netherum mathematical beam clears the path of the laser, removing atmospheric contaminants without affecting the target.  The laser is fired in a series of short pulses, each much higher intensity than a standard laser, eliminating the need for extensive dwell time.  Finally, the power source contains a small ND-cell, capable of powering the weapon effectively indefinitely.\n\nOne problem remains to be solved.  While the weapon is capable of providing enough power for every shot in succession, matrix technology has not yet provided us with more efficient battery storage.  This means that the ND-cell must charge existing batteries, allowing the LV-429 to be fired only once every few seconds, obviously too low a rate of fire for any live engagement.  An attempt to overcome this limitation by including processed matrix crystals for additional energy production led to unacceptable heat levels, rendering the weapon unusable after less than a minute of sustained fire and, in one case, leading to the detonation of the prototype and the death of the tester.  Further enhancements in power storage technology will be necessary before proper deployment."),
        name = ccb.content.text("LV-429 Analysis"),
    }
    category:entry {
        id = "lab_file_matrix_research_05",
        text = ccb.content.text("Yeah, we did the research.  We're all stuck here so what else can we do, right?  Just research our heart out while the world falls apart.  Well, I've attached all the figures so you can look at them, but the theory is right.  XE037 enhances exposed mathematicians (aka all of them) by a factor of anywhere from 10x to 100x or more, basically as much as using a matrix crystal.  Meshram used to be able to lift around 18.5g, one of our strongest telekinetics.  Now he's up to 2kg and with a crystal he can lift two bowling balls.  Or a dog, that was hilarious.\n\nSubject U76 could pick up surface thoughts if touching the target and now can easily read someone's mind from across the room and can occasionally pick up deeper memories.  We figured this out by accident, by the way, and I'm pretty sure when we get out of here Dr. Connolly is going to find divorce papers waiting for her.  You'll probably want to keep U76 away from anything sensitive, except that we only just discovered this and now it's too late.  Oops.\n\nOh yeah, K34 can just walk through walls now.  So much for security.  Everything's fucked and we're doomed.  That's my report, hope you like it."),
        name = ccb.content.text("XE037 or whatever"),
    }
    category:entry {
        id = "lab_file_matrix_research_06",
        text = ccb.content.text("As my initial report indicated, COBALT THORN has passed all the tests we've performed.  In fact, it exceeded our production predictions by over 15%.  It's not actually a perpetual motion machine but it might as well be from the end-user's point of view.  It produces energy with no fuel required, at a constant rate, with no waste byproducts and very little heat.\n\nHowever--there's always a however in this line of work--it has the significant disadvantage that prevents me from recommending it for deployment at this time.  COBALT THORN works through a microportal to the Netherum, siphoning energy through without the possibility of hostile incursions.  During normal operation, this remains true, but if the device is damaged it can destabilize containment and the portal can rapidly expand without warning.  Just last week we had an incident during testing, and while the engineers were able to get the device shut down quickly, something still came through the portal.  We're lucky that it doesn't seem hostile or really even interested in us.  Despite its appearance (see attached), XE843 is indifferent to the presence or absence of others, light levels, food, or noise.  It just wanders around its containment cell.  We've contacted XEDRA-40 to ask them if they want to take a look at it.  I'll forward the reply to you when we get it.\n\nWork to overcome this significant drawback is ongoing.  At the moment, however, COBALT THORN should remain in the prototype stage.\n\nAnita Morales\nSenior Researcher"),
        name = ccb.content.text("Re: COBALT THORN"),
    }
    category:entry {
        id = "lab_file_matrix_research_07",
        text = ccb.content.text("As requested, we conducted multiple tests using various matrix crystals to determine the precise effect on mathematician capabilities.  The first test subject was V72, representing JUNIPER GOLD.  In previous capability testing, V72 was capable of lifting 10.23g and holding it steady for at least 300 seconds, as well as consistently being able to reduce their acceleration when free-falling to 9.32 m/s².  When holding a charged matrix crystal, the effect was nothing short of astonishing--the mass limit on lifting increased to 2.43 kg and the acceleration when free-falling dropped to 7.17 m/s².\n\nBURNT NOVEMBER Subject Q51 displayed a resting heart rate of 65 bpm, a grip strength of 30 kg, and a 8:31 mile time.  When holding a charged matrix crystal, these improved to 55 bpm, a grip strength of 41 kg, and a 5:45 mile time.\n\nThe evidence shows that skin contact with a charged matrix crystal dramatically improves mathematician capabilities, up to several hundred times depending on their exact capabilities.  While matrix crystals are always in short supply, some of them should definitely be earmarked for usage by our most capable mathematicians."),
        name = ccb.content.text("Matrix mechanics testing report"),
    }
    category:entry {
        id = "lab_file_matrix_research_08",
        text = ccb.content.text("Dr. Richardson,\nI'm writing with some disturbing reports from recent testings.  While the increased capabilities mathematicians have been displaying are at this point well-known among staff, in the course of my research I've observed a number of previously-unseen side effects from performing mathematics.  The most common side effect seems to be headaches, though my staff have also observed several instances of spontaneous nosebleeds.  In at least one instance, a COPPER PRIME experiment with I33 involving heating metals to the melting point, a sudden temperature drop of 15°C was observed in the sealed experimental chamber.\n\nFar more disturbing, however, was an incident during ONYX LIGHTNING testing.  K92 seemingly lost control of her powers when attempting to damage a training dummy, causing severe--and under lockdown, irreplaceable--damage to several testing implements.  When asked to explain herself, she was only able to say that her powers seemed to take on a \"mind of their own.\"\n\nI am still a scientist, regardless of what is happening now.  Be assured that I will get to the bottom of this.\n\nTed Kelly\nSenior Researcher"),
        name = ccb.content.text("Anomalous aftereffects of Netherum mathematics"),
    }
    category:entry {
        id = "lab_file_matrix_research_09",
        text = ccb.content.text("Xinying,\nYou were right.  I looked over the cafeteria camera records and the mathematicians are consistently coming in twice or three times as often as most other people.  Usually just for snacks, but it's pretty consistent that after an experiment, one of them will wander in and grab some chips or an apple or cookies.  We need to start weighing them in and out like they're jockeys or something and seeing if we can get some hard data on this."),
        name = ccb.content.text("Re: energy costs"),
    }
    category:entry {
        id = "lab_file_matrix_research_10",
        text = ccb.content.text("We still don't have any method of nullifying Netherum mathematics that can be used by a mathematician, but the boys down in R&D came out with something they're calling the \"null grenade.\"  BD833-P produces a short-term disruption in anyone affected by it, preventing use of dimensional metaphysics for up to 25 seconds with no further ill effects.  I89 agreed to spend a significant length of time having BD833-P set off next to him repeatedly and a full medical examination showed no problems.  While I89 complained of a small headache, it faded within ten minutes of the last BD833-P detonation and a week later, I89 has shown no lasting ill effects.\n\nNow, the obvious problem: 25 seconds isn't much.  In-phase if a dive team is trying to neutralize a mathematician--so far a theoretical situation, but we cannot rule it out--it should be plenty, but it won't be enough to capture or restrain any target.  It would also be nice to have some way of focusing the effect, some kind of \"null ray\" or something similar.  Research, as they say, is ongoing."),
        name = ccb.content.text("Progress Report: GLASS ORCHID"),
        weight = 500,
    }
    category:entry {
        id = "lab_file_matrix_research_11",
        text = ccb.content.text("Alright, so should I even be working on this?  The world is ending, we're on lockdown, and I'm pretty sure some of my coworkers have lost their minds.  I should be looking for ways to get out of here, right?  But hell, I've always buried myself in my work in a crisis and this sure is one of those.  So my report is that ever since we detected the spread of XE037, COBALT THORN has been running at…well, it's a perpetual motion machine so I can't exactly talk about \"increased efficiency\" but it's been putting out even more power than it was a month ago.  On the order of 3x more.  Maybe all that nonsense about the fabric of space expanding or whatever was right?  I regret to inform you that it's still occasionally popping out monsters, though fortunately the only thing I had to deal with so far has been those blobs and I set up an isolation chamber for COBALT THORN to run in.  It's keeping the lights on down here, so there's that.  If I can just fix that one flaw, we'll see set.  Too bad my assistant is out trying to figure out how to jump floor to floor so they don't have to use the stairs anymore."),
        name = ccb.content.text("COBALT THORN progress report"),
        weight = 500,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_obsidian_ring" }
    category:entry {
        id = "lab_file_obsidian_ring_01",
        text = ccb.content.text("Colleague,\nGreetings.  Your reading of this letter means you have been chosen as an OBSIDIAN RING candidate.  Having already demonstrated proficiency with the fundamentals of matrix mechanics and an understanding of our mission here at Project PHAVIAN, we are offering you the opportunity to participate in experiments into strengthening the fundamental human potential for dimensional metaphysics.  In-phase conditions have shown us that the abilities displayed by mathematicians here are not the absolute limit of those abilities, and if we could replicate some in-phase conditions without the need for an immersion dive, we could expand our mathematicians' capabilities tenfold.\n\nI do have to warn you that the process is not without risk.  While here at XEDRA-23 we have the most advanced medical treatment in the world, there is still a risk of permanent injury should you choose to go through with the procedure.  If you should refuse, your talents remain as valuable as ever and you will suffer no career repercussions.  I look forward to working with you on the next step for Project PHAVIAN and humanity.\nAlexandra da Silva\nLead Researcher, OBSIDIAN RING"),
        name = ccb.content.text("Candidate Introduction"),
        weight = 1000,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_shadow_urge" }
    category:entry {
        id = "lab_file_shadow_urge_01",
        text = ccb.content.text("Candidate is a Black female, aged 45 years, employed in Project PHAVIAN's Building Maintenance division, with early-onset osteoarthritis leading to significant quality of life issues.  Candidate volunteered within hours after the SHADOW URGE posting went out and expressed that, \"Anything is better than how I feel when I wake up nowadays\", unquote.\n\nThe procedure was conducted with mathematicians Q17 and R98 in attendance to attempt to adjust for any unforeseen circumstances, but as it turned out, we needn't have worried.  The next day, candidate reported increased mobility and reduced pain.  One week after the procedure, candidate discontinued her prescription pain medication and has not resumed it.  MRI of affected joints show regrowth of soft tissue and absence of previously-identified bone spurs.  While the requirement of a matrix crystal to provide the catalyst is a significant one and prevents scaling SHADOW URGE up to any significant level at this time, and while we will need to monitor the candidate for an extended period to make sure that her osteoarthritis does not reoccur, this is an exciting step forward in the field of human knowledge.\n\nMaybe Dr. Campbell was right.  Maybe eventually we will cure death."),
        name = ccb.content.text("testing report B4-8558"),
        weight = 1000,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_phavian_memo" }
    category:entry {
        id = "lab_file_phavian_memo_01",
        text = ccb.content.text("Colleagues,\n\nI'd like to take a moment to address the recent rumors.  I know that stress levels are high with the quarantine and the XE037 news, but there is no need to engage in unwarranted speculation.  In these unprecedented times, it's important to remember that we're all in this together and we will solve the problems before us, as we have so many others.\n\nI will be perfectly clear.  There is no \"Project GASPAR.\"  Trained mathematicians are the most important resource that we have, and it would be the height of folly to waste them on replicating a resource that already exists simply because the current state of emergency has placed us out of contact.  Furthermore, it is important to remember that Netherum mathematics are not magic.  They obey a consistent set of rules and we are capable of determining those rules empirically.  We can test how much a JUNIPER GOLD mathematician can lift to the milligram.  We can determine the effective communication range for a GRAY DAWN candidate down to the decimeter.  We would never simply \"throw things at the wall and see what sticks.\"  Science requires rigor.\n\nThese are troubling times, but we will get through them together.\n\nSincerely,\nHarold Liu\nDirector, Project PHAVIAN"),
        name = ccb.content.text("To all employees: re: GASPAR"),
        weight = 650,
    }
    category:entry {
        id = "lab_file_phavian_memo_02",
        text = ccb.content.text("Greetings everyone,\n\nI would just like to take a moment to comment on the importance of proper nomenclature.  Just as we would respect the names and pronouns by which our co-workers wish to be addressed, we should use the approved terms for candidates for the various projects under our umbrella.  Some frankly disturbing news has reached me of harassment or even bullying aimed at those who have gone through the training process.  These people are not \"witches\" and they are most certainly not \"freaks,\" and I am frankly disturbed that I have to emphasize that point.  These are your colleagues who have volunteered to advance scientific understanding as we explore the unknown.  There is no reason standard HR policies do not still apply.  I have already received several complaints which I will be acting on in the near future, and hopefully I will not receive any more.\n\nSincerely,\nRosemary Pierce\nAdministrator, Human Resources"),
        name = ccb.content.text("To all employees: re: terminology"),
        weight = 850,
    }
    category:entry {
        id = "lab_file_phavian_memo_03",
        text = ccb.content.text("Anna, I know things are stressful, especially with some of the irregularities in staff behavior we've been witnessing, and under normal circumstances I would never countenance your proposal.  I have to admit, though, that I was extremely disturbed by what I've heard of the behavior of several VERDANT HAND mathematicians, as well as Dr. Holland and Dr. Almeida's recent public argument.  As such, for the duration of the emergency, I think that your \"psi-cop\" proposal is a good one.  I'll draft a memo immediately to Dr. Nayak to organize the GREY DAWN mathematicians toward keeping order and maintaining morale.  Hopefully, this will only be the matter of a few weeks before Dr. Sidhu and his team can find a solution.  They already found one way to remove XE037 contamination, so hope remains.\n\nSincerely,\nHarold Liu"),
        name = ccb.content.text("Re: your proposal"),
        weight = 250,
    }
    category:entry {
        id = "lab_file_phavian_memo_04",
        text = ccb.content.text("Colleague,\n\nGreetings.  You have selected, or have been selected, to participate in XEDRA-23, or as we call it, Project PHAVIAN.  As a member of XEDRA, you will already have seen many extraordinary things in the course of your work, things which you previously might have scoffed at or dismissed out of hand.  You will see more extraordinary things in the course of your work here, things that even those at other XEDRA divisions would have thought impossible a few years ago.  Phase experiments expand the range of human exploration, but matrix technology unlocks human potential to a degree never before seen.  You will be a part of that endeavor, advancing human knowledge and ensuring the United States of America's place at the forefront of scientific advancement throughout the 21st century.\n\nThere is an ancient proverb that is often translated as \"A single spark can start a prairie fire.\"  Our work here will be the light that will lead humanity into a new age.  I look forward to working with you.\n\nHarold Liu\nDirector, Project PHAVIAN"),
        name = ccb.content.text("Introductory materials"),
        weight = 1150,
    }
    category:entry {
        id = "lab_file_phavian_memo_05",
        text = ccb.content.text("Dr. Liu,\nSorry for the inflammatory title but, well, something is seriously wrong.  The LOST RAIN mathematicians are universally reporting that something strange is happening to space itself.  You've seen the testing data about them being able to change effective distance between two points and they're reporting that ALL distances are being affected to a very small degree.  I don't know if this has anything to do with the erratic behavior from the staff or XE037 contamination but coupled with all the NOBLE HORIZON reports of impending doom, plus all the news filtering from the outside, I think we need to prepare for the worst.\n\nJohn Goldberg\nResearcher"),
        name = ccb.content.text("Something is seriously wrong"),
        weight = 250,
    }
    category:entry {
        id = "lab_file_phavian_memo_06",
        text = ccb.content.text("It is important to remember that we are scientists and this is a scientific endeavor.  Regardless of the phenomena we are studying, we must maintain a proper skeptical mindset in the spirit of scientific inquiry.  Dimensional metaphysics has its own laws that we are slowly discovering.  This is not \"witchcraft\", these are not \"wizards,\" they are people capable of tapping in to a previously-unknown source of energy.  There are many previous fields of science which once carried their own stigma.  Continental drift was not accepted for decades after its initial proposal, Dr. Semmelweis died in an asylum, and quantum  mechanics to this day requires accepting behaviors that are counter to our natural understanding of how the world works.  That does not make any of those fields supernatural either.  By definition, if it is studiable and reproducible, it is scientific.\nAnna Richardson\nDirector of Research"),
        name = ccb.content.text("Maintaining proper decorum"),
        weight = 750,
    }
    category:entry {
        id = "lab_file_phavian_memo_07",
        text = ccb.content.text("No mathematician should be subject to more than ten hours of testing in a two-day period.  Any period of more than four hours of continuous testing must include a half-hour meal break.  Mathematicians are entitled to the same work-week and schedule as researchers are, including days off.  Mathematicians will be informed of the purpose and subject of any experiment they take part in and may register a complaint with HR if they object to their participation.  Note that this does not absolve each mathematician from fulfilling the duties of their employment.  Mathematicians must wear their identifying badges at all times when on-site and present them for inspection at the request of any member of security.\n\nOur mathematicians are not cases, they are not subjects, and they are certainly not \"guinea pigs\" or \"lab rats.\"  They are valuable partners in our exploration of dimensional metaphysics, irreplaceable personnel, and should be treated as such.  Researchers found violating these guidelines will be sanctioned, up to and including termination of employment."),
        name = ccb.content.text("Testing guidelines"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_phavian_memo_08",
        text = ccb.content.text("Dr. Mitchell,\nPer our last email, Dr. Enrique Rodriguez passed away in a car accident almost two years ago, shortly after being assigned to XEDRA as a portal research specialist, and he never had the opportunity to work with XEDRA-23.  As you can see from the employee database, there has never been a Dr. Julia Simmons employed by either XEDRA-23 or any other XEDRA division.\n\nIn addition, the XEDRA handbook requires that all employees use their current title in their signature at all times.  Please update your signature to comply with this policy.\nAlicia Sanders\nSenior Talent Coodinator"),
        name = ccb.content.text("re: re: Incident report: 2945883 (again!!!)"),
        weight = 500,
    }
    category:entry {
        id = "lab_file_phavian_memo_09",
        text = ccb.content.text("Colleagues,\n\nFollowing the recent incident, PHAVIAN is immediately instituting a requirement that all sensitive data be stored offline, on paper, away from possible RUBY LOOP interference.  Incident 523184 has shown us that existing security protocols are utterly ineffective at stopping RUBY LOOP from altering stored data, and while we only lost a week of experimental results, those results include the most recent COBALT THORN test and thus represent a profound blow to our work in advancing human knowledge.  I recognize the difficulty of changing our experimental procedures and our methods of communication so drastically at such short notice, but at the moment we are still not sure how much advancement that other nations have made in the fields of portal immersion or in Netherum mathematics, so it is best to take extreme caution while we develop new protocols around information security.  When we have a update, or an effective counter to possible RUBY LOOP interference, rest assured that I will share it with you immediately.\n\nHarold Liu\nDirector, Project PHAVIAN"),
        name = ccb.content.text("Update: Records Policy re: Incident report: 523184"),
        weight = 1000,
    }
    category:entry {
        id = "lab_file_phavian_memo_10",
        text = ccb.content.text("Dr. Liu,\nBased on these preliminary results, I'm afraid there is no other option than to seek XEDRA-external candidates.  We've run every single employee at site 2 through the resonance detector and none of them came up higher than Minor, with most not even registering at all.  The capability to understand and manipulate dimensional metaphysics seems limited to a small fraction of the population, and until we can figure some way to affect that it means that our mathematician pool is extremely and unacceptably limited.  As such, I propose that we begin limited screening from among other government employees and, if necessary, among the general population.\n\nI recognize the security concerns inherent in this suggestion, but until we can convince the other XEDRA divisions to allow us to screen all of their employees or otherwise find a large pool of cleared candidates, recruitment is going to be the only option.\nJoshua Sanders\nLead Researcher, AZURE SONNET"),
        name = ccb.content.text("External candidates"),
        weight = 850,
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "psi_nether_attention_nightmares" }
    -- These should all relate to being lost, being watched, being trapped, or being chased.
    category:text(ccb.content.text("You dream of running in an endless hallway.  You hear something gargantuan chasing you with heavy breaths and wet squelching sounds.  You run until you are out of breath and wake up exhausted."))
    category:text(ccb.content.text("You dream you are swimming in the ocean, looking up at a million bright stars.  As you tread water, you feel a current from below and the waves around you die down, then you wake up."))
    category:text(ccb.content.text("You dream you are wandering in a dark forest, cutting strips of bark from trees to mark your passage.  As you come to a clearing and see a strip of bark missing from a tree on the other side, you wake up."))
    category:text(ccb.content.text("You dream you are standing on a beach under a sun, swollen and red and filling a quarter of the sky.  The air is hot, and as you watch the sun expands to fill a third of the sky, then half, then more.  As you close your eyes against the blinding light, you wake up."))
    category:text(ccb.content.text("You dream you are sinking into quicksand.  All of your struggles only drive you deeper, and as the sand closes over your head, you wake up."))
    category:text(ccb.content.text("You dream you are going down into the basement to look for something, but as you step off the last step the basement door shuts behind you, leaving you in darkness.  As you climb back up to look for a lightswitch, you hear the stairs creak behind you, and then you wake up."))
    category:text(ccb.content.text("You dream you are waiting in a doctor's office.  Patients go into the door, but no one ever comes out.  As the last person before you vanishes through the back door, you get up to leave but find the front door locked.  As the receptionist calls your name, you wake up."))
    category:text(ccb.content.text("You dream you are in a ruined city, full of empty windows and toppled columns.  No matter where you go, you cannot find a way out, and when you turn a corner and see your own footprints in the dirt-covered cobblestones, you wake up."))
    category:text(ccb.content.text("You dream you stand in total darkness with the sound of something breathing nearby.  The breathing gets closer and closer, until whatever it is, is almost on top of you, and just when you feel a puff of warm, wet air on your face, you wake up."))
    category:text(ccb.content.text("You dream you've taken shelter in a cave to avoid a howling snowstorm.  As you wait, you hear something crunching through the snow and feel the ground start to shake with its footsteps.  As something moves in front of the cave mouth, you wake up."))
    category:text(ccb.content.text("You dream of flying.  You fly higher and higher until you are in outer space.  You look back at Earth and see that it's cracked - something is hatching and a thousand crimson eyes are fixated on you."))
    category:text(ccb.content.text("You are alone in darkness.  You try to move, but all of your limbs are frozen in place.  You can't even blink your eyes.  As you wait, you hear a thin, reedy humming sound from somewhere off in the darkness, slowly getting closer.  You struggle frantically, trying to move even a single finger, as the sound approaches from behind your head.  Just as the humming finally gets within arm's reach and you hear it move closer to your face, you awaken."))
    category:text(ccb.content.text("You dream of standing on top of a cliff in a storm, looking down at the sea.  Holding one arm up against the lashing rain, you watch as the dark waters slowly rise up the cliff, getting higher and higher until it laps at your feet.  You take a step back but the water follows you, covering your feet, then your legs, and then your chest, then your face.  As the black water enters your lungs you awaken with a start, coughing and gasping."))
    category:text(ccb.content.text("You dream of standing in a dark forest.  The trees are so thick that not even moonlight penetrates to the forest floor, and despite waving your arm you can't see your hand in front of your face.  As you slowly walk, trying to pick your way through the forest, you hear the sounds of the insects and the wind slowly die.  The forest is utterly still except for your own breathing, and as you stop and strain your ears, you hear brush rustling in the distance.  Something is coming closer, slowly and inexorably, and when you try to run you almost immediately slam into a tree and fall flat on your back.  Despite the sound of your crashing into the forest floor, the approaching noises do not speed up.  As you try to stand, you hear the rustle of leaves and a wet sloshing on the ground nearby.  As it touches you, you start up in bed."))
    category:text(ccb.content.text("In your dream, you are on the top of a mountain in the wilderness, with no lights nearby and countless stars wheeling overhead.  You lie down in the grass and let the cool night breeze wash over you as you look for the familiar constellations.  You find the Big Dipper with ease and trace a line across to Orion only to do a double-take.  One of the stars on Orion's Belt is missing.  As you look at Cassiopeia, you see the W is broken by a missing star, and then as you look at Leo one of the stars vanishes.  You frantically search the sky as stars wink out, one after the other, until there's only one left.  Polaris, the North Star, steadfast guide of sailors for millennia.  You stand and take a step, not sure what you're hoping to accomplish, and then the last star goes out and you wake up in a cold sweat."))
    category:text(ccb.content.text("You stand in an office room, dingy yellow wallpaper on all the walls and the hum of fluorescent lights in your ears.  You open a door leading to another yellow-wallpapered hallway and walk down it for a few minutes before picking a door and opening it.  You stand in an office room, dingy yellow wallpaper on all the walls and the hum of fluorescent lights in your ears.  You open a door leading to another yellow-wallpapered hallway and walk down it for a few minutes before picking a door and opening it.  You stand in an office room, dingy yellow wallpaper on all the walls and the hum of fluorescent lights in your ears.  You open a door leading to another yellow-wallpapered hallway and walk down it for a few minutes before picking a door and opening it.  You stand in an office room, dingy yellow wallpaper on all the walls and the hum of fluorescent lights in your ears.  You open a door leading to another yellow-wallpapered hallway and walk down it for a few minutes before picking a door and opening it.  The door opens onto solid blackness and in your surprise, you trip through.  As you are falling, you wake up."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "black_nether_water_nightmares" }
    -- These should all relate to blindness, darkness, or cold.
    category:text(ccb.content.text("You dream of falling through a starry void, as the points of light around you slowly wink out one by one."))
    category:text(ccb.content.text("You dream of swimming in the middle of the ocean, when clouds slowly begin obscure the moon and you feel something swimming up at you from below."))
    category:text(ccb.content.text("You dream of stumbling in total darkness for hours."))
    category:text(ccb.content.text("You dream of waking up and finding yourself blind as the undead bang on the walls of your shelter."))
    category:text(ccb.content.text("You dream of walking across a frozen ocean.  Massive shapes are visible in the ice."))
    category:text(ccb.content.text("You dream you are in total darkness with a frigid wind blowing on you, slowly freezing you solid."))
    category:text(ccb.content.text("You have a normal dream of friends from the old days, but as the dream goes on the color fades until you're dreaming in black and white, and then the light fades until you're in total darkness."))
    category:text(ccb.content.text("You dream of standing on top of a skyscraper and watching a sea of fog cover the city below.  One by one, the lights in the windows go out."))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "observed_effect_hearing_sounds" }
    category:text(ccb.content.text("You hear a whisper behind you, too low to make out any words."))
    category:text(ccb.content.text("You hear a single loud footstep behind you."))
    category:text(ccb.content.text("You hear a low growl that fades away into silence."))
    category:text(ccb.content.text("You hear a drawn-out, rasping breath that ends in a cough."))
    category:text(ccb.content.text("You hear a few moments of toneless droning before it abruptly ends."))
    category:text(ccb.content.text("You hear a low hum that makes your teeth vibrate."))
    category:text(ccb.content.text("You hear indistinct yelling, too muffled to make out."))
    category:text(ccb.content.text("Your ears suddenly ring, blocking out all other sounds."))
    category:text(ccb.content.text("You hear a single low tone from a distant bell."))
    category:text(ccb.content.text("You hear a high-pitched tittering that is suddenly cut-off."))
    category:text(ccb.content.text("For a moment, you hear the sound of water flowing over stone."))
    category:text(ccb.content.text("You hear a very faint, \"Tekeli-li!  Tekeli-li!\""))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<telepathy_generic>" }
    -- Used for reading anyone's minds
    category:text(ccb.content.text("«Poor <given_name>…no one deserves to go out like that.»"))
    category:text(ccb.content.text("«Just one more death, one more kill and then I'll be right.  What?  No, why would I think that!»"))
    category:text(ccb.content.text("«I need to go to bed early.  Just please, God, no more nightmares tonight.»"))
    category:text(ccb.content.text("«It's me, hi, I'm the problem, it's me\nAt tea time, everybody agrees\nI'll stare directly at the dammit why can't I get it out of my head!»"))
    category:text(ccb.content.text("«<given_name>…I'm sorry…forgive me…»"))
    category:text(ccb.content.text("«…»\n\nNo thoughts at all.  Maybe they're aphantasic?"))
    category:text(ccb.content.text("«Just let one of those <zombies> get close and it'll get some 5.56 right between the eyes.  Not too close, though.  God damn it, <family_name>, I told you to watch out.»"))
    category:text(ccb.content.text("«Wasn't that long ago we were all eating sushi at the new place in the city.  And now this.  At least I still have food.»"))
    category:text(ccb.content.text("«I would kill for some Foodplace right now.»"))
    category:text(ccb.content.text("«This was the year the Patriots were going to bring it home!  I wonder if any of those guys made it out?  At least the riots didn't start until after the season…»"))
    category:text(ccb.content.text("«So did everyone in the past spend 95% of the time bored as shit?  I hate this.»"))
    category:text(ccb.content.text("«Who would have thought that guy screaming on the street corner was right?  Hell, maybe the FBI really did steal ten billion from him.»"))
    category:text(ccb.content.text("«*tuneless humming*»"))
    category:text(ccb.content.text("«This is like the worst isekai ever.»"))
    category:text(ccb.content.text("«Have to live.  Have to live.  For you, <given_name>.»"))
    category:text(ccb.content.text("«The bees and ants are already the size of dogs.  Are they just going to keep getting bigger?»"))
    category:text(ccb.content.text("«<given_name>, did you make it out?  I should have gone back for you but there were just too many of them.»"))
    category:text(ccb.content.text("«You looked so happy in that mushroom field.  Maybe I should have listened to you.»"))
    category:text(ccb.content.text("«I should have gone camping more.  But maybe I can use that pottery class I took…»"))
    category:text(ccb.content.text("«I should have listened to <given_name>'s stories about the dreams.»"))
    category:text(ccb.content.text("«It's all a dream.  All this is a dream.  I'll wake up soon and it'll be Saturday morning.»"))
    category:text(ccb.content.text("«At least I'll never have to hear any damn <musicgenre> again.»"))
    category:text(ccb.content.text("«I never did make it to Machu Picchu.»"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<telepathy_refugee_guard>" }
    -- Used for reading refugee center guards' minds
    category:text(ccb.content.text("«Ugh, why won't this asshole leave me alone?  I just want to finish my shift and get something to eat.»"))
    category:text(ccb.content.text("«They were just sitting there in the loading dock this whole time.  Right near us.  Could have been any of us trapped in there with them.»"))
    category:text(ccb.content.text("«When I told them I knew how to fight I didn't expect this.  This is nothing like the dojo.»"))
    category:text(ccb.content.text("«Tonight's the night I win it all back.  Don't know how <family_name> pulled off that straight but she can't do it twice in a row.»"))
    category:text(ccb.content.text("«Four hours down, six to go.  But better bored than exciting.»"))
    category:text(ccb.content.text("«At least I'm on guard duty in here and not with one of the caravans.  Those poor bastards.  After what <family_name> looked like when they hauled him back you couldn't pay me enough to go out there.»"))
    category:text(ccb.content.text("«Why me?  Why couldn't this weirdo have talked to <given_name>.»"))
    category:text(ccb.content.text("«Dammit, I know I saw <weird_sky_thing> on shift last night.  Trust <given_name> to give me shit about it.»"))
    category:text(ccb.content.text("«Well, he's definitely never going to write that last book now.  At least people keep bringing Smokes new books.  Don't know what I would do if I couldn't wind down with a good book.  Ha, \"time enough at last\".»"))
    category:text(ccb.content.text("«That fence is not going to stop some of the things we saw on the way here…»"))
    category:text(ccb.content.text("«Endless black glass…sky filled with colors…the screams…thank God it was just a nightmare.»"))
    category:text(ccb.content.text("«To think I used to be a pacifist.»"))
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "<telepathy_follower>" }
    -- Used for reading your followers' minds
    category:text(ccb.content.text("«Every time they leave…is this the time they won't come back?»"))
    category:text(ccb.content.text("«Ugh!  Were they literally bathing in sewage?  What is that smell!»"))
    category:text(ccb.content.text("«Please, just tell me to take a car apart.  I'd rather do that than go back out there.»"))
    category:text(ccb.content.text("«Punching out a jabberwock?  Please.  How stupid do they think I am?»"))
    category:text(ccb.content.text("«Can we really make this place a new home?»"))
    category:text(ccb.content.text("«Well.  At least it beats being dead.»"))
    category:text(ccb.content.text("«They're like a machine.  How do they do it?»"))
    category:text(ccb.content.text("«Oh God, not another fucking training session.»"))
    category:text(ccb.content.text("«If I were injured on a run, would they come back for me?»"))
    ccb.content.add(category)
end
