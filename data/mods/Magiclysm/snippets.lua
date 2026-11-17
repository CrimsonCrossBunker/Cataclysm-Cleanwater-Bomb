local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "local_files_simple" }
    category:entry {
        id = "magiclysm_local_files_01",
        text = ccb.content.text("IMG_202X0406_221145.jpg\n\nAn image whose grainy quality is indicative of being taken with light-enhancing software correction and image zoom.  The image depicts a campfire in the woods as seen from a short distance away, though zoomed in quite far.  Several child-sized figures are crouched around the campfire dressed in clothes sized for a human adult, their species unclear.  Visible on a spit over the campfire is a human arm."),
    }
    category:entry {
        id = "magiclysm_local_files_02",
        text = ccb.content.text("An archived voice message from a Rhode Island number.\"\n\n\"Gazzak, you there?  Dammit, pick up the phone!  This fucking quarantine means there's no way I can get back to my place so I'm stuck here for the moment.  It's a pretty nice place so I'm not in bad shape yet but no one else here will fucking talk to me.  And can you blame them?  I met some guy who spat on me and tried to attack me while screaming that g-slurs killed his wife.  You've heard the news too, right?  Out in the forest in bands like-\"  The voice cuts off as indistinct shouting is audible.  \"Shit, gotta run.  I'll call you back!\"\n\nThere are no further messages."),
    }
    category:entry {
        id = "magiclysm_local_files_03",
        text = ccb.content.text("209809238942181449.jpg\n\nA screenshot of a Facebook post, with a picture of a ravenfolk wearing six large gold necklaces, rings on each one of their talons, and gold bracelets around their legs, taken at some sort of music festival.  Their arm is around another ravenfolk, who is wearing a flashy dress made of a series of multi-colored scarves, and both of them have their beaks open as though the picture were taken mid-laugh.  In the background are several people, walking around under a night sky lit by several floodlights.  The caption reads, \"EDC!!  At last!!  Living the dream\"."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "flier" }
    category:entry {
        id = "magiclysm_flier_1",
        text = ccb.content.text("This is an advertisement for a magus-for-hire.  \"Heavy things lifted, light things vanished, distances shortened, good times lengthened!  Borunar son of Hrimzon of Clan Ironfist, ThD\""),
    }
    category:entry {
        id = "magiclysm_flier_2",
        text = ccb.content.text("This is an advertisement for magical protective services.  There is a large glossy picture of a spiky, clawed creature with a single, enormous green eye taking up most of its head.  \"With a trained krabgek, your possessions will be safe!  Any thieves will have their flesh rotted right off of their bones!\"  The paragraph of tiny text at the bottom of the flyer containing a series of disclaimers makes you wonder how safe or trained those krabgeks really are."),
    }
    category:entry {
        id = "magiclysm_flier_3",
        text = ccb.content.text("This is a public warning from the Federal Government.  Its brief message, repeated in several languages, reads:  \"The Federal Department of Thaumaturgy is investigating the riots for evidence of possible magical activity.  You or members of your family may be subject to a random inspection by a licensed federal thaumaturgical investigator.  Do not attempt to cure or examine any rioters yourself.  Your cooperation is appreciated.  If you are trained in medical biomancy and would like to assist in the investigation, please contact…\"  The flier ends with a list of numbers and email addresses."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "lab_file_psych" }
    category:entry {
        id = "lab_file_psych_magiclysm_1",
        text = ccb.content.text("Colleagues,\nThe use of animist magic in a therapeutic setting is a well-known part of a comprehensive treatment plan and has been for the better part of century.  Despite the unfortunate reputation that some animists are branded with, and despite the recent cases of spontaneous reanimation, animists are not and have never been merely necromancers.  As magi deal with the physical world, so do animists deal with the spiritual one, including our inner selves.  Rest assured that we are strictly adhering to proper treatment protocols that have been proven effective in clinical settings.  The health and safety of all XEDRA employees is our primary concern."),
        name = ccb.content.text("Memo to All Staff"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "weeks_old_newspaper" }
    category:entry {
        id = "magiclysm_weeks_old_news_1",
        text = ccb.content.text("Letter to the Editor:\n\nI am concerned about recent activity among the local goblin population.  While the riots have us all on edge, lately many of them seem to be keeping to themselves.  My neighbors won't even say hello to me anymore or look at me when I pass them on the street.  Sometimes they leave for days at a time, and I swear I've seen fires burning on the hills.  There's something odd going on and we don't need any more strangeness with everything else that's wrong with the world lately.\n\nSincerely\nEdward Frost"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "months_old_newspaper" }
    category:entry {
        id = "magiclysm_months_old_news_1",
        text = ccb.content.text("SEARCH FOR MISSING CHILD CONTINUES\n\nAs the search continues for Theodore O'Connor, age 7, missing since last Thursday, his mother placed the blame on a goblin family in their neighborhood.  \"They've been lurking around our house for days before Theo disappeared,\" she said during an interview on local television, \"and I just know they had something to do with it.  Please bring our Theo back!\"  Local community organizer Shazgra k'Morħet denounced the claims, stating, \"I thought we had moved past this kind of blood libel rhetoric, but apparently rising tensions are all it takes for old accusations to resurface.  We've all seen the footage of the riots.  They're the most multicultural gatherings we've had in modern times.\""),
        name = ccb.content.text("SEARCH FOR MISSING CHILD CONTINUES"),
    }
    category:entry {
        id = "magiclysm_months_old_news_2",
        text = ccb.content.text("NATIONAL PARKS CLOSED\n\nSecretary of Thaumaturgy Adam Maerhanar released a statement today stating that all national parks would be closed to the public until further notice due to increased wilderness spirit activity.  The notice further stated that the cause was under investigation but an unnamed source indicated it was probably due to natural solar cycles: \"The stars, the sun, the moon, we know these all affect spirits' behavior.  Despite existing alongside them for thousands of years, there's still so much we don't know about them.\""),
        name = ccb.content.text("NATIONAL PARKS CLOSED"),
    }
    category:entry {
        id = "magiclysm_months_old_news_3",
        text = ccb.content.text("LOGGING PROTEST LEADS TO ARRESTS\n\nFive members of the radical activist group Gaia's Children were arrested today as part of a protest over new logging operations being conducted in the Lake Tarleton area.  The members are alleged to have blockaded the entrance to a facility storing logging equipment, using magic to prevent authorities from entering for over an hour before surrendering peacefully.  While no one was harmed during the incident, all the equipment within was irreparably damaged.  Thaumaturgical investigators have stated that the damage is consistent with usage of the Cause Rot spell, knowledge of which is restricted to licensed mages per the MAGIC Act.  A spokeswoman from Gaia's Children stated that its members had taken, \"Appropriate measures to prevent agitating the local spirits and desecrating the sanctity of the Earth.\"  Investigations are ongoing."),
        name = ccb.content.text("LOGGING PROTEST LEADS TO ARRESTS"),
    }
    category:entry {
        id = "magiclysm_months_old_news_4",
        text = ccb.content.text("GREENSCALE CLOSES BORDERS\n\nThe Greenscale Alliance yesterday announced that its borders will be closed to American and Canadian citizens until further notice, and all Alliance citizens are encouraged to return.  \"We appreciate and sympathize with the disruption these measures will cause, but the recent spread of unrest is a threat to our national security,\" said Alliance spokeswyrm Jolgauthrelathenar the Patient, \"In the interests of minimizing risk, the Council of Wyrms has determined that this course is necessary.\"  Jolgauthrelathenar did not take questions after making her statement."),
        name = ccb.content.text("GREENSCALE CLOSES BORDERS"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "one_year_old_news" }
    category:entry {
        id = "magiclysm_one_year_old_news_1",
        text = ccb.content.text("LOCAL WIZARD KILLS THOUSANDS\n\nYesterday Gregory Hamilton, the local Wizard Enforcer, went on a rampage in the local shopping district.  Known for being the most powerful mage in Syracuse, New York, it is unsurprising that he managed to reduce the entire district into a smoking crater.  The National Guard took him out with a team of snipers and 5 helicopters.  Casualties are unknown, but current estimates are 15,000 and climbing."),
        name = ccb.content.text("LOCAL WIZARD KILLS THOUSANDS"),
    }
    category:entry {
        id = "magiclysm_one_year_old_news_2",
        text = ccb.content.text("THAUMATURGICAL RESEARCHER VANISHES\n\nScientists from the only magical research facility in the region reported a breakthrough yesterday.  They reported that their research lead, Ander McDowell, has \"Ascended\" to a greater plane of existence.  They are still looking into the details, because once Ander did so, they only made one statement before appearing to dissolve into the Ether: \"I've found the answer!  It's been Mana all along!\""),
        name = ccb.content.text("THAUMATURGICAL RESEARCHER VANISHES"),
    }
    category:entry {
        id = "magiclysm_one_year_old_news_3",
        text = ccb.content.text("OGRE INFESTATION!\n\nBridgewater officials have reported there are ogres nesting in the Hockomock Swamp area and local residents are urged to avoid the swamps until they can be dealt with.  \"I know what people say on the internet, but they're wrong\", said Bridgewater police spokesman Neal Riley.  \"Ogres are not people like humans or dwarves are.  There are no baby ogres.  They don't grow up, they don't have families, they just show up out of nowhere and start eating people.  They're a menace.\"  Anyone with a verifiable ogre sighting is urged to call 508-555-9523 and report the information."),
        name = ccb.content.text("OGRE INFESTATION!"),
    }
    category:entry {
        id = "magiclysm_one_year_old_news_4",
        text = ccb.content.text("BOSTON WAND BUST NABS THREE\n\nOfficers with the Bureau of Alcohol, Thaumaturgy, and Firearms have seized almost 60 wands, including greater combat wands, during the arrest of three Italian nationals in Boston yesterday.  Davide Messina, 34, Michele Pellegrino, 29, and Lokúr Santoro, 128, all of Rome, Italy, are being charged with three counts of wand trafficking as well as two counts of conspiracy.  The charges allege that Messina, Pellegrino, and Santoro met with an unnamed party as part of a smuggling operation to transport combat wands through America to final destinations in Central and South America."),
        name = ccb.content.text("BOSTON WAND BUST NABS THREE"),
    }
    category:entry {
        id = "magiclysm_one_year_old_news_5",
        text = ccb.content.text("ALTERNATIVE PORTAL TECHNIQUES?\n\nLeaked data from researchers indicates that newly sourced elements may allow for a dramatically reduced cost of establishing freestanding translocation portals.  Exhaustive testing of these alternative gateways appears to be slated to begin next year."),
        name = ccb.content.text("ALTERNATIVE PORTAL TECHNIQUES?"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "many_years_old_newspaper" }
    category:entry {
        id = "magiclysm_many_years_old_news_1",
        text = ccb.content.text("SEARCH FOR UNIVERSAL HEALING SPELL CONTINUES\n\nStaff at Johns Hopkins University yesterday announced promising results in the long search for a health catalyst spell.  While an actual prototype formula has not been released, the draft paper indicates that animal testing showed a five percent decrease in long-term mortality rates in rats suffering from a dozen different types of cancers.  \"A true universal healing catalyst spell would really be the Holy Grail\", said Dr. Olivia k'Ħarzag, Director of Thaumaturgical Oncology Research at Johns Hopkins University.  \"Modern cancer research's greatest limiting factor is that the most potent biomantic healing spells can only affect the caster.  If we can find a way to encourage the body's own defenses that works on a wide scale, even if we can't directly cure the cancer, we could save so many more people.\""),
        name = ccb.content.text("SEARCH FOR UNIVERSAL HEALING SPELL CONTINUES"),
    }
    category:entry {
        id = "magiclysm_many_years_old_news_2",
        text = ccb.content.text("LOCAL WIZARD DIES, INVESTIGATION CONTINUES\n\nInvestigations are continuing into the death of local wizard Sivi, daughter of Ḥalmet of Clan Redaxe, who was found dead in her home last month.  No foul play is suspected at this time.  An initial report by medical examiners at Massachusetts General Hospital indicated the cause of death as multiple organ failure following a sudden illness.  \"It's very strange\", said a source close to the matter, \"Her organs all looked like those of an elderly person, even though 96 is barely middle-age for a dwarf.  She could have expected to live another hundred years easily.  If you ask me, it's all that research she was doing into the effects of Haste magic.  Probably hasted herself right through to the end of her life.  We've seen side effects in Haste over-usage before but never to a fatal degree.\"  When asked for comment, Dr. Olivia Wright, a professor of control thaumaturgy at MIT&M, said, \"The idea of \"haste-death\" shows up in rumors repeatedly but there has never been a single confirmed case.  Haste places stress on the body, of course, but the stress is accounted for as part of the effects of the spell.  Ms. Sivi's death was tragic, but fearmongering about the effects of magic helps no one.\""),
        name = ccb.content.text("LOCAL WIZARD DIES, INVESTIGATION CONTINUES"),
    }
    category:entry {
        id = "magiclysm_many_years_old_news_3",
        text = ccb.content.text("AAMB ANNOUNCES BIOMANCY BREAKTHROUGH\n\nThe American Association of Medical Biomancy today announced a breakthrough in the use of cure disease spells against the novel coronavirus.  The press release stated that efficacy had broken 90% and a full cure had been achieved for the first time.  \"Magic doesn't have a mind of its own,\" said AAMB representative Dr. Ssmthisk, \"it has to be adapted to new circumstances just as any other art or science does.  Just as new weapons called for refinement of protection spells, new diseases require new thaumaturgical treatments.\"  Dr. Ssmthisk also stressed the importance of the ongoing vaccination effort in overcoming COVID-19.  \" I know it's not the news everyone wants to hear, but a vaccine is really the only way out.  Even if every biomancer in the country licensed to practice medicine spent every waking hour and all of our mana curing COVID-19, it would still take us over a decade just to cure the people who have it now, and that's not counting any new infections in the meantime and takes us away from any other treatments we could do.  So please follow the appropriate precautions.\""),
        name = ccb.content.text("AAMB ANNOUNCES BIOMANCY BREAKTHROUGH"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "note" }
    category:entry {
        id = "magiclysm_note_1",
        text = ccb.content.text("\"(Spell Name) RECIPE V3\n---\nRare Ingredients:\n- 17 drams owl's blood - less no effect, more turns bear into large owl\n- 1 gastrolith, large American alligator\n- 3 teeth or claws from a honey badger\n- 8 pounds bear meat, preferably polar bear, grizzly will suffice\nBring a large pot (meat must fully submerge) filled about half way with potion starter fluid (high grade) to a boil.  Add gastrolith and teeth/claws after boiling, add the blood, stir counterclockwise for a minute while chanting standard polymorph spell.  Continue until concoction has a slight glow.  Add the bear meat, remove from heat, cover for 24 hours.\nBear MUST eat all 8 pounds of the meat (claws and gastrolith optional).\n---\n*I've finally gotten my hands on enough polar bear meat.  The grizzly variations are a bit lackluster.*\nThere are flecks of blood on the page.\""),
    }
    category:entry {
        id = "magiclysm_note_2",
        text = ccb.content.text("\"Musings on Orichalcum\n\nOrichalcum is a primarily copper based alloy, but the creation varies from person to person in terms of minor metals and exact procedure.  While not substantially stronger than steel, it's far more resistant to corrosion and general wear (some say it has a will to remain in its shape).  While conventional ancient magical swords of power exist, a lot of the common understanding is based on pre-industrial people finding orichalcum weaponry in tombs and such in working condition.  So why isn't orichalcum used in industrial contexts?  The issue is that the magic can start to degrade if not forged with proper skill.  For most failures it will revert in terms of minutes (never being orichalcum in practice to begin with), but there is a notable risk of failure up to 30 years, meaning that objects have to be \"aged\" like wine to be considered true orichalcum.  Although slightly easier than forging it from scratch, reforging existing orichalcum poses the same problems, thus blocking industrial manufacturing and limiting it to craft use.  You can find it in old armor and weaponry, but also in expensive heirloom cutlery and such.  There is still an active community of hobbyists and artisan experts, but orichalcum is like many other magical phenomena not suited for our modern society at large.\""),
    }
    category:entry {
        id = "magiclysm_note_3",
        text = ccb.content.text("\"There was a riot at the mall here.  The only explanation I have is that some idiot was experimenting with a Mass Berserk spell.  There's a *reason* those kinds of spells are classified as military secrets…\""),
    }
    category:entry {
        id = "magiclysm_note_4",
        text = ccb.content.text("\"Took the bones.  I can use them for luck.\""),
    }
    category:entry {
        id = "magiclysm_note_5",
        text = ccb.content.text("\"Now's the time we really could use a hidden village of the elves out there.\""),
    }
    category:entry {
        id = "magiclysm_note_6",
        text = ccb.content.text("\"I should have majored in thaumaturgy like my mother said.  Down to a dozen bullets, two bandages, one canteen of water…need to raid the town tonight.  It's now or never.\""),
    }
    category:entry {
        id = "magiclysm_note_7",
        text = ccb.content.text("If only our ancestors hadn't lost the ability to fly."),
    }
    category:entry {
        id = "magiclysm_note_8",
        text = ccb.content.text("Stock up on those broken windows.  They'll help you get in and out without being seen."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "magic_door_graffiti" }
    category:text(ccb.content.text("A circle of esoteric symbols etched into the metal wall, they draw your eye with their otherworldly shapes."))
    ccb.content.add(category)
end
