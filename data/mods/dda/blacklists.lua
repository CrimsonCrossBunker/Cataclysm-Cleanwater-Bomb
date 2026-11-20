local ccb = require("ccb")
local content = ccb.content

-- Native monster blacklists
do
local definition = content.Blacklist {
    kind = "monster",
    whitelist = false,
}
content.add(definition)
end

-- Native charge-removal blacklists
do
local definition = content.Blacklist {
    kind = "charge_removal",
    whitelist = false,
}
definition:entry("hinge")
content.add(definition)
end

-- Native temperature-removal blacklists
do
local definition = content.Blacklist {
    kind = "temperature_removal",
    whitelist = false,
}
definition:entry("napkin")
definition:entry("cardboard")
definition:entry("adhesive_bandages")
definition:entry("alcohol_wipes")
definition:entry("bandages")
definition:entry("bandages_makeshift")
definition:entry("bandages_makeshift_bleached")
definition:entry("bandages_makeshift_boiled")
definition:entry("cotton_ball")
definition:entry("disinrag")
definition:entry("disincotton_ball")
definition:entry("medical_gauze")
definition:entry("ammonia_liquid")
definition:entry("chem_sulphur")
definition:entry("insecticide")
definition:entry("wax")
definition:entry("bifocal_contacts_weekly")
definition:entry("bifocal_transition_contacts_weekly")
definition:entry("butternut")
definition:entry("bone_demihuman")
definition:entry("bone_human")
definition:entry("bone_tainted")
definition:entry("large_bone")
definition:entry("chem_peptone_broth")
definition:entry("chem_agar")
definition:entry("chem_acrylamide")
definition:entry("chem_citric_acid")
definition:entry("bone")
definition:entry("meal_bone")
definition:entry("melatonin_tablet")
definition:entry("adderall")
definition:entry("antibiotics")
definition:entry("antifungal")
definition:entry("antiparasitic")
definition:entry("aspirin")
definition:entry("ibuprofen")
definition:entry("naproxen")
definition:entry("acetaminophen")
definition:entry("metaprolol")
definition:entry("bfipowder")
definition:entry("caffeine")
definition:entry("cig")
definition:entry("cigar")
definition:entry("codeine")
definition:entry("coke")
definition:entry("crack")
definition:entry("diazepam")
definition:entry("handrolled_cig")
definition:entry("heroin")
definition:entry("iodine")
definition:entry("joint")
definition:entry("lsd")
definition:entry("meth")
definition:entry("pure_meth")
definition:entry("morphine")
definition:entry("antihistamine")
definition:entry("oxycodone")
definition:entry("pills_sleep")
definition:entry("poppy_pain")
definition:entry("poppy_sleep")
definition:entry("prozac")
definition:entry("prussian_blue")
definition:entry("quikclot")
definition:entry("thorazine")
definition:entry("tobacco")
definition:entry("tramadol")
definition:entry("vitamins")
definition:entry("calcium_tablet")
definition:entry("bonemeal_tablet")
definition:entry("flavored_bonemeal_tablet")
definition:entry("vitc_tablet")
definition:entry("gummy_vitamins")
definition:entry("homeopathic_pills")
definition:entry("inj_iron")
definition:entry("weed")
definition:entry("xanax")
definition:entry("weak_antibiotic")
definition:entry("tums")
definition:entry("panacea")
definition:entry("strong_antibiotic")
content.add(definition)
end
