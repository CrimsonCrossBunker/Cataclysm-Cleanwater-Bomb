// RUN: %check_clang_tidy -std=c++14-or-later %s cata-redundant-parentheses %t -- --load=%cata_plugin -- -isystem %cata_include

int value;

struct record {
    int member;
};

record instance;

decltype( auto ) named_reference()
{
    return ( value );
    // CHECK-FIXES: return ( value );
}

decltype( auto ) member_reference( record &object )
{
    return ( object.member );
    // CHECK-FIXES: return ( object.member );
}

void lambda_reference( record &object )
{
    auto get_member = [&object]() -> decltype( auto ) {
        return ( object.member );
        // CHECK-FIXES: return ( object.member );
    };
    static_assert( __is_same( decltype( get_member() ), int & ), "member reference" );
}

static_assert( __is_same( decltype( named_reference() ), int & ), "named reference" );
static_assert( __is_same( decltype( member_reference( instance ) ), int & ), "member reference" );

int ordinary_return()
{
    return ( value );
    // CHECK-MESSAGES: [[@LINE-1]]:12: warning: Redundant parentheses. [cata-redundant-parentheses]
    // CHECK-FIXES: return value;
}

decltype( auto ) call_reference()
{
    return ( named_reference() );
    // CHECK-MESSAGES: [[@LINE-1]]:12: warning: Redundant parentheses. [cata-redundant-parentheses]
    // CHECK-FIXES: return named_reference();
}
