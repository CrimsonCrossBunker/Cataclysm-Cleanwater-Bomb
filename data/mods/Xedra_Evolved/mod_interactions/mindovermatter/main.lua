local ccb = require("ccb")

do
    local category = ccb.content.SnippetCategory { id = "lab_notes" }
    category:entry {
        id = "lab_notes_interdimensional_magick_6",
        text = ccb.content.text("Excerpt from 'Infinite Dimensions, Finite Magickal Systems by Tyco Arendt':\n\nThreat Classification: Psionics\nOpalPsi\n\nPsionically empowered individuals can often be disarmed using specific methods common across dimensions.  Identification of empowered individuals can be difficult in civilizations that either refuse or lack the knowledge of how to identify psionic individuals.  Upon discovery of any psionically active dimension, agents must immediately return to Cradle Earth and notify XEDRA-23 and then await further instructions.  Under no circumstances is any individual from a psionically-active dimension to be contacted or interacted with without the presence of personnel from XEDRA-23 present."),
        name = ccb.content.text("excerpt 6, Infinite Dimensions, Finite Magickal Systems"),
    }
    category:entry {
        id = "lab_notes_project_phavian_oa",
        text = ccb.content.text("I'm getting some requests from Leadership, that we need alternative means of controlling access to Ultraviolet clearance material.  The Project Phavian teams are producing a number of means of gathering information that can put all of our clearance materials in danger.  I know one of the Geniuses was saying he could create a chip to block telepathy but I understand it has a side effect of crippling migraines once a week?  How crippling?  One of the OA guys said they encountered a lock that is like a DNA fingerprint of your soul?  What's the odds on capturing that tech?"),
        name = ccb.content.text("existential passwords"),
    }
    category:entry {
        id = "lab_notes_project_phavian_oa_sleepwalkers",
        text = ccb.content.text("…so can we use a Sleepwalker to plug this leak?\n\n'Miranda': No, that's an incredibly bad idea.  What happens if they suddenly precog on pulling the trigger and it starts an interdepartmental war?  Then the war has already started and we will be the last to know.\n\n'Timothy': Surely there are other options?  Then I think we need to figure out some way to pull the leak over for an assignment at the gate and then have something come through.  Hostile environment spillover, subdued threat isn't actually subdued… what about a Dreamer summoning error?\n\n'Miranda': It'll have to be an actual error then, there's no doubt Gray Dawn will have someone bump into the patsy and scan them.  fdsu3r2 u34hwqe12udh213 'It fades into nonsense cryptographic hashes."),
        name = ccb.content.text("partially unencrypted teams conversation"),
    }
    ccb.content.add(category)
end

ccb.content.upsert_effect_type(ccb.content.EffectType {
    id = "effect_hedge_protect_the_mind",
    name = ccb.content.text("Ordered Mind"),
    description = ccb.content.text("Your mind is set in order, walled and guarded."),
    rating = "good",
}
    :flag("TEEPSHIELD"))
