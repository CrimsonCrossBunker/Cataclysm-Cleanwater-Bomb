<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.region-layout`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/region-layout/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/region-layout/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
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
