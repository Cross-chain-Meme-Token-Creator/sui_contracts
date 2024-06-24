module token::token {
    //libraries
    use sui::url::{ Self, Url };
    use sui::coin::{ Self };
    use sui::address::{ Self };
    
    //structs
    public struct TOKEN has drop {}

    //constants
    const TEMPLATE_NAME: vector<u8> = b"UST Tether";
    const TEMPLATE_SYMBOL: vector<u8> = b"USDT";
    const TEMPLATE_DECIMALS: u8 = 8;
    const TEMPLATE_DESCRIPTION: vector<u8> = b"";
    const TEMPLATE_ICON_URL: vector<u8> = b"";
    const TEMPLATE_TOTAL_SUPPLY: u64 = 10000000000000000;

    //implements
    fun init(witness: TOKEN, ctx: &mut TxContext) {
        let icon_url : Option<Url>;
        let template_icon_url = TEMPLATE_ICON_URL;
        if (vector::is_empty(&template_icon_url)) {
            icon_url = option::none();
        } else {
            icon_url = option::some(url::new_unsafe_from_bytes(template_icon_url));
        };

        let (mut treasury_cap, metadata) = coin::create_currency( 
        witness,
        TEMPLATE_DECIMALS, 
        TEMPLATE_NAME, 
        TEMPLATE_SYMBOL, 
        TEMPLATE_DESCRIPTION, 
        icon_url, 
        ctx
        );

        transfer::public_freeze_object(metadata);
        
        coin::mint_and_transfer(&mut treasury_cap, TEMPLATE_TOTAL_SUPPLY, tx_context::sender(ctx), ctx);
        transfer::public_transfer(treasury_cap, address::from_u256(0));
    }
}

