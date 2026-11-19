local ccb = require("ccb")

ccb.content.define_spell {
    id = "hedge_clairvoyance_cone",
    copy_from = "hedge_clairvoyance_cone",
    name = ccb.content.text("To See Beyond the Barriers"),
    description = ccb.content.text("Gain a brief vision of what lies beyond a barrier."),
    message = ccb.content.text("You close your eyes and place the sharp rock over them and press, just slightly.  As the pain blooms and the blood trickles, you see beyond."),
}

ccb.content.define_spell {
    id = "hedge_luck_spell",
    copy_from = "hedge_luck_spell",
    name = ccb.content.text("To Spin the Coin of Gad"),
    description = ccb.content.text("With a candle, a bit of copper, and paper, this will create a short lived luck charm upon oneself."),
    message = ccb.content.text("You write the words upon the paper, place the copper on the ground, place the paper upon the copper, light the candle then the paper and firmly place the candle in the ashes on top of the copper, let the candle burn down melting all over the copper.  You will find your steps slightly lucky for the several hours to potentially a full day."),
}

ccb.content.define_spell {
    id = "hedge_protect_the_mind",
    copy_from = "hedge_protect_the_mind",
    name = ccb.content.text("To Shield the Spirit from Assault"),
    description = ccb.content.text("The first principle of defending your spirit is to make sure it is in proper order so there is no foothold an assault can take advantage of.  While in effect, your soul is protected against attack.  <color_red>Too much pain</color> will disrupt your concentration."),
    message = ccb.content.text("You settle down and begin ordering your spirit."),
}

ccb.content.define_spell {
    id = "hedge_raziel_amulet_protection",
    copy_from = "hedge_raziel_amulet_protection",
    name = ccb.content.text("To Wrap Yourself in the Names"),
    description = ccb.content.text("Over alcohol and an egg and an apple or citrus fruit, inscribe a copper amulet with the names of spirits and the hidden names of God to create a talisman that will protect you from harm."),
    message = ccb.content.text("You recite the names of seven spirits over the alcohol, you engrave the sigil on the fruit and eat it, and you write the secret phrases on the egg before you set down and begin carving names on the copper necklace."),
}

ccb.content.define_spell {
    id = "hedge_prevent_wild_animal_attacks",
    copy_from = "hedge_prevent_wild_animal_attacks",
    name = ccb.content.text("To Shut the Bear's Mouth"),
    description = ccb.content.text("Wild animals are one of the greatest threats to you now.  By entreating the aid of the spirits who rule over dangerous creatures and using the droppings of living animals, you can prevent nearby wild animals from attacking you."),
    message = ccb.content.text("\"By the name of Methenail, and by the name of Aphethial, and by the name of Vobehielael, who hold dominion over the beasts of the wild, I abjure thee\"."),
    components = "spell_components_hedge_prevent_wild_animal_attacks",
}

ccb.content.define_spell {
    id = "hedge_extinguish_fire_spell",
    copy_from = "hedge_extinguish_fire_spell",
    name = ccb.content.text("To Don the Mantle of the Sun"),
    description = ccb.content.text("The sun is light and heat, filling the sky and providing life to the earth below, and the stars fear it and hide from its light.  This charm allows you to imitate the sun, subduing all lesser fires and causing them to flee for places safer."),
    message = ccb.content.text("You place the ash upon your tongue and, shredding the morningflower leaves and hurling them into the air, recite the words of the charm."),
}
