<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `content.ascii-art`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/content/ascii-art/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/content/ascii-art/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
*Contents*

- [Making ASCII art for CDDA](#making-ascii-art-for-cdda)
  - [ASCII art Editors](#ascii-art-editors)
  - [Installing REXPaint](#installing-rexpaint)
  - [Drawing](#drawing)
  - [Exporting](#exporting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Making ASCII art for CDDA
### ASCII art Editors
ASCII art can be made using any text editor, such as Notepad, but it's more convenient to use an editor created for making ASCII art. There are many ASCII art editors on the internet, but this guide focuses on REXPaint because aside from many useful features like drawing ellipses, rectangles, lines and other shapes, it's the only editor with the option to export images to a format readable by CDDA. Note that this is not a comprehensive REXPaint manual, you can find the full manual [here](https://github.com/Lucide/REXPaint-manual/blob/master/manual.md) or in your REXPaint folder.
### Installing REXPaint
1. Download REXPaint [here](https://www.gridsagegames.com/rexpaint/downloads.html) and unzip the folder. Note: in version 1.50 colors yellow and pink were not exported correctly. This has been fixed in version 1.60.
2. Download CDDA color palette [here](https://www.gridsagegames.com/rexpaint/resources.html#Palettes) and put in the `palettes` folder.  Change the palette in REXPaint to "CDDA" palette using `[` and `]` buttons. You can sort the colors nicely by pressing `Ctrl-Shift-o`.
3. Download unifont font (the font used in CDDA) [here](https://www.gridsagegames.com/rexpaint/resources.html#Fonts). Put it into the `data/fonts` folder and paste the following line at the bottom of `_config.xt` file:
`"unifont 8x16"		unifont_8x16	16	16	unifont_8x16	16	16	_utf8	_mirror	1	//	640x960`.
You can change the font in REXPaint by pressing `Ctrl-wheel`.
### Drawing
Now you can draw your art. It's strongly advised to check the manual for descriptions of all tools. Note that art for CDDA can't be wider than 41 characters, therefore it's advised to set `defaultImageWidth` to 41 in `REXPaint.cfg`. If you use different colors than those found in CDDA palette, they'll be exported as white.
### Exporting
Once you've finished making your art you can export it by pressing `Ctrl-j`. This will produce a text file ready to be pasted into the corresponding `[ITEM_CATEGORY]_ascii.json` or `[BODY_PART]_graph.json` in the `data/json/ascii_art` or `data/json/bodypart_graphs` folders, respectively, complete with color tags. Make sure that the canvas isn't wider that 41 characters (or 40 characters for body graphs) before exporting. For more information about adding your art to the game read `JSON_INFO.md`.
