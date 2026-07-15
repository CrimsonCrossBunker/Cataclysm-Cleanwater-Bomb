#include <memory>

#include "render_backend.h"

#if !defined(TILES)

namespace
{

class null_render_backend : public render_backend
{
    public:
        bool present() override {
            // Headless / server: rendering is a no-op.  The simulation
            // produces view_snapshot but nothing consumes it.
            return true;
        }

        void resize( int, int ) override {}

        void flush() override {}

        const char *name() const override {
            return "null";
        }
};

} // namespace

std::unique_ptr<render_backend> create_render_backend()
{
    return std::make_unique<null_render_backend>();
}

#endif // !TILES
