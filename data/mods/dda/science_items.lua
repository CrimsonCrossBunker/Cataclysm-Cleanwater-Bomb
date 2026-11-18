local content = require("ccb").content

local function item(options, materials, tool)
    local result = content.Item(options)
    for _, material in ipairs(materials) do result:material(material, 1) end
    if tool then result:tool() end
    return result
end

content.add(item({
    id = "catalytic_cracking_reactor", name = content.text("disassembled catalytic cracking reactor"),
    description = content.text("A makeshift extraction system, or as makeshift as you can consider something that was purpose-built in a laboratory by a group of experts.  Meticulously disassembled.  You can reassemble and plug it into your own power grid to use it."),
    category = "tools", symbol = "Y", color = "light_cyan", looks_like = "f_catalytic_cracking_reactor",
    mass_grams = 500000, volume_ml = 500000, price_cents = 20000, price_postapoc_cents = 500,
}, { "steel" }))

content.add(item({
    id = "cuvettes", name = content.plural_text("set of spectrometry cuvettes", "sets of spectrometry cuvettes"),
    description = content.text("A small box filled with precisely-calibrated square plastic tubes for laboratory spectrometer use."),
    category = "tools", symbol = ";", color = "light_gray", mass_grams = 70, volume_ml = 250,
    price_cents = 1200, price_postapoc_cents = 250,
}, { "plastic" }, true))

content.add(item({
    id = "burette", name = content.text("burette"),
    description = content.text("A tall glass column with a stopcock at the end.  If you're serious about chemistry, you probably have a tattoo of one of these somewhere."),
    category = "tools", looks_like = "glass_tube_small", symbol = "|", color = "light_blue",
    mass_grams = 300, volume_ml = 1000, price_cents = 1000, price_postapoc_cents = 100,
}, { "glass", "plastic" }, true))

-- The base slide includes its glass cover.
content.add(item({
    id = "microscope_slide", name = content.text("microscope slide"),
    description = content.text("A tiny, thin rectangle of glass, used to observe samples through microscopes."),
    mass_milligrams = 4125, volume_ml = 2, price_postapoc_cents = 0, symbol = "-", color = "light_cyan",
}, { "glass" }))
for _, options in ipairs {
    {
        id = "microscope_slide_water_murky", copy_from = "microscope_slide", looks_like = "microscope_slide",
        name = content.plural_text("microscope slide of murky water", "microscope slides of murky water"),
        description = content.text("A microscope slide with a sample of murky water."),
    },
    {
        id = "microscope_slide_soil", copy_from = "microscope_slide", looks_like = "microscope_slide",
        name = content.plural_text("microscope slide of soil", "microscope slides of soil"),
        description = content.text("A microscope slide with a sample of soil."),
    },
} do
    content.add(content.Item(options))
end

-- Based on the ecoTech Mini Met mobile weather station and aem weather backpack.
local station = item({
    id = "mobile_weather_station", name = content.text("mobile weather station"),
    description = content.text("A large yellow case filled with equipment to measure atmospheric conditions.  It is outfitted with a carrying handle, a telescoping stand, and a rechargeable battery pack.  Its small display can show the current weather.  It can also make long-term recordings, but these data are useless without specialized software to interpret them."),
    mass_grams = 5000, volume_ml = 89400, longest_side_mm = 600,
    price_cents = 40000, price_postapoc_cents = 50, symbol = "[", looks_like = "briefcase", color = "yellow",
}, { "plastic", "aluminum" }, true)
for _, flag in ipairs { "WATERPROOF", "ELECTRONIC", "NO_UNLOAD", "NO_RELOAD", "RECHARGE" } do
    station:flag(flag)
end
station:ammo_pocket("battery", 1000)
content.add(station)
