local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "nl_safehouse_boiler_plans",
        name = ccb.content.plural_text("graven slab", "graven slabs"),
        category = "artifact",
        symbol = ",",
        color = "light_gray",
        description = ccb.content.text("A thin sheet of otherworldly material etched with crude pictographs.  Upon closer inspection, the pictographs are slowly moving - animated grooves carved into the strange metal.  They show a squat, round vessel with its front opening like a jaw as a faceless humanoid places various objects, including a leaf, a wrench, and a dead animal, inside it.  Above it, three circular eyes sit empty, then begin to radiate jagged lines as a side crank is turned.  The contents of the chamber are reduced to a scribbled, lightning-bolt haze.  In the final image, the humanoid figure stands smaller than before, as the three darkened eyes focus into pupils, chasing the figure's descent."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 150000,
        volume_ml = 20,
    }
    item:material("anomaly", 1)
    content.add(item)
end
