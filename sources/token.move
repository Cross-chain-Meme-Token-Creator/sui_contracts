module sui_contracts::token {
    use sui::url::{ Self, Url };
    use sui::coin::{ Self };
    use sui::address::{ Self };

    public struct TOKEN has drop {}

    fun init(witness: TOKEN, ctx: &mut TxContext) {
        let template_decimal: u8 = 8;
        let template_name: vector<u8> = b"UST Tether";
        let template_symbol: vector<u8> = b"USDT";
        let template_description: vector<u8> = b"";
        let template_icon_url: vector<u8> = b"";
        let template_total_supply: u64 = 10000000000;

        let icon_url : Option<Url>;
        if (vector::is_empty(&template_icon_url)) {
            icon_url = option::none();
        } else {
            icon_url = option::some(url::new_unsafe_from_bytes(template_icon_url));
        };

        let (mut treasuryCap, metadata) = coin::create_currency( 
        witness,
        template_decimal, 
        template_name, 
        template_symbol, 
        template_description, 
        icon_url, 
        ctx
        );

        transfer::public_freeze_object(metadata);
        
        coin::mint_and_transfer(&mut treasuryCap, template_total_supply, tx_context::sender(ctx), ctx);
        transfer::public_transfer(treasuryCap, address::from_u256(0));
    }
}

