module contracts::suiscape;

use std::string::{Self, String};
use sui::object_bag::{Self, ObjectBag};

public struct Hero has key, store {
    id: UID,
    level: u8,
    army: vector<ArmyUnit>,
    battle_history: vector<BattleHistory>,
    resources: Resources
}

public struct Resources has store {
    wood: u8,
    stone: u8,
    ore: u8,
    water: u8,
    food: u8,
}

public struct BattleHistory has store {
    texts: vector<String>,
    numbers: vector<u8>
}

public struct ArmyUnit has key, store {
    id: UID,
    tier: u8,
    quantity: u8,
    name: String,
    attack: u8,
    defence: u8,
    health: u8,
    initiative: u8,
}

public struct Unit has key, store {
    id: UID,
    name: String,
}

public fun match_or_not(is_bool: bool, ctx: &mut TxContext): Unit { 
    match (is_bool) {
        true => Unit { id: object::new(ctx), name: string::utf8(b"Swordsman") },
        false => Unit { id: object::new(ctx), name: string::utf8(b"Archer") },
    }
}

// public fun match_or_not_2(numby: u64, ctx: &mut TxContext): Unit { 
//     match (numby) {
//         20 => Unit { id: object::new(ctx), name: string::utf8(b"Swordsman") },
//         40 => Unit { id: object::new(ctx), name: string::utf8(b"Archer") },
//     } 
// }

public fun new_hero(ctx: &mut TxContext): Hero {
    let hero = Hero {
        id: object::new(ctx),
        level: 1,
        army: vector::empty<ArmyUnit>(),
        battle_history: vector::empty<BattleHistory>(),
        resources: Resources {
            wood: 0,
            stone: 0,
            ore: 0,
            water: 0,
            food: 0,
        }
    };

    hero
}

public fun add_swordsman(hero: &mut Hero, ctx: &mut TxContext) {
    let swordsman = ArmyUnit { 
        id: object::new(ctx),
        tier: 1,
        quantity: 2, 
        name: string::utf8(b"Swordsman"),
        attack: 1,
        defence: 1,
        health: 3,
        initiative: 1,
    };

    hero.army.push_back(swordsman);
}

public fun battle(hero: &mut Hero, ctx: &mut TxContext) {  
    let army = &mut hero.army;

    let mut enemy_army = vector[ArmyUnit {
        id: object::new(ctx),
        tier: 1,
        quantity: 1, 
        name: string::utf8(b"Swordsman"),
        attack: 1,
        defence: 1,
        health: 3,  
        initiative: 1,
    }];

    let mut is_fighting = true;
    let mut battle_messages = vector::empty<String>();
    let mut battle_numbers = vector::empty<u8>();

    while (is_fighting) {
        let attacker = vector::pop_back(army);
        let mut defender: ArmyUnit = vector::pop_back(&mut enemy_army);

        let attacker_damage = attacker.attack - defender.defence / 2;
        defender.health = defender.health - attacker_damage;

        vector::push_back(&mut battle_messages, attacker.name);
        vector::push_back(&mut battle_numbers, attacker_damage);
        
        if (defender.health <= 0) {
            is_fighting = false;

            let ArmyUnit { 
                id: defender_id, 
                tier: _, 
                quantity: _, 
                name: _, 
                attack: _, 
                defence: _, 
                health: _, 
                initiative: _,  
            } = defender;
            object::delete(defender_id);
            vector::push_back(army, attacker);

        } else {
          vector::push_back(army, attacker);
          vector::push_back(&mut enemy_army, defender);
        }
    };

    enemy_army.destroy_empty();

    let what_happened = BattleHistory {
        texts: battle_messages,
        numbers: battle_numbers,
    };

    hero.battle_history.push_back(what_happened);
}

// How about returning any field on object? plain vector? plain int?

// public fun army(hero: &Hero): &ObjectBag {
//     // Doesn't work... can't return a field of an object like this.
//     // Need to return something bigger, and then parse that out, like dynamic fields
//     &hero.army
// }
