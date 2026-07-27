#ifndef CATA_SRC_ANDROID_UI_MODE_H
#define CATA_SRC_ANDROID_UI_MODE_H

namespace android_ui_mode
{

constexpr bool is_new_ui_build()
{
#if defined(__ANDROID__) && defined(CCB_ANDROID_NEW_UI) && CCB_ANDROID_NEW_UI
    return true;
#else
    return false;
#endif
}

} // namespace android_ui_mode

#endif // CATA_SRC_ANDROID_UI_MODE_H
