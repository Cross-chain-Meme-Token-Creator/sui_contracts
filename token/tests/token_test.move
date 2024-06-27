#[test_only]
module token::token_test {
    //libraries
    use token::token::{ Self };

    #[test]
    public fun test_mint(ctx: &mut TxContext) {
        token::init_for_testing(ctx);
    }
}

