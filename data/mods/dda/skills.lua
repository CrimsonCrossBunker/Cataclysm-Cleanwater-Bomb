local ccb = require("ccb")
local content = ccb.content

-- Native skill definitions
do
local definition = content.Skill {
    id = "speech",
    name = ccb.content.text("social"),
    description = ccb.content.text("Your skill in speaking to other people.  Covers ability in boasting, flattery, threats, persuasion, lies, bartering, and other facets of interpersonal communication.  Works best in conjunction with a high level of intelligence."),
    display_category = "display_interaction",
    sort_rank = 26000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("recruiting", 15)
definition:level_description(0, ccb.content.text("You probably don't care about talking to other people much."), ccb.content.text("You're not used to talking to people."))
definition:level_description(1, ccb.content.text("You know how to communicate."), ccb.content.text("You rarely offend people by accident."))
definition:level_description(3, ccb.content.text("You're a good communicator."), ccb.content.text("You can communicate your ideas well."))
definition:level_description(5, ccb.content.text("You know effective communication methods and sales tactics."), ccb.content.text("You can make friends easily and drive a hard bargain."))
definition:level_description(9, ccb.content.text("You're possibly a psychologist."), ccb.content.text("You could sell ocean water to a hermit crab."))
definition:companion_rank_factors(0, 1, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "computer",
    name = ccb.content.text("computers"),
    description = ccb.content.text("Your skill in accessing and manipulating computers.  Higher levels can allow a user to navigate complex software systems and even bypass their security."),
    display_category = "display_interaction",
    sort_rank = 24000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:level_description(0, ccb.content.text("You barely know the minimum of how to use a computer."), ccb.content.text("You can navigate to the \"phone\" app on your smartphone and likely \"hunt and peck\" to type."))
definition:level_description(1, ccb.content.text("You knew how to surf the web back when that was possible."), ccb.content.text("You can probably touch-type."))
definition:level_description(3, ccb.content.text("You're aware what a \"command prompt\" is."), ccb.content.text("You can debug a mod conflict for a video game."))
definition:level_description(5, ccb.content.text("You know how to write code in a few scripting languages."), ccb.content.text("You can make your own mods for a video game."))
definition:level_description(7, ccb.content.text("You have an in–depth knowledge of code and how computers function."), ccb.content.text("You can code your own video game."))
definition:level_description(9, ccb.content.text("You have probably read the entire SICP."), ccb.content.text("You could get paid to bounty-hunt vulnerabilities in government databases, if any government was still around."))
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "firstaid",
    name = ccb.content.text("health care"),
    description = ccb.content.text("Your skill in effecting medical treatment.  Higher levels allow better use of medicines and items like bandages and first aid kits, and reduce the failure and complication rates of medical procedures."),
    display_category = "display_interaction",
    sort_rank = 25000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("hunting", 10)
definition:companion_practice("combat", 10)
definition:level_description(0, ccb.content.text("You barely have any idea how your own body works."), ccb.content.text("You might be able to put a Band-Aid on a minor cut without passing out."))
definition:level_description(1, ccb.content.text("You're at least aware the blood should stay inside you."), ccb.content.text("You can do basic first-aid techniques without panicking too much."))
definition:level_description(3, ccb.content.text("You have a decent idea of first aid."), ccb.content.text("You're used to using a first-aid kit."))
definition:level_description(5, ccb.content.text("You're well-trained in first aid."), ccb.content.text("Dealing with injuries is becoming routine for you."))
definition:level_description(7, ccb.content.text("You know a lot about how the body works and how to deal with many injuries."), ccb.content.text("You could probably work in the ER."))
definition:level_description(9, ccb.content.text("You may know how to do simple surgeries."), ccb.content.text("You almost certainly can perform a simple surgery."))
definition:companion_rank_factors(0, 1, 1)
content.add(definition)
end
do
local definition = content.Skill {
    id = "mechanics",
    name = ccb.content.text("mechanics"),
    description = ccb.content.text("Your skill in engineering, maintaining and repairing vehicles and other mechanical systems.  This skill covers the craft of items with complex parts, and plays a role in the installation of bionic equipment."),
    display_category = "display_interaction",
    sort_rank = 22000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("menial", 10)
definition:companion_practice("construction", 20)
definition:level_description(0, ccb.content.text("You know that cars are supposed to be able to go forward."), ccb.content.text("You can change a wheel.  Potentially."))
definition:level_description(1, ccb.content.text("You know how to check your oil."), ccb.content.text("You can do the basics of car maintenance."))
definition:level_description(3, ccb.content.text("You know the basic ideas of how a car works."), ccb.content.text("You can fix most common issues your car could have."))
definition:level_description_practice(4, ccb.content.text("You can install an engine."))
definition:level_description(5, ccb.content.text("You know how to fix most issues a car could have."))
definition:level_description_practice(8, ccb.content.text("You're a skilled enough mechanic you can install a second engine."))
definition:level_description(9, ccb.content.text("You know how to build a car from scratch."))
definition:companion_rank_factors(0, 0, 1)
content.add(definition)
end
do
local definition = content.Skill {
    id = "traps",
    name = ccb.content.text("devices"),
    description = ccb.content.text("Your skill in manipulating fine devices like security systems, traps, locks and other precision tasks.  This skill does not affect the evasion of traps that are triggered."),
    display_category = "display_interaction",
    sort_rank = 23000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("", 15)
definition:companion_practice("gathering", 15)
definition:companion_practice("trapping", 80)
definition:level_description(0, ccb.content.text("You know keys go in locks and traps go off if you step on them."), ccb.content.text("You shouldn't try disarming anything, you'll only hurt yourself."))
definition:level_description(1, ccb.content.text("You know how to set basic traps."), ccb.content.text("You might be able to pick the simplest locks and can disarm basic traps."))
definition:level_description(3, ccb.content.text("You know how to set most traps and how most locks function."), ccb.content.text("You can easily disarm most traps and pick some locks."))
definition:level_description(5, ccb.content.text("You're a knowledgeable trapper and locksmith."), ccb.content.text("Lockpicking shouldn't be a problem for you."))
definition:level_description(9, ccb.content.text("You have an intricate understanding of traps and locks."), ccb.content.text("You can disarm a landmine.  It's still extremely unsafe.  But you can.  Probably."))
definition:companion_rank_factors(0, 1, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "driving",
    name = ccb.content.text("vehicles"),
    description = ccb.content.text("Your skill in operating and steering a vehicle in motion, from cars and boats to helicopters and hot air balloons.  A higher level allows greater control over vehicles at higher speeds, and reduces the penalty of shooting while driving."),
    display_category = "display_interaction",
    sort_rank = 27000,
    teachable = true,
    obsolete = false,
    consumes_focus = false,
}
definition:level_description(0, ccb.content.text("You know what a car looks like."), ccb.content.text("You don't even have a driver's license."))
definition:level_description(1, ccb.content.text("You know the basics of driving a car."), ccb.content.text("You were good enough to get a driver's license."))
definition:level_description(3, ccb.content.text("You know how to drive a car."), ccb.content.text("You've driven a car enough for it to become routine."))
definition:level_description(5, ccb.content.text("You probably know how to drive larger vehicles like a truck or bus."), ccb.content.text("You're better than most drivers on the road.  Well, not that any are left."))
definition:level_description(7, ccb.content.text("You know how to drive even in difficult conditions."), ccb.content.text("You can keep control of most vehicles even in awkward conditions."))
definition:level_description(9, ccb.content.text("You know tricks even racecar drivers use."), ccb.content.text("You could compete on a race track."))
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "swimming",
    name = ccb.content.text("athletics"),
    description = ccb.content.text("Your athletic ability, including swimming, endurance, and controlling living mounts.  Higher levels improve cardio fitness, stamina, mounting, balance, and riding speed."),
    display_category = "display_interaction",
    sort_rank = 21000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("", 5)
definition:companion_practice("gathering", 5)
definition:companion_practice("trapping", 5)
definition:level_description(0, ccb.content.text("You don't even let people tell you that you should be more active."), ccb.content.text("You're a couch potato."))
definition:level_description(1, ccb.content.text("You're at least aware exercise is good and that you should do it more."), ccb.content.text("You might be able to doggy paddle."))
definition:level_description(3, ccb.content.text("You know how to exercise and how to keep your balance on a mount."), ccb.content.text("You're reasonably active, a decent swimmer, and can handle a calm mount."))
definition:level_description(5, ccb.content.text("You know proper form, stretches, and the basics of controlling a moving mount."), ccb.content.text("You're active, a good swimmer, and steady in the saddle."))
definition:level_description_practice(7, ccb.content.text("You're very active, a great swimmer, and can control a mount under pressure."))
definition:level_description(9, ccb.content.text("You could be a personal trainer."), ccb.content.text("You could swim across the English Channel."))
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "fabrication",
    name = ccb.content.text("fabrication"),
    description = ccb.content.text("Your skill in working with raw materials and shaping them into useful objects.  This skill plays an important role in the crafting of many objects."),
    display_category = "display_crafting",
    sort_rank = 17000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("", 10)
definition:companion_practice("gathering", 10)
definition:companion_practice("trapping", 10)
definition:companion_practice("menial", 60)
definition:companion_practice("construction", 70)
definition:level_description(0, ccb.content.text("You barely know which side of the hammer you should hold."), ccb.content.text("You can only craft the most basic things."))
definition:level_description(1, ccb.content.text("You know how to hold a hammer."), ccb.content.text("You can craft a few basic things."))
definition:level_description(3, ccb.content.text("You're a decent DIYer and know how to craft a variety of wooden items or very basic metalworking."), ccb.content.text("You can craft a variety of useful stuff without much issue."))
definition:level_description(5, ccb.content.text("You're a fairly skilled DIYer and know how to craft a variety of metal items."), ccb.content.text("You can easily craft useful, if junky, weapons and armor, but nothing too complex."))
definition:level_description(7, ccb.content.text("You're an exceptionally skilled DIYer and know how to smith basic tools and weapons."), ccb.content.text("You can craft even complex objects without fail."))
definition:level_description(9, ccb.content.text("You know the ins and outs of making almost anything you can think of."), ccb.content.text("You have created many things with your hands and you should have little issue crafting anything."))
definition:companion_rank_factors(0, 0, 1)
content.add(definition)
end
do
local definition = content.Skill {
    id = "cooking",
    name = ccb.content.text("food handling"),
    description = ccb.content.text("Your skill in combining food ingredients to make other, tastier food items.  Also includes food preservation and safety, brewing, butchery, and more."),
    display_category = "display_crafting",
    sort_rank = 16000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("menial", 15)
definition:level_description(0, ccb.content.text("You probably lived on takeout."), ccb.content.text("You'd burn a PB&J, somehow."))
definition:level_description(1, ccb.content.text("You know the basics of how not to burn your house down."), ccb.content.text("You can boil an egg."))
definition:level_description(3, ccb.content.text("You know how to cook reasonably."), ccb.content.text("You can cook a variety of recipes."))
definition:level_description(5, ccb.content.text("You know how to cook a wide variety of food."), ccb.content.text("You can cook most recipes with ease."))
definition:level_description_practice(7, ccb.content.text("You'd win a neighborhood bake-off."))
definition:level_description(9, ccb.content.text("You know how to cook the most advanced and complex dishes."), ccb.content.text("You'd be an excellent chef, too bad all the zombies want to eat is you."))
definition:companion_rank_factors(0, 0, 1)
content.add(definition)
end
do
local definition = content.Skill {
    id = "tailor",
    name = ccb.content.text("tailoring"),
    description = ccb.content.text("Your skill in the craft and repair of clothing, bags, blankets and other textiles.  Affects knitting, sewing, stitching, weaving, and nearly anything else involving a needle and thread."),
    display_category = "display_crafting",
    sort_rank = 20000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("menial", 15)
definition:level_description(0, ccb.content.text("You know nothing about tailoring."), ccb.content.text("You can put a shirt on without ripping it, at least."))
definition:level_description(1, ccb.content.text("You know the very basics of how to sew a patch over a small hole."), ccb.content.text("You've held a sewing needle once or twice."))
definition:level_description(3, ccb.content.text("You know how to sew."), ccb.content.text("You can repair or sew simple clothing."))
definition:level_description(5, ccb.content.text("You know how to sew well."), ccb.content.text("You can repair or sew more complex clothing."))
definition:level_description(7, ccb.content.text("You know how to sew with non-standard materials."), ccb.content.text("You're skilled at working with non-standard materials like Kevlar."))
definition:level_description(9, ccb.content.text("You're a very knowledgeable tailor."), ccb.content.text("You can sew anything you could dream of."))
definition:companion_rank_factors(0, 0, 1)
content.add(definition)
end
do
local definition = content.Skill {
    id = "survival",
    name = ccb.content.text("survival"),
    description = ccb.content.text("Your skill in surviving the wilderness, and in crafting various basic survival items.  This also covers your ability to skin and butcher animals for meat and hides."),
    display_category = "display_crafting",
    sort_rank = 15000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("", 80)
definition:companion_practice("gathering", 80)
definition:companion_practice("trapping", 15)
definition:companion_practice("hunting", 15)
definition:companion_practice("menial", 10)
definition:companion_practice("construction", 10)
definition:companion_practice("recruiting", 25)
definition:companion_practice("combat", 10)
definition:level_description(0, ccb.content.text("You're aware the outdoors is gross."), ccb.content.text("You need to touch grass."))
definition:level_description(1, ccb.content.text("You know the very basics of camping."), ccb.content.text("You've touched grass."))
definition:level_description(2, ccb.content.text("You know how to craft a fire drill to start fires without lighters."))
definition:level_description_practice(3, ccb.content.text("You might've been a cub scout as a kid."))
definition:level_description(5, ccb.content.text("You probably memorized most of the Scouting handbook."), ccb.content.text("You're a skilled scout and can pitch a tent with ease."))
definition:level_description(9, ccb.content.text("You're exceptionally knowledgeable in all things outdoorsy."), ccb.content.text("You could likely be dropped into a forest with nothing and thrive."))
definition:companion_rank_factors(0, 1, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "electronics",
    name = ccb.content.text("electronics"),
    description = ccb.content.text("Your skill in dealing with electrical systems, used in the craft and repair of objects with electrical components.  This skill is an important part of installing and managing bionic implants."),
    display_category = "display_crafting",
    sort_rank = 18000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:level_description(0, ccb.content.text("You don't know the first thing about how electricity works.  It might as well be magic to you."), ccb.content.text("You can turn a light switch on or off."))
definition:level_description(1, ccb.content.text("You have a very rudimentary knowledge on how electricity works."), ccb.content.text("You can craft extremely basic electronics like flashlights."))
definition:level_description(3, ccb.content.text("You have some idea of how electricity works."), ccb.content.text("You can craft some electrical gadgets and set up an at-home power grid without major fire hazards."))
definition:level_description(5, ccb.content.text("You have a good understanding of how electricity works and were possibly an electrician."), ccb.content.text("You can craft a variety of useful electronics."))
definition:level_description(9, ccb.content.text("You have an intricate understanding of electronics and how they function."), ccb.content.text("You can craft any electrical device you can think of."))
definition:companion_rank_factors(0, 0, 1)
content.add(definition)
end
do
local definition = content.Skill {
    id = "archery",
    name = ccb.content.text("archery"),
    description = ccb.content.text("Your skill in using bow weapons, from hand-carved self bows to complex compound bows.  Quiet and effective, they require strength of body and sight to wield, and are not terribly accurate over a long distance."),
    display_category = "display_ranged",
    sort_rank = 9000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("", 5)
definition:companion_practice("gathering", 5)
definition:companion_practice("trapping", 5)
definition:companion_practice("hunting", 45)
definition:companion_practice("combat", 15)
definition:level_description(0, ccb.content.text("You know what a bow looks like."), ccb.content.text("You're lucky if the arrow doesn't spin sideways."))
definition:level_description(1, ccb.content.text("You know how to nock an arrow."), ccb.content.text("You can usually get the arrow to fly straight-ish."))
definition:level_description(3, ccb.content.text("You know the basics of archery."), ccb.content.text("You can usually hit an archery target."))
definition:level_description(5, ccb.content.text("You're knowledgeable about archery."), ccb.content.text("You're a fairly skilled archer."))
definition:level_description_practice(7, ccb.content.text("You're a skilled archer and might've done well in some competitions."))
definition:level_description(9, ccb.content.text("You have a wealth of knowledge about archery."), ccb.content.text("You'd've been a terror at the Battle of Agincourt."))
definition:attack_time(20, 50, 3)
definition:companion_rank_factors(1, 1, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "gun",
    name = ccb.content.text("marksmanship"),
    description = ccb.content.text("Your overall skill in using bows and firearms.  With higher levels, this general experience increases accuracy with any bows or firearms, but is secondary to practice with the type of ranged weapon in question."),
    display_category = "display_ranged",
    sort_rank = 7000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("gathering", 60)
definition:companion_practice("combat", 5)
definition:level_description(0, ccb.content.text("You don't even know how to aim a gun."), ccb.content.text("Your hands shake, your aim is shit, and you close your eyes before each shot.  You could aim at the ground and somehow miss."))
definition:level_description(1, ccb.content.text("You know where the iron sights on a gun are."), ccb.content.text("Holding a gun steady is difficult for you."))
definition:level_description(3, ccb.content.text("You know the basics of aiming."), ccb.content.text("You've been to the range a few times and can usually hit the target."))
definition:level_description(5, ccb.content.text("You know how to aim most ranged weapons fairly well."), ccb.content.text("Your aim is pretty good even at medium ranges."))
definition:level_description_practice(7, ccb.content.text("You have good aim even at fairly long ranges."))
definition:level_description(9, ccb.content.text("You know how to aim even at long distances taking into account bullet drop and wind speed."), ccb.content.text("You're a veritable sniper."))
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "launcher",
    name = ccb.content.text("launchers"),
    description = ccb.content.text("Your skill in using heavy weapons like rocket, grenade or missile launchers.  These weapons have a variety of applications and may carry immense destructive power, but they are cumbersome and hard to manage."),
    display_category = "display_ranged",
    sort_rank = 14000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:level_description(0, ccb.content.text("You know nothing about launchers, cannons, or anything similar."), ccb.content.text("Rather understandably, you have never fired any kind of launcher before."))
definition:level_description(1, ccb.content.text("You've at least read about cannons or flamethrowers."), ccb.content.text("You may have fired a spud cannon at some point."))
definition:level_description(3, ccb.content.text("You probably built a spud launcher at some point."), ccb.content.text("You have experience firing launchers or flamethrowers, somehow."))
definition:level_description(5, ccb.content.text("You're skilled with various types of launchers."), ccb.content.text("Your growing level of experience with rocket launchers, flamethrowers, or cannons is worrying."))
definition:level_description(9, ccb.content.text("You're a rare expert in knowledge about various types of launchers."), ccb.content.text("You just want to watch the world burn, and you're really damn good at making sure it will."))
definition:attack_time(30, 100, 5)
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "pistol",
    name = ccb.content.text("handguns"),
    description = ccb.content.text("Handguns have poor accuracy compared to rifles, but are usually quick to fire and reload faster than other guns.  They are very effective at close quarters, though unsuited for long range engagement."),
    display_category = "display_ranged",
    sort_rank = 10000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("hunting", 25)
definition:level_description(0, ccb.content.text("You can't tell a revolver from a semiautomatic."), ccb.content.text("Hopefully it won't fly out of your hands when you fire one."))
definition:level_description(1, ccb.content.text("You can tell a revolver from a semiautomatic."), ccb.content.text("Handguns feel awkward to use for you."))
definition:level_description(3, ccb.content.text("You know the basics of handguns and their usage."), ccb.content.text("You're comfortable with the usage of handguns."))
definition:level_description(5, ccb.content.text("You're knowledgeable about handguns and their uses."), ccb.content.text("You're quite skilled and accurate with handguns."))
definition:level_description_practice(7, ccb.content.text("You could win a duel at high noon."))
definition:level_description(9, ccb.content.text("You know every trick and technique for firing handguns accurately and effectively."), ccb.content.text("You're a deadeye with pistols and can likely hit someone at 20 yards from the hip with ease."))
definition:attack_time(20, 30, 1)
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "rifle",
    name = ccb.content.text("rifles"),
    description = ccb.content.text("Classic rifles have terrific range and accuracy compared to other firearms, but may be slow to fire and reload, and can prove difficult to use in close combat.  Short-barreled rifles and carbines are more like SMGs and perform well in close combat."),
    display_category = "display_ranged",
    sort_rank = 12000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("hunting", 45)
definition:level_description(0, ccb.content.text("Rifles are complicated weaponry and you don't know anything about them."), ccb.content.text("You've never fired a rifle before."))
definition:level_description(1, ccb.content.text("You at least have rudimentary knowledge of rifles."), ccb.content.text("You can at least shoulder a rifle."))
definition:level_description(3, ccb.content.text("You can maintain your average standard-issue rifle."), ccb.content.text("You're at least as competent as the average soldier straight out of boot camp."))
definition:level_description(5, ccb.content.text("You have an intricate knowledge of all the parts of a rifle and their use."), ccb.content.text("Rifles feel familiar in your hands."))
definition:level_description_practice(7, ccb.content.text("You're a genuinely good shot."))
definition:level_description(9, ccb.content.text("You can probably disassemble and reassemble your rifle in the dark with your hands tied together."), ccb.content.text("You could be a career sniper."))
definition:attack_time(20, 30, 1)
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "shotgun",
    name = ccb.content.text("shotguns"),
    description = ccb.content.text("Shotguns are easy to shoot and can inflict massive damage, but their effectiveness and accuracy decline rapidly with range.  Slugs can be loaded into shotguns to provide greater range, though they are somewhat inaccurate."),
    display_category = "display_ranged",
    sort_rank = 13000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("hunting", 25)
definition:level_description(0, ccb.content.text("\"Shot-guns?\"  But all guns are shot?"), ccb.content.text("You couldn't hit the broad side of a barn."))
definition:level_description(1, ccb.content.text("You know what a shotgun is."), ccb.content.text("You can usually hit a clay pigeon if it's just sitting there."))
definition:level_description(3, ccb.content.text("You know enough about shotguns to get mad about unrealistic pellet spread in video games."), ccb.content.text("You probably have experience skeet shooting."))
definition:level_description(5, ccb.content.text("You're knowledgeable about the handling and maintenance of shotguns."), ccb.content.text("You're a very skilled skeet shooter."))
definition:level_description_practice(9, ccb.content.text("You could snipe with most shotguns if you weren't limited by the spread."))
definition:attack_time(20, 30, 1)
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "smg",
    name = ccb.content.text("submachine guns"),
    description = ccb.content.text("Comprised of an automatic rifle carbine designed to fire a pistol cartridge, submachine guns can reload and fire quickly, sometimes in bursts, but they are relatively inaccurate and may be prone to mechanical failures."),
    display_category = "display_ranged",
    sort_rank = 11000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("hunting", 25)
definition:level_description(0, ccb.content.text("You don't know the first thing about submachine guns."), ccb.content.text("You've never held an SMG before."))
definition:level_description(1, ccb.content.text("You know very little about SMGs."), ccb.content.text("You have minimal experience with SMGs."))
definition:level_description(3, ccb.content.text("You know a decent bit about firing SMGs accurately."), ccb.content.text("You have some experience with SMGs."))
definition:level_description(5, ccb.content.text("You're knowledgeable about the tactics used with SMGs."), ccb.content.text("You're fairly experienced with SMGs."))
definition:level_description_practice(7, ccb.content.text("You're very experienced with SMGs."))
definition:level_description_practice(9, ccb.content.text("You're a CQB expert with SMGs."))
definition:attack_time(20, 30, 1)
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "throw",
    name = ccb.content.text("throwing"),
    description = ccb.content.text("Your skill in throwing objects over a distance.  Skill increases accuracy, and at higher levels, the range of a throw."),
    display_category = "display_ranged",
    sort_rank = 8000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:level_description(0, ccb.content.text("You've managed to avoid gym class your whole life and barely know how to throw a rock.  Impressive."), ccb.content.text("You're lucky if you don't drop the thing you're throwing at your feet.  Be extra careful with grenades."))
definition:level_description(1, ccb.content.text("You know how to throw things.  Which is good, since that's an inherent skill of being human."), ccb.content.text("You can usually throw a rock at a person if they're not too far away, or moving."))
definition:level_description(3, ccb.content.text("You know how to throw stuff with reasonable accuracy."), ccb.content.text("You can accurately throw a dodgeball at someone."))
definition:level_description(5, ccb.content.text("You know proper form and methods for throwing accurately."), ccb.content.text("You can pitch a baseball across home plate into the strike zone reliably."))
definition:level_description_practice(7, ccb.content.text("You've got a good fastball."))
definition:level_description(9, ccb.content.text("You could teach sports.  The ones that involve throwing stuff anyway."), ccb.content.text("You could've become a professional pitcher.  At least beaning zombies doesn't give them a free walk to first base."))
definition:attack_time(50, 220, 25)
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "melee",
    name = ccb.content.text("melee"),
    description = ccb.content.text("Your skill and finesse in personal combat, both with and without a weapon.  Higher levels can significantly increase the accuracy and effectiveness of your physical attacks."),
    display_category = "display_melee",
    sort_rank = 1000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("", 5)
definition:companion_practice("gathering", 5)
definition:companion_practice("trapping", 5)
definition:companion_practice("hunting", 10)
definition:companion_practice("recruiting", 5)
definition:companion_practice("combat", 20)
definition:level_description(0, ccb.content.text("You have no idea how to do anything other than vaguely swing in their direction."), ccb.content.text("Any fighting you do is mostly just panicked flailing."))
definition:level_description(1, ccb.content.text("You can theoretically fight."), ccb.content.text("Your panicked flailing has become somewhat more determined flailing."))
definition:level_description(3, ccb.content.text("You've learned enough to avoid overswinging and falling off balance if you miss."), ccb.content.text("Your fighting now actually resembles proper form and is far less clumsy."))
definition:level_description(5, ccb.content.text("Whether self-taught or trained, you've learned quite a lot about fighting."), ccb.content.text("You're a proper fighter and can use most techniques."))
definition:level_description_practice(7, ccb.content.text("You're a skilled man-at-arms that wouldn't look out of place fighting on a medieval battlefield."))
definition:level_description(9, ccb.content.text("You could teach a platoon of medieval soldiers how to fight in a war."), ccb.content.text("In a world with guns you've dedicated yourself to mastering melee combat, and you're damn good at it too."))
definition:attack_time(50, 200, 20)
definition:companion_rank_factors(1, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "bashing",
    name = ccb.content.text("bashing weapons"),
    description = ccb.content.text("Your skill in fighting with blunt weaponry, from rocks and sticks to baseball bats and the butts of rifles.  Skill increases damage, and higher levels will improve the accuracy of an attack."),
    display_category = "display_melee",
    sort_rank = 3000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("hunting", 10)
definition:companion_practice("combat", 10)
definition:level_description(0, ccb.content.text("You don't even know how to swing a baseball bat properly."), ccb.content.text("You've somehow gone through life without even swinging a stick for fun.  How awful."))
definition:level_description(1, ccb.content.text("You at least know how to swing a baseball bat."), ccb.content.text("You can swing a baseball bat."))
definition:level_description(3, ccb.content.text("You have a decent idea how to maneuver blunt weapons without falling off balance."), ccb.content.text("You can reliably hit a pitch while at bat."))
definition:level_description(5, ccb.content.text("You've learned how to leverage blunt weapons best to get powerful, accurate hits."), ccb.content.text("You're a decently skilled batter and good at using all sorts of bludgeons, improvised or otherwise."))
definition:level_description_practice(7, ccb.content.text("You can hit zombies over the head even with random junk and still make it look good."))
definition:level_description(9, ccb.content.text("You could teach a class on fighting with maces and hammers."), ccb.content.text("You can swing a heavy, poorly-weighted sledgehammer with pinpoint accuracy even against a moving target."))
definition:companion_rank_factors(1, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "cutting",
    name = ccb.content.text("cutting weapons"),
    description = ccb.content.text("Your skill in fighting with weaponry designed to cut, hack and slash an opponent.  Lower levels of skill increase accuracy and damage, while higher levels will help to bypass heavy armor and thick hides."),
    display_category = "display_melee",
    sort_rank = 4000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("hunting", 10)
definition:companion_practice("combat", 10)
definition:level_description(0, ccb.content.text("You don't even know how to play-swordfight."), ccb.content.text("You'd probably hit with the flat of the blade more than the edge."))
definition:level_description(1, ccb.content.text("You at least know which part of the sword you're supposed to hold."), ccb.content.text("You can usually get a decent cut when chopping."))
definition:level_description(3, ccb.content.text("You've learned how to cut properly with draw cuts and similar techniques."), ccb.content.text("You can reliably keep good edge alignment when slicing."))
definition:level_description(5, ccb.content.text("You've learned how to fight with swords effectively."), ccb.content.text("You're a fairly skilled swordsman."))
definition:level_description(9, ccb.content.text("You've studied the blade."), ccb.content.text("With your skill, in another life you could duel a samurai."))
definition:companion_rank_factors(1, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "dodge",
    name = ccb.content.text("dodging"),
    description = ccb.content.text("Your ability to dodge an oncoming threat, be it an enemy's attack, a triggered trap, or a falling rock.  This skill is also used in attempts to fall gracefully, and for other acrobatic feats.  The first number shown includes modifiers, and the second does not."),
    display_category = "display_melee",
    sort_rank = 6000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("hunting", 15)
definition:companion_practice("combat", 20)
definition:level_description(0, ccb.content.text("For most people, jumping out of the way of danger is instinct, and you barely have that."), ccb.content.text("Your reflexes are dull and you have two left feet.  Hope you don't trip."))
definition:level_description(1, ccb.content.text("You might know how to dodge."), ccb.content.text("You can at least dodge without tripping over your own feet."))
definition:level_description(3, ccb.content.text("You've learned how to minimize your movement with dodging to avoid overexerting yourself."), ccb.content.text("You have decent reflexes and can dodge a dodgeball."))
definition:level_description(5, ccb.content.text("You have a good grasp on various dodging techniques and ways to avoid being grabbed."), ccb.content.text("You're fairly squirrely, most enemies will have some difficulty hitting you."))
definition:level_description(9, ccb.content.text("You know how to do a dodge, duck, dip, dive, and how to win every game of dodgeball."), ccb.content.text("You have exceptional reflexes and are very slippery and hard to pin down."))
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "stabbing",
    name = ccb.content.text("piercing weapons"),
    description = ccb.content.text("Your skill in fighting with knives, spears and other such stabbing implements.  Skill increases attack accuracy as well as the chance of inflicting a deadly and critical blow."),
    display_category = "display_melee",
    sort_rank = 5000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("hunting", 10)
definition:companion_practice("combat", 10)
definition:level_description(0, ccb.content.text("You might not even be aware you're supposed to stab with a spear."), ccb.content.text("You have a hard time spearing steak with a fork."))
definition:level_description(1, ccb.content.text("You understand the gist of thrusting weapons."), ccb.content.text("Stabbing is an awkward motion for you."))
definition:level_description(3, ccb.content.text("You know some of the techniques involved with thrusting weapons."), ccb.content.text("You're a decent fencer or spearman."))
definition:level_description(5, ccb.content.text("You're well-learned in fencing or spearmanship."), ccb.content.text("You're a skilled fencer or spearman."))
definition:level_description(9, ccb.content.text("You could open a fencing school or start your own spear lessons."), ccb.content.text("You're a commando with a knife, a fencing expert, and an accomplished spearman."))
definition:companion_rank_factors(1, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "unarmed",
    name = ccb.content.text("unarmed combat"),
    description = ccb.content.text("Your skill in hand-to-hand fighting.  For the unskilled, it's a good way to get hurt, but those with enough practice can perform special blows and techniques to quickly dispatch enemies."),
    display_category = "display_melee",
    sort_rank = 2000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("combat_skill")
definition:companion_practice("hunting", 10)
definition:companion_practice("combat", 10)
definition:level_description(0, ccb.content.text("You've never had any interest in learning to fight."), ccb.content.text("Punching someone is more likely to hurt you than them."))
definition:level_description(1, ccb.content.text("You can theoretically throw a punch."), ccb.content.text("You can throw a punch.  Not well, but you can throw one."))
definition:level_description(3, ccb.content.text("You know how to throw down."), ccb.content.text("You're enough of a scrapper to fight with your fists if you have to."))
definition:level_description(5, ccb.content.text("You really know how to throw down."), ccb.content.text("You could win most bar fights."))
definition:level_description_practice(7, ccb.content.text("You'd have your black belt if any dojos were still open."))
definition:level_description(9, ccb.content.text("You could probably teach your own martial art."), ccb.content.text("You could have multiple black belts or box in the major leagues."))
definition:companion_rank_factors(1, 1, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "chemistry",
    name = ccb.content.text("applied science"),
    description = ccb.content.text("Your skill in general 'bench science', applying any of a wide range of precision techniques based on your overall understanding of scientific principles.  This is not a research skill, but about using the results of others' research."),
    display_category = "display_crafting",
    sort_rank = 19000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:companion_practice("menial", 15)
definition:level_description(0, ccb.content.text("You're not even theoretically a physicist."), ccb.content.text("You skipped all your science classes."))
definition:level_description(1, ccb.content.text("You have the basic understanding of science on par with a high schooler."), ccb.content.text("You've at least done high school chemistry classes."))
definition:level_description(3, ccb.content.text("You have a decent understanding of science on par with a college graduate."), ccb.content.text("You've worked with a few chemicals and can follow simple procedures."))
definition:level_description(5, ccb.content.text("You have a deep understanding of the scientific method and possibly have a degree in a scientific field."), ccb.content.text("You can follow some more complicated procedures and likely took advanced chemistry courses."))
definition:level_description_practice(7, ccb.content.text("You can do some advanced chemistry, or just make drugs."))
definition:level_description(9, ccb.content.text("You likely have a PhD in a scientific field."))
definition:companion_rank_factors(0, 0, 1)
content.add(definition)
end
do
local definition = content.Skill {
    id = "weapon",
    name = ccb.content.text("weapon"),
    description = ccb.content.text("seeing this is a bug"),
    display_category = "none",
    sort_rank = 500000,
    teachable = true,
    obsolete = false,
    consumes_focus = true,
}
definition:tag("contextual_skill")
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
do
local definition = content.Skill {
    id = "riding",
    name = ccb.content.text("riding"),
    description = ccb.content.text("Legacy riding skill retained for old saves.  Riding now uses athletics."),
    display_category = "display_interaction",
    sort_rank = 27500,
    teachable = true,
    obsolete = true,
    consumes_focus = true,
}
definition:level_description(0, ccb.content.text("You know that riders usually sit on top of the animal."), ccb.content.text("You are likely to fumble a mount or lose your balance."))
definition:level_description(1, ccb.content.text("You understand basic mounting and rein control."), ccb.content.text("You can ride a calm, properly equipped animal."))
definition:level_description(3, ccb.content.text("You understand balance, gait changes, and safe mounted movement."), ccb.content.text("You remain composed through ordinary turns and changes of pace."))
definition:level_description(5, ccb.content.text("You understand demanding maneuvers and mounted combat principles."), ccb.content.text("You can control a mount reliably during combat."))
definition:level_description(8, ccb.content.text("You understand advanced riding as well as a professional trainer."), ccb.content.text("You and your mount move as a practiced team."))
definition:companion_rank_factors(0, 0, 0)
content.add(definition)
end
