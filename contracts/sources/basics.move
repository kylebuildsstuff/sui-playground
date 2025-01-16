module contracts::basics;

use std::string::{Self, String};
use sui::object_table::{Self, ObjectTable};
use sui::transfer;

public struct Listings has key, store {
    id: UID,
    table: ObjectTable<String, Listing>,
}

public struct Listing has key, store {
    id: UID,
    name: String,
    description: String,
}

fun init(ctx: &mut TxContext) {
    let mut table = object_table::new(ctx);

    let row_key_one = string::utf8(b"row_key_one");
    let row_key_two = string::utf8(b"row_key_two");
    let row_key_three = string::utf8(b"row_key_three");

    let listing_one = Listing {
        id: object::new(ctx),
        name: string::utf8(b"Listing One"),
        description: string::utf8(b"This is a listing"),
    };

    let listing_two = Listing {
        id: object::new(ctx),
        name: string::utf8(b"Listing Two"),
        description: string::utf8(b"This is a listing"),
    };

    let listing_three = Listing {
        id: object::new(ctx),
        name: string::utf8(b"Listing Three"),
        description: string::utf8(b"This is a listing"),
    };

    object_table::add(
        &mut table,
        row_key_one,
        listing_one,
    );

    object_table::add(
        &mut table,
        row_key_two,
        listing_two,
    );

    object_table::add(
        &mut table,
        row_key_three,
        listing_three,
    );

    let listings = Listings {
        id: object::new(ctx),
        table,
    };

    transfer::share_object(listings);
}
