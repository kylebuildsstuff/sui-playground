module contracts::groovy;

use std::string::{Self, String};
use sui::event::{Self};

public struct Yes has copy, drop {
    answer: bool,
}

public struct Thing has copy, drop {
    a: u8,
    b: u8,
}

public struct Thing2 has copy {
    a: u8,
    b: u8,
}

// Works
entry fun compare_strings(s1: String, ctx: &mut TxContext) {
    let s2 = string::utf8(b"Hello, World!");

    event::emit(Yes {
        answer: s2 == s1,
    })
}

// Works
entry fun compare_instances(ctx: &mut TxContext) {
    let o1 = Thing {
        a: 1,
        b: 2,
    };

    let o2 = Thing {
        a: 1,
        b: 2,
    };

    event::emit(Yes {
        answer: o1 == o2,
    })
}

// Works
entry fun compare_instances_no_drop(ctx: &mut TxContext) {
    let o1 = Thing2 {
        a: 1,
        b: 2,
    };

    let o2 = Thing2 {
        a: 1,
        b: 2,
    };

    event::emit(Yes {
        answer: &o1 == &o2,
    });

    let Thing2 { a: _, b: _ } = o1;
    let Thing2 { a: _, b: _ } = o2;

}
