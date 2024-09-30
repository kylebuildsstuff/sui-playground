module contracts::contracts;

use std::string::{Self, String};
use sui::object_bag::{Self, ObjectBag};

public struct Hero has key, store {
    id: UID,
    level: u8,
    // army: ObjectBag
    army: vector<ArmyUnit>
}

public struct ArmyUnit has key, store {
    id: UID,
    tier: u8,
    quantity: u8,
    name: String,
    attack: u8,
    defence:u8,
    health: u8,
    initiative: u8
}

public fun new_hero(ctx: &mut TxContext): Hero {
    let hero = Hero {
        id: object::new(ctx),
        level: 1,
        army: vector::empty<ArmyUnit>()
    };

    hero
}

public fun add_swordsman(hero: &mut Hero, ctx: &mut TxContext) {
    let swordsman = ArmyUnit { id: object::new(ctx), tier: 1, quantity: 1, 
    name: string::utf8(b"Swordsman"),
    attack: 1, defence: 1, health: 1, initiative: 1 };

    hero.army.push_back(swordsman);
}

public fun army(hero: &Hero): &vector<ArmyUnit> {
    // doesn't work, still can't return field of an object with vector
    &hero.army  
}

public fun some_vector(): vector<u8> {
    let v = vector<u8>[1, 2, 3];

    v
}

public fun level(hero: &Hero): u8 {
    hero.level
}

// How about returning any field on object? plain vector? plain int?

// public fun army(hero: &Hero): &ObjectBag {
//     // Doesn't work... can't return a field of an object like this.
//     // Need to return something bigger, and then parse that out, like dynamic fields
//     &hero.army
// }
