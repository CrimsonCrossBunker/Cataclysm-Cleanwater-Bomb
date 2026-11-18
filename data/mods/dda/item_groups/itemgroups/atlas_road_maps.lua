local content = require("ccb").content

do
    local group = content.ItemGroup { id = "roadmap_stock", kind = "distribution" }
    group:item("roadmap")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "atlas_maps_US", kind = "distribution" }
    group:item("atlas_map_us-ak")
    group:item("atlas_map_us-al")
    group:item("atlas_map_us-ar")
    group:item("atlas_map_us-az")
    group:item("atlas_map_us-ca")
    group:item("atlas_map_us-co")
    group:item("atlas_map_us-ct")
    group:item("atlas_map_us-dc")
    group:item("atlas_map_us-de")
    group:item("atlas_map_us-fl")
    group:item("atlas_map_us-ga")
    group:item("atlas_map_us-hi")
    group:item("atlas_map_us-ia")
    group:item("atlas_map_us-id")
    group:item("atlas_map_us-il")
    group:item("atlas_map_us-in")
    group:item("atlas_map_us-ks")
    group:item("atlas_map_us-ky")
    group:item("atlas_map_us-la")
    group:item("atlas_map_us-ma")
    group:item("atlas_map_us-md")
    group:item("atlas_map_us-me")
    group:item("atlas_map_us-mi")
    group:item("atlas_map_us-mn")
    group:item("atlas_map_us-mo")
    group:item("atlas_map_us-ms")
    group:item("atlas_map_us-mt")
    group:item("atlas_map_us-nc")
    group:item("atlas_map_us-nd")
    group:item("atlas_map_us-ne")
    group:item("atlas_map_us-nh")
    group:item("atlas_map_us-nj")
    group:item("atlas_map_us-nm")
    group:item("atlas_map_us-nv")
    group:item("atlas_map_us-ny")
    group:item("atlas_map_us-oh")
    group:item("atlas_map_us-ok")
    group:item("atlas_map_us-or")
    group:item("atlas_map_us-pa")
    group:item("atlas_map_us-ri")
    group:item("atlas_map_us-sc")
    group:item("atlas_map_us-sd")
    group:item("atlas_map_us-tn")
    group:item("atlas_map_us-tx")
    group:item("atlas_map_us-ut")
    group:item("atlas_map_us-va")
    group:item("atlas_map_us-vt")
    group:item("atlas_map_us-wa")
    group:item("atlas_map_us-wi")
    group:item("atlas_map_us-wv")
    group:item("atlas_map_us-wy")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "atlas_maps_CA", kind = "distribution" }
    group:item("atlas_map_ca-ab")
    group:item("atlas_map_ca-bc")
    group:item("atlas_map_ca-mb")
    group:item("atlas_map_ca-nb")
    group:item("atlas_map_ca-nl")
    group:item("atlas_map_ca-ns")
    group:item("atlas_map_ca-nt")
    group:item("atlas_map_ca-nu")
    group:item("atlas_map_ca-on")
    group:item("atlas_map_ca-pe")
    group:item("atlas_map_ca-qc")
    group:item("atlas_map_ca-sk")
    group:item("atlas_map_ca-yt")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "atlas_maps_MX", kind = "distribution" }
    group:item("atlas_map_mx-agu")
    group:item("atlas_map_mx-bcn")
    group:item("atlas_map_mx-bcs")
    group:item("atlas_map_mx-cam")
    group:item("atlas_map_mx-chh")
    group:item("atlas_map_mx-chp")
    group:item("atlas_map_mx-cmx")
    group:item("atlas_map_mx-coa")
    group:item("atlas_map_mx-col")
    group:item("atlas_map_mx-dur")
    group:item("atlas_map_mx-gro")
    group:item("atlas_map_mx-gua")
    group:item("atlas_map_mx-hid")
    group:item("atlas_map_mx-jal")
    group:item("atlas_map_mx-mex")
    group:item("atlas_map_mx-mic")
    group:item("atlas_map_mx-mor")
    group:item("atlas_map_mx-nay")
    group:item("atlas_map_mx-nle")
    group:item("atlas_map_mx-oax")
    group:item("atlas_map_mx-pue")
    group:item("atlas_map_mx-que")
    group:item("atlas_map_mx-roo")
    group:item("atlas_map_mx-sin")
    group:item("atlas_map_mx-slp")
    group:item("atlas_map_mx-son")
    group:item("atlas_map_mx-tab")
    group:item("atlas_map_mx-tam")
    group:item("atlas_map_mx-tla")
    group:item("atlas_map_mx-ver")
    group:item("atlas_map_mx-yuc")
    group:item("atlas_map_mx-zac")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "atlas_maps", kind = "distribution" }
    group:group("atlas_maps_US")
    group:group("atlas_maps_CA")
    group:group("atlas_maps_MX")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-AB", kind = "distribution" }
    group:item("atlas_map_ca-ab", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-BC", kind = "distribution" }
    group:item("atlas_map_ca-bc", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-MB", kind = "distribution" }
    group:item("atlas_map_ca-mb", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-NB", kind = "distribution" }
    group:item("atlas_map_ca-nb", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-NL", kind = "distribution" }
    group:item("atlas_map_ca-nl", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-NS", kind = "distribution" }
    group:item("atlas_map_ca-ns", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-NT", kind = "distribution" }
    group:item("atlas_map_ca-nt", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-NU", kind = "distribution" }
    group:item("atlas_map_ca-nu", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-ON", kind = "distribution" }
    group:item("atlas_map_ca-on", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-PE", kind = "distribution" }
    group:item("atlas_map_ca-pe", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-QC", kind = "distribution" }
    group:item("atlas_map_ca-qc", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-SK", kind = "distribution" }
    group:item("atlas_map_ca-sk", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-CA-YT", kind = "distribution" }
    group:item("atlas_map_ca-yt", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_CA", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-AGU", kind = "distribution" }
    group:item("atlas_map_mx-agu", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-BCN", kind = "distribution" }
    group:item("atlas_map_mx-bcn", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-BCS", kind = "distribution" }
    group:item("atlas_map_mx-bcs", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-CAM", kind = "distribution" }
    group:item("atlas_map_mx-cam", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-CHH", kind = "distribution" }
    group:item("atlas_map_mx-chh", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-CHP", kind = "distribution" }
    group:item("atlas_map_mx-chp", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-CMX", kind = "distribution" }
    group:item("atlas_map_mx-cmx", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-COA", kind = "distribution" }
    group:item("atlas_map_mx-coa", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-COL", kind = "distribution" }
    group:item("atlas_map_mx-col", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-DUR", kind = "distribution" }
    group:item("atlas_map_mx-dur", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-GRO", kind = "distribution" }
    group:item("atlas_map_mx-gro", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-GUA", kind = "distribution" }
    group:item("atlas_map_mx-gua", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-HID", kind = "distribution" }
    group:item("atlas_map_mx-hid", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-JAL", kind = "distribution" }
    group:item("atlas_map_mx-jal", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-MEX", kind = "distribution" }
    group:item("atlas_map_mx-mex", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-MIC", kind = "distribution" }
    group:item("atlas_map_mx-mic", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-MOR", kind = "distribution" }
    group:item("atlas_map_mx-mor", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-NAY", kind = "distribution" }
    group:item("atlas_map_mx-nay", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-NLE", kind = "distribution" }
    group:item("atlas_map_mx-nle", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-OAX", kind = "distribution" }
    group:item("atlas_map_mx-oax", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-PUE", kind = "distribution" }
    group:item("atlas_map_mx-pue", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-QUE", kind = "distribution" }
    group:item("atlas_map_mx-que", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-ROO", kind = "distribution" }
    group:item("atlas_map_mx-roo", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-SIN", kind = "distribution" }
    group:item("atlas_map_mx-sin", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-SLP", kind = "distribution" }
    group:item("atlas_map_mx-slp", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-SON", kind = "distribution" }
    group:item("atlas_map_mx-son", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-TAB", kind = "distribution" }
    group:item("atlas_map_mx-tab", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-TAM", kind = "distribution" }
    group:item("atlas_map_mx-tam", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-TLA", kind = "distribution" }
    group:item("atlas_map_mx-tla", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-VER", kind = "distribution" }
    group:item("atlas_map_mx-ver", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-YUC", kind = "distribution" }
    group:item("atlas_map_mx-yuc", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-MX-ZAC", kind = "distribution" }
    group:item("atlas_map_mx-zac", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_MX", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-AK", kind = "distribution" }
    group:item("atlas_map_us-ak", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-AL", kind = "distribution" }
    group:item("atlas_map_us-al", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-AR", kind = "distribution" }
    group:item("atlas_map_us-ar", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-AZ", kind = "distribution" }
    group:item("atlas_map_us-az", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-CA", kind = "distribution" }
    group:item("atlas_map_us-ca", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-CO", kind = "distribution" }
    group:item("atlas_map_us-co", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-CT", kind = "distribution" }
    group:item("atlas_map_us-ct", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-DC", kind = "distribution" }
    group:item("atlas_map_us-dc", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-DE", kind = "distribution" }
    group:item("atlas_map_us-de", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-FL", kind = "distribution" }
    group:item("atlas_map_us-fl", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-GA", kind = "distribution" }
    group:item("atlas_map_us-ga", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-HI", kind = "distribution" }
    group:item("atlas_map_us-hi", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-IA", kind = "distribution" }
    group:item("atlas_map_us-ia", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-ID", kind = "distribution" }
    group:item("atlas_map_us-id", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-IL", kind = "distribution" }
    group:item("atlas_map_us-il", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-IN", kind = "distribution" }
    group:item("atlas_map_us-in", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-KS", kind = "distribution" }
    group:item("atlas_map_us-ks", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-KY", kind = "distribution" }
    group:item("atlas_map_us-ky", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-LA", kind = "distribution" }
    group:item("atlas_map_us-la", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-MA", kind = "distribution" }
    group:item("atlas_map_us-ma", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-MD", kind = "distribution" }
    group:item("atlas_map_us-md", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-ME", kind = "distribution" }
    group:item("atlas_map_us-me", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-MI", kind = "distribution" }
    group:item("atlas_map_us-mi", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-MN", kind = "distribution" }
    group:item("atlas_map_us-mn", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-MO", kind = "distribution" }
    group:item("atlas_map_us-mo", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-MS", kind = "distribution" }
    group:item("atlas_map_us-ms", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-MT", kind = "distribution" }
    group:item("atlas_map_us-mt", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-NC", kind = "distribution" }
    group:item("atlas_map_us-nc", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-ND", kind = "distribution" }
    group:item("atlas_map_us-nd", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-NE", kind = "distribution" }
    group:item("atlas_map_us-ne", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-NH", kind = "distribution" }
    group:item("atlas_map_us-nh", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-NJ", kind = "distribution" }
    group:item("atlas_map_us-nj", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-NM", kind = "distribution" }
    group:item("atlas_map_us-nm", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-NV", kind = "distribution" }
    group:item("atlas_map_us-nv", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-NY", kind = "distribution" }
    group:item("atlas_map_us-ny", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-OH", kind = "distribution" }
    group:item("atlas_map_us-oh", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-OK", kind = "distribution" }
    group:item("atlas_map_us-ok", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-OR", kind = "distribution" }
    group:item("atlas_map_us-or", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-PA", kind = "distribution" }
    group:item("atlas_map_us-pa", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-RI", kind = "distribution" }
    group:item("atlas_map_us-ri", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-SC", kind = "distribution" }
    group:item("atlas_map_us-sc", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-SD", kind = "distribution" }
    group:item("atlas_map_us-sd", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-TN", kind = "distribution" }
    group:item("atlas_map_us-tn", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-TX", kind = "distribution" }
    group:item("atlas_map_us-tx", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-UT", kind = "distribution" }
    group:item("atlas_map_us-ut", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-VA", kind = "distribution" }
    group:item("atlas_map_us-va", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-VT", kind = "distribution" }
    group:item("atlas_map_us-vt", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-WA", kind = "distribution" }
    group:item("atlas_map_us-wa", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-WI", kind = "distribution" }
    group:item("atlas_map_us-wi", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-WV", kind = "distribution" }
    group:item("atlas_map_us-wv", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "roadmap_stock-US-WY", kind = "distribution" }
    group:item("atlas_map_us-wy", 65)
    group:item("roadmap", 20)
    group:group("atlas_maps_US", 12)
    group:group("atlas_maps", 3)
    content.add(group)
end
