#[test_only]
module token::token_test {
    //libraries
    use sui::test_scenario::{ Self };
    use sui::coin::{ Coin };
    use token::token::{ Self, TOKEN };

    //templates
    const TEMPLATE_TOTAL_SUPPLY: u64 = 10000000000000000;

    //tests
    #[test]
    public fun test_mint() {
        let sender = @0xcafe;
        let mut scenario = test_scenario::begin(sender);
        {
            token::init_for_testing(scenario.ctx());         
        };
        scenario.next_tx(sender);
        {
            let coin = scenario.take_from_sender<Coin<TOKEN>>();
            assert!(coin.value() == TEMPLATE_TOTAL_SUPPLY);
            scenario.return_to_sender(coin);
        };
        scenario.end();
    }
}

