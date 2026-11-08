#include <cstdint>

#if defined(_WIN32)
    #define TEST_EXPORT __declspec(dllexport)
#else
    #define TEST_EXPORT __attribute__((visibility("default")))
#endif
extern "C" TEST_EXPORT uint32_t ccb_coop_abi_version()
{
    return 2;
}
