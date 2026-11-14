#include "thread_pool.h"

#include <functional>
#include <thread>


static thread_local bool tl_is_worker_thread = false;

bool is_pool_worker_thread()
{
    return tl_is_worker_thread;
}

cata_thread_pool::cata_thread_pool( unsigned int num_workers, std::size_t queue_limit,
                                    void ( *worker_init )() ) :
    queue_limit_( queue_limit ), worker_init_( worker_init )
{
    workers_.reserve( num_workers );
    try {
        for( unsigned int i = 0; i < num_workers; ++i ) {
            workers_.emplace_back( [this]() {
                worker_loop();
            } );
        }
    } catch( ... ) {
        // A later thread creation may fail after earlier workers started. Stop
        // and join them before unwinding their joinable std::thread objects.
        {
            std::scoped_lock lock( mutex_ );
            stop_ = true;
        }
        cv_.notify_all();
        for( std::thread &worker : workers_ ) {
            worker.join();
        }
        throw;
    }
}

cata_thread_pool::~cata_thread_pool()
{
    {
        std::scoped_lock lock( mutex_ );
        stop_ = true;
    }
    cv_.notify_all();
    for( std::thread &worker : workers_ ) {
        worker.join();
    }
}

void cata_thread_pool::worker_loop()
{
    tl_is_worker_thread = true;
    if( worker_init_ ) {
        worker_init_();
    }

    while( true ) {
        std::function<void()> task;
        {
            std::unique_lock<std::mutex> lock( mutex_ );
            cv_.wait( lock, [this]() {
                return stop_ || !queue_.empty();
            } );
            if( stop_ && queue_.empty() ) {
                return;
            }
            task = std::move( queue_.front() );
            queue_.pop_front();
        }
        task();
    }
}

void cata_thread_pool::submit( std::function<void()> task )
{
    // Nested dispatch is synchronous: a worker must never wait for another
    // task in a saturated pool. Saturation also applies backpressure on owners
    // without retaining an unbounded number of captured values in the queue.
    if( num_workers() != 0 && !is_pool_worker_thread() ) {
        std::unique_lock<std::mutex> lock( mutex_ );
        if( queue_.size() < queue_limit_ ) {
            queue_.push_back( std::move( task ) );
            lock.unlock();
            cv_.notify_one();
            return;
        }
    }
    task();
}
