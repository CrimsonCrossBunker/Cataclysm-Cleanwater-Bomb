#pragma once
#ifndef CATA_SRC_EVENT_SUBSCRIBER_H
#define CATA_SRC_EVENT_SUBSCRIBER_H

#include <memory>

namespace cata
{
class event;
}  // namespace cata
class damage_event_participants;
class event_bus;
class talker;

class event_subscriber
{
    public:
        event_subscriber() = default;
        event_subscriber( const event_subscriber & ) = delete;
        event_subscriber &operator=( const event_subscriber & ) = delete;
        virtual ~event_subscriber();
        virtual bool needs_talker() const {
            return true;
        }
        virtual void notify( const cata::event & ) = 0;
        virtual void notify( const cata::event &, std::unique_ptr<talker>, std::unique_ptr<talker> );
        // Explicit damage participants are borrowed for this call. The default
        // delivers only event data when the target is no longer available.
        virtual void notify_character_damage( const cata::event &, const damage_event_participants & );
    private:
        friend class event_bus;
        void on_subscribe( event_bus * );
        void on_unsubscribe( event_bus * );
        event_bus *subscribed_to = nullptr;
};

#endif // CATA_SRC_EVENT_SUBSCRIBER_H
