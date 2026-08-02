<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `cpp-code-style`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/cpp/code-style/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/cpp/code-style/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
<!-- CCB-DOC-MOVED-END -->
# Code Style Guide

All of the C++ code in the project is styled. You should run any changes you make through astyle before pushing a pull request.

We are using astyle version 3.1. Other versions of astyle produce different formatting and should not be used.

Blocks of code can be passed through astyle to ensure that their formatting is correct:

    astyle --style=1tbs --attach-inlines --indent=spaces=4 --align-pointer=name --max-code-length=100 --break-after-logical --indent-classes --indent-preprocessor --indent-switches --indent-col1-comments --min-conditional-indent=0 --pad-oper --unpad-paren --pad-paren-in --add-brackets --convert-tabs --exclude=src/third-party --ignore-exclude-errors-x

These options are mirrored in `.astylerc`, `Cataclysm-DDA.sublime-project` and `doc/CODE_STYLE.txt`

For example, from `vi`, set marks a and b around the block, then:

    :'a,'b ! astyle  --style=1tbs --attach-inlines --indent=spaces=4 --align-pointer=name --max-code-length=100 --break-after-logical --indent-classes --indent-preprocessor --indent-switches --indent-col1-comments --min-conditional-indent=0 --pad-oper --unpad-paren --pad-paren-in --add-brackets --convert-tabs --exclude=src/third-party --ignore-exclude-errors-x

See [DEVELOPER_TOOLING.md](DEVELOPER_TOOLING.md) for other environments.

## Code Example

Here's an example that illustrates the most common points of style:

```cpp
int foo( int arg1, int *arg2 )
{
    if( arg1 < 5 ) {
        switch( *arg2 ) {
            case 0:
                return arg1 + 5;
                break;
            case 1:
                return arg1 + 7;
                break;
            default:
                return 0;
                break;
        }
    } else if( arg1 > 17 ) {
        int i = 0;
        while( i < arg1 ) {
            printf( _( "Really long message that's pointless except for the number %d and for its "
                       "length as it's illustrative of how to break strings properly.\n" ), i );
        }
    }
    return 0;
}
```

## Code Guidelines

These are less generic guidelines and more pain points we've stumbled across over time.

1. Use `int` for everything.
    1. `long` in particular is problematic since it is *not* a larger type than `int` on platforms we care about.
        1. If you need an integral value larger than 32 bits, you don't. But if you do, use `int64_t`.
    2. `Uint` is also a problem: it has poor behavior when overflowing and should be avoided for general purpose programming.
        1. If you need binary data, `unsigned int` or `unsigned char` are fine, but you should probably use `std::bitset` instead.
    3. `float` is to be avoided, but it has valid uses.
2. Almost Always Avoid Auto. Auto has two uses; others should be avoided.
    1. Aliasing for extremely long iterator or functional declarations.
    2. Generic code support (but `decltype` is better).
3. Avoid using declaration for standard namespaces.
4. Keep lambda small or avoid them. There should be no substantial logic in lambdas.
    1. If you need code reuse, hoist the code to a helper function or method.
    2. Avoid implicit capture ( [&] or [=] ).
