#pragma once
#ifndef CATA_SRC_KILL_TRACKER_H
#define CATA_SRC_KILL_TRACKER_H

#include "event_subscriber.h"
#include "kill_statistics.h"

// The world subscribes once. Characters own the statistics; replicas do not
// collect gameplay events or replay kill rewards when loading a snapshot.
class kill_tracker : public event_subscriber
{
    public:
        using event_subscriber::notify;
        void notify( const cata::event &event ) override;
};

#endif // CATA_SRC_KILL_TRACKER_H
