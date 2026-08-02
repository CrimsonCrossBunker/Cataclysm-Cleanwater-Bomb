<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `json.region-layout`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/region-layout/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/region-layout/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
<!-- CCB-DOC-MOVED-END -->
# Region Layout

Region layouts provide handling for assigning region settings by overmap at a world scale. The simplest example:

```json
{
	"type": "dimension_region_layout",
	"id": "default",
	"generation_mode": "UNIFORM",
	"uniform_region": "default"
}
```

Region layouts have a secondary type: "generation_mode", which defines how the layout is generated.

There are two broad types of region layouts: STATIC and DYNAMIC.
- DYNAMIC layouts are determined upon generating an overmap.
- STATIC layouts have predetermined bounds and are generated along with the first overmap,
using a DYNAMIC layout to generate out-of-bounds overmaps.

Listed below is documentation for each region layout mode's fields:

## UNIFORM (Type: DYNAMIC)
All overmaps are generated with a single region. See the top of this document for an example.

|       Identifier       |                            Description                                        |
| ---------------------- | ----------------------------------------------------------------------------- |
| `uniform_region`       | region_id -- all overmaps will generate with this region.                     |
