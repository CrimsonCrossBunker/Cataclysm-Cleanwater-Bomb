#pragma once
#ifndef CATA_SRC_BRESENHAM_H
#define CATA_SRC_BRESENHAM_H

#include "coordinates.h"
#include "point.h"

// Same traversal as bresenham(), with a concrete callback for hot 2D scans.
// Excludes the source, includes the destination, and stops when interact returns false.
template<typename Func>
void bresenham_2d( const point_bub_ms &p1, const point_bub_ms &p2, int t, Func &&interact )
{
    // The slope components.
    const point_rel_ms d = p2 - p1;
    // Signs of slope values.
    const point s( ( d.x() > 0 ) - ( d.x() < 0 ), ( d.y() > 0 ) - ( d.y() < 0 ) );
    // Absolute values of slopes x2 to avoid rounding errors.
    const point_rel_ms a = d.abs() * 2;

    point_bub_ms cur = p1;

    if( a.x() == a.y() ) {
        while( cur.x() != p2.x() ) {
            cur.y() += s.y;
            cur.x() += s.x;
            if( !interact( cur ) ) {
                break;
            }
        }
    } else if( a.x() > a.y() ) {
        while( cur.x() != p2.x() ) {
            if( t > 0 ) {
                cur.y() += s.y;
                t -= a.x();
            }
            cur.x() += s.x;
            t += a.y();
            if( !interact( cur ) ) {
                break;
            }
        }
    } else {
        while( cur.y() != p2.y() ) {
            if( t > 0 ) {
                cur.x() += s.x;
                t -= a.y();
            }
            cur.y() += s.y;
            t += a.x();
            if( !interact( cur ) ) {
                break;
            }
        }
    }
}

#endif // CATA_SRC_BRESENHAM_H
