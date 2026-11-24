local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "goblin_fruit_abstract",
    name = ccb.content.text_without_extraction("Abstract Goblin Fruit"),
    description = ccb.content.text_without_extraction("Somehow you got a hold of the platonic goblin fruit, the one fruit to rule them all.  It's a bug if you have this, but the lords of the Bright Lands will surely pay a high price for it."),
    mass = "182 g",
    volume = "232 ml",
    color = "magenta",
    symbol = "%",
    price = "40 cent",
    survival_price = "1 USD",
    materials = { "fruit" },
    flags = { "FREEZERBURN", "NO_AUTO_CONSUME" },
    comestible = {
        shelf_life = "3 days",
        kind = "FOOD",
        quench = 3,
        calories = 75,
        fun = 1,
        vitamins = {
            { id = "vitC", amount = 10 },
            { id = "calcium", amount = 10 },
            { id = "iron", amount = 10 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "goblin_fruit_gacha",
    name = ccb.content.plural_text("mysterious fruit", "mysterious fruits"),
    description = ccb.content.text("Some sort of fruit sealed in a thick shell.  The shell is rigid but seems surprisingly brittle; you could easily peel it open to see what's inside with your bare hands."),
    mass = "364 g",
    volume = "464 ml",
    color = "magenta",
    symbol = "%",
    price = "40 cent",
    survival_price = "1 USD",
    materials = { "fruit" },
    flags = { "NO_AUTO_CONSUME", "SINGLE_USE" },
    comestible = {
        shelf_life = "60 days",
        kind = "FOOD",
        vitamins = { { id = "fruit_allergen", amount = 1 } },
        on_consume = "eat_mysterious_goblin_fruit",
    },
}

ccb.content.define_item {
    id = "goblin_fruit_healing",
    name = ccb.content.plural_text("sweet goblin fruit", "sweet goblin fruits"),
    description = ccb.content.text("This round goblin fruit is reddish-orange with a waxy texture.  It smells sweet with a hint of petrichor."),
    copy_from = "goblin_fruit_abstract",
    color = "red_yellow",
    mass = "210 g",
    volume = "273 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_healing" },
}

ccb.content.define_item {
    id = "goblin_fruit_illness",
    name = ccb.content.plural_text("iridescent goblin fruit", "iridescent goblin fruits"),
    description = ccb.content.text("This oblong goblin fruit shimmers slightly in a rainbow of colors.  It smells like a mix of peach and freshly-baked bread."),
    copy_from = "goblin_fruit_abstract",
    color = "white",
    mass = "155 g",
    volume = "174 ml",
    comestible = { kind = "FOOD", fun = 3, on_consume = "consume_goblin_fruit_illness" },
}

ccb.content.define_item {
    id = "goblin_fruit_attack_speed",
    name = ccb.content.plural_text("silvery goblin fruit", "silvery goblin fruits"),
    description = ccb.content.text("This round goblin fruit looks like a metal sculpture but has the yielding texture of a peach.  It smells like the tang in the air before a storm."),
    copy_from = "goblin_fruit_abstract",
    color = "light_gray",
    mass = "218 g",
    volume = "278 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_attack_speed" },
}

ccb.content.define_item {
    id = "goblin_fruit_thorns",
    name = ccb.content.plural_text("spicy goblin fruit", "spicy goblin fruits"),
    description = ccb.content.text("This long, thin goblin fruit is a subdued green color but has a smell that burns your nostrils."),
    copy_from = "goblin_fruit_abstract",
    color = "light_green",
    mass = "173 g",
    volume = "209 ml",
    comestible = { kind = "FOOD", fun = -2, on_consume = "consume_goblin_fruit_thorns" },
}

ccb.content.define_item {
    id = "goblin_fruit_pain",
    name = ccb.content.plural_text("savory goblin fruit", "savory goblin fruits"),
    description = ccb.content.text("This round goblin fruit is a bluish color changing to red at the ends.  It smells like a freshly-roasted hunk of meat."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "227 g",
    volume = "290 ml",
    comestible = { kind = "FOOD", fun = 2, on_consume = "consume_goblin_fruit_pain" },
}

ccb.content.define_item {
    id = "goblin_fruit_warmth",
    name = ccb.content.plural_text("rinded goblin fruit", "rinded goblin fruits"),
    description = ccb.content.text("This round goblin fruit has a thick red rind with a leaf still attached to the stem.  The leaf seems to move occasionally even when there is no wind."),
    copy_from = "goblin_fruit_abstract",
    color = "red",
    mass = "136 g",
    volume = "174 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_warmth" },
}

ccb.content.define_item {
    id = "goblin_fruit_awake",
    name = ccb.content.plural_text("minty goblin fruit", "minty goblin fruits"),
    description = ccb.content.text("This dark purple goblin fruit has an overpowering minty smell.  The smell even escapes sealed containers."),
    copy_from = "goblin_fruit_abstract",
    color = "magenta",
    mass = "150 g",
    volume = "191 ml",
    comestible = { kind = "FOOD", fun = 0, on_consume = "consume_goblin_fruit_awake" },
}

ccb.content.define_item {
    id = "goblin_fruit_water",
    name = ccb.content.text("cubic goblin fruit"),
    description = ccb.content.text("This pale blue goblin fruit is a cube, and the edges are fine enough to leave a line in your thumb when you press on them.  It smells incredibly sour."),
    copy_from = "goblin_fruit_abstract",
    color = "light_blue",
    mass = "182 g",
    volume = "232 ml",
    comestible = { kind = "FOOD", quench = 200, fun = -2 },
}

ccb.content.define_item {
    id = "goblin_fruit_purge_blood",
    name = ccb.content.plural_text("smoky goblin fruit", "smoky goblin fruits"),
    description = ccb.content.text("This sharply-curved goblin fruit is an off-white color turning red toward the ends.  It smells like the alley outside a club."),
    copy_from = "goblin_fruit_abstract",
    color = "light_red",
    mass = "182 g",
    volume = "232 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_purge_blood" },
}

ccb.content.define_item {
    id = "goblin_fruit_dodge",
    name = ccb.content.plural_text("inky goblin fruit", "inky goblin fruits"),
    description = ccb.content.text("This large goblin fruit is such a deep black color you can't actually tell exactly what shape it is.  It's roundish, but when you hold it, it seems more like you're holding a hole in the fabric of the world.  It smells like an apple."),
    copy_from = "goblin_fruit_abstract",
    color = "black",
    mass = "273 g",
    volume = "348 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_dodge" },
}

ccb.content.define_item {
    id = "goblin_fruit_night_vision",
    name = ccb.content.plural_text("toroid goblin fruit", "toroid goblin fruits"),
    description = ccb.content.text("This yellow-green goblin fruit is shaped like a donut, with six reddish stems spaced equidistantly around its circumference.  You can't imagine what the plant that grew this one looks like."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow",
    mass = "118 g",
    volume = "151 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_night_vision" },
}

-- Dolm is a fictional color from the 1920 book "A Voyage to Arcturus" that's a mix of infrared and blue.
ccb.content.define_item {
    id = "goblin_fruit_no_bleed",
    name = ccb.content.plural_text("dolm goblin fruit", "dolm goblin fruits"),
    description = ccb.content.text("This teardrop-shaped goblin fruit hurts to look at.  Sometimes it's a dark blue, sometimes it's a feverish red, and sometimes it's a mix of the two that you would previously have sworn could not exist.  It smells faintly peppery with a hint of lemon."),
    copy_from = "goblin_fruit_abstract",
    color = "blue_red",
    mass = "191 g",
    volume = "244 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_no_bleed" },
}

ccb.content.define_item {
    id = "goblin_fruit_perception",
    name = ccb.content.plural_text("spikey goblin fruit", "spikey goblin fruits"),
    description = ccb.content.text("This dark-colored goblin fruit is covered in spikes like a pineapple.  Unlike a pineapple, the spikes are yielding and seem part of the fruit, not a rind.  It smells of freshly-cut grass."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray",
    mass = "182 g",
    volume = "232 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_perception" },
}

ccb.content.define_item {
    id = "goblin_fruit_no_drunk",
    name = ccb.content.plural_text("sanguine goblin fruit", "sanguine goblin fruits"),
    description = ccb.content.text("A dark red goblin fruit with a heavy iron smell.  It feels warm to the touch."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray_red",
    mass = "146 g",
    volume = "186 ml",
    comestible = { kind = "FOOD", fun = -3, on_consume = "consume_goblin_fruit_no_drunk" },
}

ccb.content.define_item {
    id = "goblin_fruit_no_rotten_food",
    name = ccb.content.plural_text("translucent goblin fruit", "translucent goblin fruits"),
    description = ccb.content.text("This goblin fruit looks like a globe of water with seeds and a stem suspended within it.  Despite that, it feels like kiwi, with a slight fuzz and no moisture left on your fingers when you touch it.  It smells like roses."),
    copy_from = "goblin_fruit_abstract",
    color = "white",
    mass = "209 g",
    volume = "267 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_no_rotten_food" },
}

ccb.content.define_item {
    id = "goblin_fruit_feather_fall",
    name = ccb.content.plural_text("inconspicuous goblin fruit", "inconspicuous goblin fruits"),
    description = ccb.content.text("This goblin fruit looks like a pear and feels like a pear and smells exactly like a pear.  You have no idea how it tastes because the instant you put your tongue to it, your entire mouth goes numb."),
    copy_from = "goblin_fruit_abstract",
    color = "green_yellow",
    mass = "146 g",
    volume = "187 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_feather_fall" },
}

ccb.content.define_item {
    id = "goblin_fruit_super_clairvoyance",
    name = ccb.content.plural_text("crumbly goblin fruit", "crumbly goblin fruits"),
    description = ccb.content.text("This large, curved goblin fruit is a dark blue color and feels like it's already on the verge of rotting.  It takes very little pressure for your fingers to bruise the skin and the flesh inside flakes off when you touch it.  It smells like sun-ripened strawberries."),
    copy_from = "goblin_fruit_abstract",
    color = "h_black",
    mass = "263 g",
    volume = "300 ml",
    comestible = { kind = "FOOD", fun = -3, on_consume = "consume_goblin_fruit_super_clairvoyance" },
}

ccb.content.define_item {
    id = "goblin_fruit_water_breathing",
    name = ccb.content.plural_text("star-shaped goblin fruit", "star-shaped goblin fruits"),
    description = ccb.content.text("This greenish-white goblin fruit is shaped like a star in a much more literal way than a starfruit.  It's almost like if a starfish was an apple.  It smells like freshly-laundered clothing."),
    copy_from = "goblin_fruit_abstract",
    color = "green_white",
    mass = "210 g",
    volume = "240 ml",
    comestible = { kind = "FOOD", fun = -3, on_consume = "consume_goblin_fruit_water_breathing" },
}

ccb.content.define_item {
    id = "shadow_fruit",
    name = ccb.content.plural_text("shadowy goblin fruit", "shadowy goblin fruits"),
    description = ccb.content.text("This greyish goblin fruit is shaped like a pear, if pears had scales like a pinecone.  There is a pulpy meat underneath the scales."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray",
    mass = "118 g",
    volume = "151 ml",
    comestible = { kind = "FOOD", on_consume = "consume_shadow_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_giant_growth",
    name = ccb.content.plural_text("shiny goblin fruit", "shiny goblin fruits"),
    description = ccb.content.text("This round blue goblin fruit glows bright enough to read by.  The light flickers like firelight, even when the fruit is simply placed on the table.  It smells like pine needles soaked in strong alcohol."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow_cyan",
    mass = "199 g",
    volume = "228 ml",
    light = 10,
    flags = { "FREEZERBURN", "NO_AUTO_CONSUME" },
    comestible = { kind = "FOOD", on_consume = "eat_giant_growth_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_mana_restore",
    name = ccb.content.plural_text("fizzy goblin fruit", "fizzy goblin fruits"),
    description = ccb.content.text("This small brown goblin fruit constantly forms bubbles that erupt from its skin.  Despite that, its surface remains smooth at all times.  It has a subtle, sugary smell."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "134 g",
    volume = "122 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_mana_restore" },
}

ccb.content.define_item {
    id = "goblin_fruit_stealth",
    name = ccb.content.plural_text("unnoticeable goblin fruit", "unnoticeable goblin fruits"),
    description = ccb.content.text("This goblin fruit is hard to perceive.  You think it's black, you believe it's small and you're certain it's near you, but all its other details slip from your memory the instant you stop looking at this fruit."),
    copy_from = "goblin_fruit_abstract",
    color = "black",
    mass = "61 g",
    volume = "56 ml",
    comestible = { kind = "FOOD", fun = 0, on_consume = "consume_goblin_fruit_stealth" },
}

ccb.content.define_item {
    id = "goblin_fruit_food",
    name = ccb.content.text("heavy goblin fruit"),
    description = ccb.content.text("This green goblin fruit is much heavier than it should be.  Its scent is heavy, pressing down your nose and throat as you smell it."),
    copy_from = "goblin_fruit_abstract",
    color = "light_green",
    mass = "2816 g",
    volume = "256 ml",
    materials = { "fruit_heavy" },
    comestible = {
        kind = "FOOD",
        calories = 1050,
        vitamins = {
            { id = "vitC", amount = 100 },
            { id = "calcium", amount = 100 },
            { id = "iron", amount = 100 },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}

ccb.content.define_item {
    id = "goblin_fruit_soothing",
    name = ccb.content.plural_text("soothing goblin fruit", "soothing goblin fruits"),
    description = ccb.content.text("This sky blue fruit slows the thoughts racing in your mind a little as you stare at it, making you feel sightly more calm until you put it away."),
    copy_from = "goblin_fruit_abstract",
    color = "light_blue",
    mass = "202 g",
    volume = "184 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_soothing" },
}

ccb.content.define_item {
    id = "goblin_fruit_music",
    name = ccb.content.plural_text("melodious goblin fruit", "melodious goblin fruits"),
    description = ccb.content.text("This sinewy, beak-shaped fruit produces a faint melody.  This melody grows a little louder when you bring the fruit next to your mouth."),
    copy_from = "goblin_fruit_abstract",
    color = "magenta",
    mass = "260 g",
    volume = "237 ml",
    comestible = { kind = "FOOD", on_consume = "eat_musical_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_combat_skill_boost",
    name = ccb.content.plural_text("mirror goblin fruit", "mirror goblin fruits"),
    description = ccb.content.text("You can see your reflection in the mirror-like surface of this fruit.  This reflection of you seems angrier, closer to a feral human than to your own image."),
    copy_from = "goblin_fruit_abstract",
    color = "white",
    mass = "331 g",
    volume = "351 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_combat_skill_boost" },
}

ccb.content.define_item {
    id = "goblin_fruit_craft_skill_boost",
    name = ccb.content.plural_text("camouflaged goblin fruit", "camouflaged goblin fruits"),
    description = ccb.content.text("The many colors of this oblong fruit shift to mimic what's behind it, trying to imitate other things with the best of its ability."),
    copy_from = "goblin_fruit_abstract",
    color = "red",
    mass = "244 g",
    volume = "262 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_craft_skill_boost" },
}

ccb.content.define_item {
    id = "goblin_fruit_immovable",
    name = ccb.content.plural_text("bitter goblin fruit", "bitter goblin fruits"),
    description = ccb.content.text("This fruit wrapped in barbed vines fills you with bitterness as you hold it.  It slightly resists inertia as you move it, as if it moved through molasses."),
    copy_from = "goblin_fruit_abstract",
    color = "light_gray",
    mass = "202 g",
    volume = "284 ml",
    comestible = { kind = "FOOD", fun = -10, on_consume = "consume_goblin_fruit_immovable" },
}

-- When possible, this fruit should take longer to eat, as it literally opposes your attempts to eat it.
ccb.content.define_item {
    id = "goblin_fruit_dodge_instant",
    name = ccb.content.plural_text("evasive goblin fruit", "evasive goblin fruits"),
    description = ccb.content.text("This yellow half-liquid fruit is hard to hold, as it actively tries to escape your grasp.  You hope it won't try to escape your innards after you eat it."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow_cyan",
    mass = "169 g",
    volume = "174 ml",
    comestible = { kind = "FOOD", fun = -1, on_consume = "consume_goblin_fruit_dodge_instant" },
}

ccb.content.define_item {
    id = "goblin_fruit_blood_gain",
    name = ccb.content.plural_text("vein-filled goblin fruit", "vein-filled goblin fruits"),
    description = ccb.content.text("This translucent fruit is filled with a network of tubes not unlike veins and arteries.  Judging by the way its brown surface turns blue when bruised, it probably contains a fluid similar to blood."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "279 g",
    volume = "294 ml",
    comestible = { kind = "FOOD", on_consume = "eat_blood_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_blind_flash",
    name = ccb.content.plural_text("dazzling goblin fruit", "dazzling goblin fruits"),
    description = ccb.content.text("This fruit shines a light bright enough to be painful to look at.  From the little you can see, it appears to be a purple ovoid fruit."),
    copy_from = "goblin_fruit_abstract",
    color = "magenta",
    mass = "279 g",
    volume = "294 ml",
    light = 650,
    flags = { "FREEZERBURN", "NO_AUTO_CONSUME" },
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_blind_flash" },
}

ccb.content.define_item {
    id = "goblin_fruit_map",
    name = ccb.content.plural_text("rotating goblin fruit", "rotating goblin fruits"),
    description = ccb.content.text("This spiraled fruit ceaselessly spins on itself.  No matter how tight your grasp, you cannot stop its spinning."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "224 g",
    volume = "244 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_map" },
}

ccb.content.define_item {
    id = "goblin_fruit_adrenaline",
    name = ccb.content.plural_text("pulsating goblin fruit", "pulsating goblin fruits"),
    description = ccb.content.text("This fruit pulses at regular intervals like a beating heart.  As you hold it its rhythm changes, mimicking your own heart."),
    copy_from = "goblin_fruit_abstract",
    color = "green",
    mass = "324 g",
    volume = "395 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_adrenaline" },
}

ccb.content.define_item {
    id = "goblin_fruit_focus_boost",
    name = ccb.content.plural_text("understandable goblin fruit", "understandable goblin fruits"),
    description = ccb.content.text("You understand everything about this pale green fruit.  You know that it will taste like an apple and you know that it will have the inner structure of a kiwi, the texture of a durian, the smell of a dragon fruit and the colors of an orange.  you also know that eating it will help you understand anything you could try to learn for a few hours."),
    copy_from = "goblin_fruit_abstract",
    color = "green_white",
    mass = "215 g",
    volume = "231 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_focus_boost" },
}

-- The idea is that this fruit needs to feed on happiness to create other goblin fruits and it can't do that unless you eat it, with predictable results on your own happiness.
ccb.content.define_item {
    id = "goblin_fruit_spawn_more_fruits",
    name = ccb.content.plural_text("pupating goblin fruit", "pupating goblin fruits"),
    description = ccb.content.text("This dark red half-liquid fruit fills you with dread and sadness as it endlessly tries to split but fails to do so.  You sense that it wants you to eat it, but you're not sure if it would be worth it."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray_red",
    mass = "331 g",
    volume = "350 ml",
    comestible = {
        kind = "FOOD",
        fun = -30,
        vitamins = {
            { id = "vitC", amount = 10 },
            { id = "calcium", amount = 10 },
            { id = "iron", amount = 10 },
            { id = "fruit_allergen", amount = 1 },
            { id = "bad_food", amount = 25 },
        },
        on_consume = "eat_goblin_fruit_cluster",
    },
}

ccb.content.define_item {
    id = "goblin_fruit_fun",
    name = ccb.content.text("patchwork goblin fruit"),
    description = ccb.content.text("This fruit is closer to an art project than to a fruit.  Numerous stitches hold together red-tinted parts of many different fruits so tightly it acts as a single, consistent whole."),
    copy_from = "goblin_fruit_abstract",
    color = "light_red",
    mass = "379 g",
    volume = "345 ml",
    comestible = { kind = "FOOD", fun = 30 },
}

ccb.content.define_item {
    id = "goblin_fruit_no_spoil",
    name = ccb.content.text("pristine goblin fruit"),
    description = ccb.content.text("This fruit has a perfectly unblemished surface that cannot be tarnished or dirtied, no matter what happens to it."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow_cyan",
    mass = "222 g",
    volume = "202 ml",
    comestible = { kind = "FOOD", shelf_life = 0 },
}

ccb.content.define_item {
    id = "goblin_fruit_numbing",
    name = ccb.content.plural_text("numbing goblin fruit", "numbing goblin fruits"),
    description = ccb.content.text("This gray dented fruit numbs your fingers as you hold it and its smell numbs your nose the same way."),
    copy_from = "goblin_fruit_abstract",
    color = "light_gray",
    mass = "244 g",
    volume = "222 ml",
    comestible = { kind = "FOOD", fun = 0, on_consume = "eat_numbing_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_spawn_shadows",
    name = ccb.content.plural_text("whispering goblin fruit", "whispering goblin fruits"),
    description = ccb.content.text("This fruit is similar to a sphere of smoke.  Faint sounds come from this fruit.  They almost sound like whispers."),
    copy_from = "goblin_fruit_abstract",
    color = "dark_gray",
    mass = "275 g",
    volume = "250 ml",
    comestible = { kind = "FOOD", on_consume = "eat_shadow_goblin_fruit" },
}

ccb.content.define_monster {
    id = "mon_dream_shadow_player",
    copy_from = "mon_dream_shadow",
    name = ccb.content.plural_text("shadow", "shadows"),
    default_faction = "player",
}

ccb.content.define_item {
    id = "goblin_fruit_heal_after_sleep",
    name = ccb.content.plural_text("recoloring goblin fruit", "recoloring goblin fruits"),
    description = ccb.content.text("This rectangle fruit smells of lavender and has a mushy texture.  Its colors grow more vibrant for a second when you blink."),
    copy_from = "goblin_fruit_abstract",
    color = "green_white",
    mass = "238 g",
    volume = "217 ml",
    flags = { "FREEZERBURN", "NO_AUTO_CONSUME", "MUSHY" },
    comestible = { kind = "FOOD", on_consume = "eat_restful_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_teleport",
    name = ccb.content.plural_text("fractal goblin fruit", "fractal goblin fruits"),
    description = ccb.content.text("This spherical fruit is made of smaller versions of itself, which are also made of smaller versions of themselves.  Should you have a microscope, you could look at the fractal as it becomes smaller and smaller."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "458 g",
    volume = "417 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_teleport" },
}

ccb.content.define_item {
    id = "goblin_fruit_climb",
    name = ccb.content.plural_text("sticky goblin fruit", "sticky goblin fruits"),
    description = ccb.content.text("Reeking of glass cleaner, this disk-shaped fruit sticks to anything it touches.  Despite this, you have no issue removing any dust sticking to it."),
    copy_from = "goblin_fruit_abstract",
    color = "light_blue",
    mass = "359 g",
    volume = "327 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_climb" },
}

ccb.content.define_item {
    id = "goblin_fruit_amplification_instant",
    name = ccb.content.plural_text("pressurized goblin fruit", "pressurized goblin fruits"),
    description = ccb.content.text("This capsule-shaped goblin fruit behaves as a pressurized tank when you press its surface with your finger.  Fortunately, it doesn't appear to be able to explode if pierced or bitten."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "359 g",
    volume = "327 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_amplification_instant" },
}

ccb.content.define_item {
    id = "goblin_fruit_carry_boost",
    name = ccb.content.plural_text("balloon goblin fruit", "balloon goblin fruits"),
    description = ccb.content.text("This fruit is nothing more than a thin layer of fruit filled with air.  It has a heady aroma that makes you a little lightheaded."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow",
    mass = "25 g",
    volume = "257 ml",
    materials = { "fruit_light" },
    comestible = { kind = "FOOD", calories = 5, on_consume = "consume_goblin_fruit_carry_boost" },
}

ccb.content.define_item {
    id = "goblin_fruit_mood_clear",
    name = ccb.content.plural_text("boring goblin fruit", "boring goblin fruits"),
    description = ccb.content.text("This fruit is the most boring thing you've ever seen.  Everything about it is boring: its drab dark brown color, its smell, its lack of feature, even its taste is boring.  It's not a good fruit.  It's not a bad fruit.  It's just boring."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "255 g",
    volume = "262 ml",
    comestible = { kind = "FOOD", fun = 0, on_consume = "eat_boring_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_wild_travel_boost",
    name = ccb.content.plural_text("mud-covered goblin fruit", "mud-covered goblin fruits"),
    description = ccb.content.text("This fruit is always covered in fresh mud.  You try to wipe it away, but it always come back."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "304 g",
    volume = "377 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_wild_travel_boost" },
}

ccb.content.define_item {
    id = "goblin_fruit_slowing_armor",
    name = ccb.content.plural_text("cavernous goblin fruit", "cavernous goblin fruits"),
    description = ccb.content.text("This fruit has the shape of a hollow cylinder.  It has a notable smell of freshly-upturned earth."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "304 g",
    volume = "377 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_slowing_armor" },
}

ccb.content.define_item {
    id = "goblin_fruit_social_boost",
    name = ccb.content.plural_text("arguing goblin fruit", "arguing goblin fruits"),
    description = ccb.content.text("This fruit reminds you of a small bowling ball.  You can hear it as it tries to convince you to not eat it.  It won't succeed, right?"),
    copy_from = "goblin_fruit_abstract",
    color = "blue_red",
    mass = "221 g",
    volume = "221 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_social_boost" },
}

ccb.content.define_item {
    id = "goblin_fruit_heat_blast",
    name = ccb.content.plural_text("urchin goblin fruit", "urchin goblin fruits"),
    description = ccb.content.text("This spherical fruit bears many spines, yet all of of them are dulled.  It smells faintly of cinnamon and aftershave."),
    copy_from = "goblin_fruit_abstract",
    color = "red",
    mass = "331 g",
    volume = "341 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_heat_blast" },
}

ccb.content.define_item {
    id = "goblin_fruit_altitude_speed",
    name = ccb.content.plural_text("rushing goblin fruit", "rushing goblin fruits"),
    description = ccb.content.text("This pale fruit is surrounded by small lines of wind revolving around it.  The lines grow thicker the further the fruit is from the ground."),
    copy_from = "goblin_fruit_abstract",
    color = "white",
    mass = "188 g",
    volume = "191 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_altitude_speed" },
}

ccb.content.define_item {
    id = "goblin_fruit_cold_resist",
    name = ccb.content.plural_text("sapphire goblin fruit", "sapphire goblin fruits"),
    description = ccb.content.text("This fruit is easily mistakable for a fist-sized sapphire.  Its color, rigidity and facets bring to mind a gemstone, unlike its green stem."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "259 g",
    volume = "266 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_cold_resist" },
}

ccb.content.define_item {
    id = "goblin_fruit_craft_speed_boost",
    name = ccb.content.plural_text("shy goblin fruit", "shy goblin fruits"),
    description = ccb.content.text("This fruit shaped akin to a chunk torn from a beehive is warm, but becomes cold as long as anyone is looking at it.  It has a strong odor, between maple and oak, but only when unobserved."),
    copy_from = "goblin_fruit_abstract",
    color = "green",
    mass = "302 g",
    volume = "375 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_craft_speed_boost" },
}

ccb.content.define_item {
    id = "goblin_fruit_call_rain",
    name = ccb.content.plural_text("weeping goblin fruit", "weeping goblin fruits"),
    description = ccb.content.text("This blue tear-shaped fruit drips with water.  You try to collect it, but it fades away before touching the container."),
    copy_from = "goblin_fruit_abstract",
    color = "blue",
    mass = "259 g",
    volume = "276 ml",
    comestible = { kind = "FOOD", on_consume = "eat_weeping_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_animal_ignore",
    name = ccb.content.plural_text("furry goblin fruit", "furry goblin fruits"),
    description = ccb.content.text("This fruit what a kiwi would be if kiwi had decimeter-long beige fur.  It smells of steel and lilies."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "314 g",
    volume = "386 ml",
    comestible = { kind = "FOOD", fun = -3, on_consume = "eat_furry_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_mend_bone",
    name = ccb.content.plural_text("remolding goblin fruit", "remolding goblin fruits"),
    description = ccb.content.text("This gray fruit is hard to pierce, as it reshapes itself to close any hole you make in it.  Ironically, the fruit keeps tearing its surface apart, making its reshaping a sisyphean task."),
    copy_from = "goblin_fruit_abstract",
    color = "light_gray",
    mass = "330 g",
    volume = "330 ml",
    comestible = { kind = "FOOD", on_consume = "eat_remolding_goblin_fruit" },
}

ccb.content.define_item {
    id = "goblin_fruit_cure_dreamless",
    name = ccb.content.plural_text("cloudy goblin fruit", "cloudy goblin fruits"),
    description = ccb.content.text("This fruit looks like a crystal ball filled with clouds.  When you look into it, you see fragments of your most intense dreams."),
    copy_from = "goblin_fruit_abstract",
    color = "light_blue",
    mass = "220 g",
    volume = "220 ml",
    comestible = { kind = "FOOD", on_consume = "eat_cloudy_goblin_fruit" },
}
