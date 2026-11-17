local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "backrooms_note" }
    category:entry {
        id = "backrooms_note_1",
        text = ccb.content.text("\"I took all the supplies.  I'm sorry.\""),
    }
    category:entry {
        id = "backrooms_note_2",
        text = ccb.content.text("\"Someday I will wake up.  Someday I will wake up.  Someday I will wake up.  Someday I will\""),
    }
    category:entry {
        id = "backrooms_note_3",
        text = ccb.content.text("\"eat the walls\""),
    }
    category:entry {
        id = "backrooms_note_4",
        text = ccb.content.text("\"STAY QUIET\""),
    }
    category:entry {
        id = "backrooms_note_5",
        text = ccb.content.text("\"pray that you find the same peace I have found\""),
    }
    category:entry {
        id = "backrooms_note_6",
        text = ccb.content.text("\"IF YOU MOVE IT WILL HEAR YOU\""),
    }
    category:entry {
        id = "backrooms_note_7",
        text = ccb.content.text("\"My name is Susan Li.  If you're reading this, I'm dead.  I leave everything I own to\""),
    }
    category:entry {
        id = "backrooms_note_8",
        text = ccb.content.text("\"225 steps from the vending machines to the couch room…  Turn left…  141 steps from the couch room to the portal…\""),
    }
    category:entry {
        id = "backrooms_note_9",
        text = ccb.content.text("\"Welcome to Hell :)\""),
    }
    category:entry {
        id = "backrooms_note_10",
        text = ccb.content.text("\"know because I was wearing my watch.  Today was another bad day.  They nearly saw me as I hauled wood back to the big room, and I lost half of it running away.  Tomorrow, I plan\""),
    }
    category:entry {
        id = "backrooms_note_11",
        text = ccb.content.text("\"I AM IN A TOP SECRET FACILITY BUILT BY THE GOVERNMENT!!  I HAVE BEEN ILLEGALLY KIDNAPPED!!  PLEASE HELP ME!!\""),
    }
    category:entry {
        id = "backrooms_note_12",
        text = ccb.content.text("\"What do you want?  Am I supposed to confess??  What am I waiting for???\""),
    }
    category:entry {
        id = "backrooms_note_13",
        text = ccb.content.text("\"…602,651  602,652  602,653  602,654  602,655  602,656  602,657…\""),
    }
    category:entry {
        id = "backrooms_note_14",
        text = ccb.content.text("\"I AM IN A SMALL ROOM WITH MANY DESKS.  I CAN'T STAY HERE.  COME FIND ME.\""),
    }
    category:entry {
        id = "backrooms_note_15",
        text = ccb.content.text("This note has a bunch of lines all over it.  It looks like it might be a map, but nothing is labeled and you're already hopelessly lost."),
    }
    category:entry {
        id = "backrooms_note_16",
        text = ccb.content.text("This paper is covered in dried blood…  Gross."),
    }
    category:entry {
        id = "backrooms_note_17",
        text = ccb.content.text("This note is covered with tally marks, front to back."),
    }
    category:entry {
        id = "backrooms_note_18",
        text = ccb.content.text("\"NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO NO\""),
    }
    category:entry {
        id = "backrooms_note_19",
        text = ccb.content.text("\"I KILLED THEM.  I HAD TO.\""),
    }
    category:entry {
        id = "backrooms_note_20",
        text = ccb.content.text("\"Casey Blumenthal.  Age 34.  Bangor, Maine.  Hotel receptionist.  The last thing I remember was tripping on a power cord.\""),
    }
    category:entry {
        id = "backrooms_note_21",
        text = ccb.content.text("\"STOP FOLLOWING ME\""),
    }
    category:entry {
        id = "backrooms_note_22",
        text = ccb.content.text("\"IT'S CHASING ME\""),
    }
    category:entry {
        id = "backrooms_note_23",
        text = ccb.content.text("\"Abandon hope, all ye who read this.\""),
    }
    category:entry {
        id = "backrooms_note_24",
        text = ccb.content.text("This note just has scribbles on it."),
    }
    category:entry {
        id = "backrooms_note_25",
        text = ccb.content.text("\"Let me out.  Let me out.  Let me out.  Let me OUT.  LET ME OUT.\""),
    }
    category:entry {
        id = "backrooms_note_26",
        text = ccb.content.text("\"STAY HERE\""),
    }
    category:entry {
        id = "backrooms_note_27",
        text = ccb.content.text("\"I have been blessed.\""),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "backrooms_ancient_news" }
    -- This category is for news before 1950 and should adopt the tone of voice of its era.
    category:entry {
        id = "backrooms_ancient_news_1",
        text = ccb.content.text("CIGARET SHORTAGE EASILY EXPLAINED!  The cigaret industry says Americans are smoking at the fastest rate in history - that's why there's a shortage!  The final production figure will be 257 million in 1943, compared with 243 million in 1942.  Add to this tax-free shipments to armed forces - which were 32 million this year and increasing, up from 8 million in 1942 - and civilians would be struggling this year were it not for excellent crops!"),
    }
    category:entry {
        id = "backrooms_ancient_news_2",
        text = ccb.content.text("STRIKE ORE NEAR KENDALL!  A special of the 15th to the Miner from Lewistown states that there is much excitement around Kendall over the reported striking of a hitherto unknown ore in the Fergus tract, extending out on the flat from the Bullard property, and claims are being located in all directions!  Potential experts on the unknown metal are to arrive in the week."),
    }
    category:entry {
        id = "backrooms_ancient_news_3",
        text = ccb.content.text("THE WEATHER: Fair tonight and Wednesday.  THIS IS REAL COMFORT!  That is what they say when they try one of TROUTMANS' Vudor chair hammocks, $3.50; ask to see them!  Buy one of these for the Fourth of July: Flag, size 5x8 feet, pole and rope ready to hang; price, while they last, $1.75 -- TROUTMANS'!"),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "backrooms_very_old_news" }
    -- This category is for news after 1950 until the time of Cataclysm lore and should adopt the tone of voice of its era.
    category:entry {
        id = "backrooms_very_old_news_1",
        text = ccb.content.text("ABRAMS CONFIDENT S. VIET TAKEOVER IS SUCCESS:  Gen. Creighton W. Adams, commander of US troops in South Vietnam, praised the South Vietnamese army today and said its forces have \"tremendous confidence\" in their continued success.  The disappearance of Gen. Bessemer last month has \"not disheartened the troops\", although Adams has admitted his death at enemy hands is \"likely\"."),
    }
    category:entry {
        id = "backrooms_very_old_news_2",
        text = ccb.content.text("LUNCH MENUS:  MONDAY, February 16 - NO SCHOOL.  TUESDAY, February 17 - Corn dog with catsup and mustard, potatoes au gratin, bread and butter, buttered spinach, apple half, milk.  WEDNESDAY February 18 - Wildcat goulash, buttered green beans, hot rolls and butter, orange jello with pears, milk.  THURSDAY, February 19 - Tacos with cheese and lettuce, applesauce, milk.  FRIDAY, February 20 - Creamed turkey over mashed potatoes, peanutbutter sandwiches, cherry shortcake, chocolate milk."),
    }
    category:entry {
        id = "backrooms_very_old_news_3",
        text = ccb.content.text("ADMINISTRATIVE ASSISTANT SOUGHT:  Eberhard Technologies, Inc. is looking for a full-time (37.5 hours) Administrative Assistant.  This position requires a person with excellent organizational and computer skills, capable of professional discretion in their daily life.  Extensive benefits offered.  Send resume to thaskins@eberhardphoenix.com."),
    }
    category:entry {
        id = "backrooms_very_old_news_4",
        text = ccb.content.text("SEARCH FOR PILOT WHO SAW UFO, DISAPPEARED:  Authorities Wednesday called of a ground, air, and sea search for a pilot who vanished after radioing that his lightplane was being pursued by an unidentified flying object.  An air force reconnaissance plane searched 1,000 square miles of ocean for George Valentina and his Cessna 182.  At one point, Valentina radioed, \"It's not an aircraft…  It's…\" before the transmission broke off.  Residents of King Island have reported sightings of bright and trailing lights over the past six weeks."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "backrooms_old_news" }
    -- This category roughly lines up with Cataclysm's many_years_old_news category and contains some of the same snippets.
    category:entry {
        id = "backrooms_old_news_1",
        text = ccb.content.text("ATOMIC DEREGULATION!  President Toffer announced to a mixed crowd today that he had signed an executive order to deregulate public use of radioactive compounds, allowing more widespread use of low-grade radioactive compounds in home appliances.  \"Plutonium is the greenest energy we have,\" he told an assembled press.  \"It's time we got over our fear and moved into the light.\""),
    }
    category:entry {
        id = "backrooms_old_news_2",
        text = ccb.content.text("US IGNORES UN DEMANDS: The US ambassador to the UN today turned down UN requests to begin mutual nuclear disarmament of China, the US and North Korea.  \"We have a right to defend ourselves,\" insisted the ambassador.  \"We'll back down when they do\"."),
    }
    category:entry {
        id = "backrooms_old_news_3",
        text = ccb.content.text("EDITORIAL: THE UN SHOULD PUT ON ITS BIG-BOY PANTS.  So, driven by decreasing regulation of radioactive materials in the US and China, the UN is pushing hard again for nuclear disarmament.  What a tired old litany this has become.  With deregulation, we've been able to slate three new green nuclear reactors in the Eastern US alone, bringing greenhouse-gas free power to millions of people.  Whatever happened to the UN's focus on global warming?  This is a classic situation of the world painting the USA as villains no matter what we do."),
    }
    category:entry {
        id = "backrooms_old_news_4",
        text = ccb.content.text("EDITORIAL: MORE HOMES NEED GUNS.  While visiting a friend recently, our conversation turned to gun control, and I was shocked to learn that my close friend didn't own a firearm.  In this day and age, not having a deadly weapon in your home shows an appalling lack of personal safety, and I told him so.  Weapons that can kill a man, or several men, in an instant - sometimes even accidentally - are our only hope against other people armed similarly.  I see a utopia of honest citizens keeping each other honest by being armed to the teeth."),
    }
    category:entry {
        id = "backrooms_old_news_5",
        text = ccb.content.text("POPULAR 'ALIEN AUTOPSY' DEBUNKED.  A widely circulated video, making the rounds everywhere from FriendFace to television news, has been debunked as a fake.  This extremely realistic and graphic alien autopsy shows an insect-like creature being dismantled by Japanese researchers, who comment on its anatomy in Japanese throughout the video.  Early observations that the creature was suspiciously similar to those described in the popular works of horror author HP Lovecraft were not sufficient to dislodge the video's viral status.  Yesterday, on the popular social media website Eddit, a 'making of' video was posted, clearly exposing the work as the final film project of a small group of students at UCLA."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "backrooms_recent_news" }
    -- This category roughly lines up with Cataclysm's news segments newer than a few months and contains some of the same snippets.
    category:entry {
        id = "backrooms_recent_news_1",
        text = ccb.content.text("GOVERNMENT SCIENCE BOOST: The government has drastically increased research and development budgets after UN disarmament demands.  \"This not only keeps money in our country, but maintains our lead on China and keeps us defended\", President Oswald said.  \"This is a fight we can't afford to lose.  We're not deaf to the concerns of our population: this is a blanket increase, not just to military R&D spending but civilian as well.  We've authorized the construction of seventy nine new private civilian research facilities along the Eastern Seaboard alone!\""),
    }
    category:entry {
        id = "backrooms_recent_news_2",
        text = ccb.content.text("DRIVING ON A WING AND A PRAYER: A New England man has proven it is possible to create a new car from scrap parts using almost nothing but duct tape.  When asked why he had done it, his answer was \"Well, I didn't have a welder.\""),
    }
    category:entry {
        id = "backrooms_recent_news_3",
        text = ccb.content.text("POLICE TO INVESTIGATE SHADY HILLS.  There will be a \"thorough investigation\" into the Shady Hills nursing home, owned by Shady Hills Corporation, said police Monday.  The announcement came following several lawsuits launching against the home by family members of residents for alleged elder abuse and neglect."),
    }
    category:entry {
        id = "backrooms_recent_news_4",
        text = ccb.content.text("HALLOWAY ANNOUNCES SWEEPING BUDGET BILL.  As rhetoric surrounding national defense spending ramps up, Senate Majority Leader Halloway has announced a controversial bill that would cut over $700 billion from multiple federal organizations, including arts funding and welfare.  He introduced the bill by saying, \"We stand on the edge of a new age of science and discovery, and a new age of danger from enemies abroad.  Hardworking Americans can benefit most by getting involved in our new civilian science programs and making a difference there.  No more sitting at home playing video games!\""),
    }
    category:entry {
        id = "backrooms_recent_news_5",
        text = ccb.content.text("COUNTRY MUSIC FESTIVAL STILL ON.  Predictions of inclement weather won't stop Huey Brooks, owner of Brooks Entertainment, from putting on his famous country music festival.  The event has moved to the Springfield Masonic Center and begins two hours earlier, at 5PM.  As the whereabouts of self-admitted \"party boy\" Jerry Kenny remain unknown, local legend Poppy Summerfield has been brought in to fill his slot."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "backrooms_lost_people_news" }
    -- This category is for 'lost person' classified ads and newspaper snippets about people that have fallen into to the Backrooms, from any era.
    category:entry {
        id = "backrooms_lost_people_news_1",
        text = ccb.content.text("STUDENT MISSING: A high school student vanished yesterday evening in the forest near Wayland.  The 17-year-old student Brett Dong was last seen with his friends in the camp.  \"Brett said that he was gonna get some firewood but he never came back,\" said his classmate, Jianxiang Wang.  The search is underway."),
    }
    category:entry {
        id = "backrooms_lost_people_news_2",
        text = ccb.content.text("CELEBRATED PHYSICIST GOES MISSING.  Dr. Amy Takatoshi, a celebrated quantum physicist at MIT dubbed by some as \"the next Hawking\" has gone missing shortly before a press conference that was expected to be the announcement of her newest research results, rumored to be in the field of teleportation."),
    }
    category:entry {
        id = "backrooms_lost_people_news_3",
        text = ccb.content.text("RUMORS DENIED: Allegations from search parties hunting for Brett Dong, that a civilian research facility just outside Wayland is a front for a government facility researching dangerous technologies, were addressed during a press conference earlier today.  \"I have to clarify that not only have we never done such research,\" said the officer on the press conference.  \"These allegations are absurd.  Teleportation and aliens only exist in sci-fi films, and the US certainly doesn't have the funds to build these extensive underground networks people are talking about.  I can't believe I even have to tell you this.  I don't know what those kids saw that put these ideas in their heads, but they're going through an awful lot with the loss of their friend.\""),
    }
    category:entry {
        id = "backrooms_lost_people_news_4",
        text = ccb.content.text("TELEPORTATION?  An unidentified source working in a major university contacted multiple media outlets this week with a far-fetched story that is nonetheless corroborated by third-party physicists as \"shockingly possible\".  This source, nicknamed \"Deep Space\", describes secret government experimentation into teleportation, dating back to before 2008.  \"When I read the tagline, I just scoffed,\" said Dr. Alice Feyn, a physics professor at MIT.  \"Then I read on.  This is strongly reminiscent of Dr. Takatoshi's lost work.  It feels bizarre to say it, but I think there's a grain of truth to all of this.\"  Dr. Amy Takatoshi was a quantum physicist who went missing, along with all records of her work, in July 2007."),
    }
    category:entry {
        id = "backrooms_lost_people_news_5",
        text = ccb.content.text("KIDNAPPING IN WESTFIELD?  After a week of intense searching, chasing leads across the state, the Oriole County Sheriff's Department have still uncovered no leads in the disappearance of Kasey Akron, 31, postal worker and mother of two.  Akron disappeared without a trace while on the job in Westfield, a small village with a population of only 824, on September 24th.  Her vehicle was found still running, undelivered mail left inside.  Her mother tearfully testified to the Oriole Free Press, \"Kasey was a happy and loved woman.  Wherever she is, we know she wants to come home!\"  Detectives previously suggested that Akron may have departed with someone she knew, but have not made any arrests so far."),
    }
    category:entry {
        id = "backrooms_lost_people_news_6",
        text = ccb.content.text("MYSTERY IN DRESDEN: Nefarious happenings are nothing new for the ever-tumultuous GDR, but the peculiar mystery of two missing actors has captured international attention.  Nani Wolf and Angela Weiss were slated to perform in mere moments, spotted entering their dressing room with fellow company members testifying to every minute and every angle, but when the curtain call came, they were nowhere to be found!  Region police are baffled, but have concluded there was no sign of foul play.  The girls just disappeared!"),
    }
    category:entry {
        id = "backrooms_lost_people_news_7",
        text = ccb.content.text("MISSING MAN: Gerald Bienkowski, age 47.  Disappeared: April 14.  Last seen leaving Tony's Watering Hole in Burlington.  Believed to be of sound mind, but possibly in danger.  If seen, contact local police.  Do not approach."),
    }
    category:entry {
        id = "backrooms_lost_people_news_8",
        text = ccb.content.text("MISSING WOMAN: Anne Demir, age 33.  Disappeared: May 3.  Last seen driving SOUTH of Dallas on I-45 at 8:45pm.  NEW DETAILS HAVE RE-OPENED THIS INVESTIGATION.  New witness footage confirms Demir's car driving SOUTH rather than north, as previously reported."),
    }
    category:entry {
        id = "backrooms_lost_people_news_9",
        text = ccb.content.text("NO TRACE FOUND in search for missing Lisa Hawthorne and her boyfriend Shaun after 58 Civil Air Patrol members spent three days scouring the area near Twelve Mile Trail.  The couple's car was found roadside near the northern trailhead and they were reported missing shortly after.  The couple were \"on a daily hike in a place completely known to them\", says detective Aretha Wesson, who personally knew the two intrepid young athletes."),
    }
    ccb.content.add(category)
end

do
    local category = ccb.content.SnippetCategory { id = "backrooms_unknown_news" }
    -- This category is for snippets that don't make any logical sense.  They have been 'corrupted' by their movement into the Backrooms.
    category:entry {
        id = "backrooms_unknown_news_1",
        text = ccb.content.text("\"St. Mary bingo will be hel777 B24G43A23K19T99 assistance with bond. The empty ap… , , , thsi empty abyss, floating on a salt laboratory abbbbbbbooooooooooooooannaannan.\""),
    }
    category:entry {
        id = "backrooms_unknown_news_2",
        text = ccb.content.text("\"NEWS REPORTED: The absolute fucking apathy!  I hav ?????:D:D don f a    snn          ksk             t  special compartment designed for defacation inside the twentieth centurset sd dddddddddd and THEY DON'T UNDERSTAND WHAT'S HAPPENING BUT I could tell uuuuuuuuuu the smoke outlawed inside\""),
    }
    category:entry {
        id = "backrooms_unknown_news_3",
        text = ccb.content.text("You've never seen anything i never scene 4444442 2222 nsnrwsnennelalkknwns i haven't sen sent the break forest knight calber song ontological corporaction nwensnnnnnnnnnfnnnnnnnnnnnndf ff XD usee?"),
    }
    category:entry {
        id = "backrooms_unknown_news_4",
        text = ccb.content.text("12,32193334 missing platters.  arbitrary statisticality somnolencences somaekllllld 321 was a stinker but they sdneoll the %%%% anaans k.  fol sd  k            so dow n     the          dragin.  alice and her rabid fated to apel,, unex plain."),
    }
    category:entry {
        id = "backrooms_unknown_news_5",
        text = ccb.content.text("    snNOOO I D s. s      an i   s so oo o o    seen the eyes thru th   s d e    .  I tolder once tah     i n        a bear."),
    }
    category:entry {
        id = "backrooms_unknown_news_6",
        text = ccb.content.text("fffeehis thy exclusive eng88 Julietwoiclaim fully sought303 Romeo tirvengeTownto   sk      662ords Fiona PRESSKRRTmLoth.  wnan  oleads have been uncorded."),
    }
    ccb.content.add(category)
end
