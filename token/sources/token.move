module token::token {
    //libraries
    use sui::url::{ Self };
    use sui::coin::{ Self };
    
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
        let template_icon_url = TEMPLATE_ICON_URL;
        let icon_url = if (vector::is_empty(&template_icon_url)) {
            option::none()
        } else {
            option::some(url::new_unsafe_from_bytes(template_icon_url))
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

        coin::mint_and_transfer(&mut treasury_cap, TEMPLATE_TOTAL_SUPPLY, tx_context::sender(ctx), ctx);

        transfer::public_freeze_object(metadata);
        transfer::public_freeze_object(treasury_cap);
    }

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        token::init(TOKEN {}, ctx);
    }
}

