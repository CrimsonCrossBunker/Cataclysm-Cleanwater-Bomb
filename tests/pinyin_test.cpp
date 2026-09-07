#include <map>
#include <string>
#include <utility>

#include "cata_catch.h"
#include "pinyin.h"
#include "third-party/pinyin/pinyin_data.hpp"

TEST_CASE( "pinyin_search_preserves_literal_and_chinese_matching", "[pinyin]" )
{
    CHECK( pinyin::pinyin_match( U"steel hammer", U"hammer" ) );
    CHECK_FALSE( pinyin::pinyin_match( U"steel hammer", U"nail" ) );
    CHECK( pinyin::pinyin_match( U"steel hammer", U"" ) );
    CHECK( pinyin::pinyin_match( U"", U"" ) );
    CHECK_FALSE( pinyin::pinyin_match( U"", U"hammer" ) );
    CHECK( pinyin::pinyin_match( U"молоток", U"молот" ) );
    CHECK_FALSE( pinyin::pinyin_match( U"молоток", U"hammer" ) );
    CHECK( pinyin::pinyin_match( U"钢锤", U"gangchui" ) );
    CHECK( pinyin::pinyin_match( U"steel 钢锤", U"steel gangchui" ) );
    CHECK( pinyin::pinyin_match( U"重", U"zhong" ) );
    CHECK( pinyin::pinyin_match( U"重", U"chong" ) );
    CHECK_FALSE( pinyin::pinyin_match( U"钢锤", U"nail" ) );
}

TEST_CASE( "pinyin_table_has_no_ascii_characters", "[pinyin]" )
{
    // This invariant makes it safe to bypass even index initialization for ASCII.
    for( const auto &entry : pinyin_data ) {
        for( const char32_t ch : entry.second ) {
            REQUIRE( ch > 0x7f );
        }
    }
}
