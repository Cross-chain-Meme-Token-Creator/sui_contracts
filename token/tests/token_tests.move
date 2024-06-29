#[test_only]
module token::token_tests {
    //libraries
    use sui::test_scenario::{ Self };
    use sui::coin::{ Coin };
    use token::token::{ Self, TOKEN };

    //templates
    const TEMPLATE_TOTAL_SUPPLY: u64 = 10000000000000000;

    //tests
    #[test]
    public fun test_init() {
        let sender = @0xcafe;
        let checker = @0xc0ffee;
        let mut scenario = test_scenario::begin(sender);
        {
            token::init_for_testing(scenario.ctx());         
        };
        scenario.next_tx(checker);
        {
            let coin = scenario.take_from_address<Coin<TOKEN>>(sender);
            assert!(coin.value() == TEMPLATE_TOTAL_SUPPLY);
            test_scenario::return_to_address(sender, coin);
        };
        scenario.end();
    }
}

