#include "android_native_ui.h"

#if defined(__ANDROID__)

#include <jni.h>

#include "sdl_wrappers.h"

std::optional<std::string> android_native_ui::text_input( const std::string &title,
        const std::string &initial_value, int max_length )
{
    JNIEnv *env = static_cast<JNIEnv *>( GetAndroidJNIEnv() );
    jobject activity = static_cast<jobject>( GetAndroidActivity() );
    jclass activity_class = env->GetObjectClass( activity );
    jmethodID get_native_ui = env->GetMethodID( activity_class, "getNativeUI",
                              "()Lcom/crimsoncrossbunker/cataclysmcb/NativeUI;" );
    jobject native_ui = env->CallObjectMethod( activity, get_native_ui );
    jclass native_ui_class = env->GetObjectClass( native_ui );
    jmethodID text_input_method = env->GetMethodID( native_ui_class, "textInput",
                                  "(Ljava/lang/String;Ljava/lang/String;I)Ljava/lang/String;" );
    jstring java_title = env->NewStringUTF( title.c_str() );
    jstring java_initial_value = env->NewStringUTF( initial_value.c_str() );
    jstring java_result = static_cast<jstring>( env->CallObjectMethod(
                              native_ui, text_input_method, java_title, java_initial_value,
                              static_cast<jint>( max_length ) ) );

    std::optional<std::string> result;
    if( java_result != nullptr ) {
        const char *characters = env->GetStringUTFChars( java_result, nullptr );
        if( characters != nullptr ) {
            result = characters;
            env->ReleaseStringUTFChars( java_result, characters );
        }
        env->DeleteLocalRef( java_result );
    }
    env->DeleteLocalRef( java_initial_value );
    env->DeleteLocalRef( java_title );
    env->DeleteLocalRef( native_ui_class );
    env->DeleteLocalRef( native_ui );
    env->DeleteLocalRef( activity_class );
    env->DeleteLocalRef( activity );
    return result;
}

#endif
