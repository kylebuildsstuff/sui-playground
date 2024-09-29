module contracts::contracts;

use sui::object_bag::{Self, ObjectBag};

public struct Hero has key, store {
    id: UID,
    level: u8,
    army: ObjectBag
}

public struct Swordsman has key, store {
    id: UID,
    tier: u8,
    quantity: u8,
    attack: u8,
    defence:u8,
    health: u8,
    initiative: u8
}

public struct Archer has key, store {
    id: UID,
    tier: u8,
    quantity: u8,
    attack: u8,
    defence:u8,
    health: u8,
    initiative: u8
}

public struct Cavalier has key, store {
    id: UID,
    tier: u8,
    quantity: u8,
    attack: u8,
    defence:u8,
    health: u8,
    initiative: u8
}

public struct Angel has key, store {
    id: UID,
    tier: u8,
    quantity: u8,
    attack: u8,
    defence:u8,
    health: u8,
    initiative: u8
}

public fun new_hero(ctx: &mut TxContext): Hero {
    let army = object_bag::new(ctx);

    Hero { id: object::new(ctx), level: 1, army }
}

public fun add_swordsman(hero: &mut Hero, ctx: &mut TxContext) {
    let swordsman = Swordsman { id: object::new(ctx), tier: 1, quantity: 1, attack: 1, defence: 1, health: 1, initiative: 1 };

    object_bag::add(&mut hero.army, 1, swordsman);
}

public fun army(hero: &Hero): &ObjectBag {
    // Doesn't work... can't return a field of an object like this.
    // Need to return something bigger, and then parse that out, like dynamic fields
    &hero.army
}
