#[abi]
trait IHello2 {
    #[view]
    fn get_number() -> felt252;
}

#[contract]
mod HelloStarknet {
    // use starknet::ContractAddress;
    // use super::IHello2Dispatcher;
    // use super::IHello2DispatcherTrait;

    struct Storage {
        balance: felt252,
        //hello_addr: ContractAddress,
    }

    // #[constructor]
    // fn constructor(
    //     hello_addr_: ContractAddress
    // ) {
    //     hello_addr::write(hello_addr_);
    // }

    #[constructor]
    fn constructor(
        balance_init_: felt252
    ) {
        balance::write(balance_init_);
    }

    // Increases the balance by the given amount.
    #[external]
    fn increase_balance(amount: felt252) {
        assert(amount != 0, 'Amount cannot be 0');
        // let v = IHello2Dispatcher { contract_address: hello_addr::read() }.get_number();
        //balance::write(balance::read() + amount + v);
        balance::write(balance::read() + amount);
    }

    // Returns the current balance.
    #[view]
    fn get_balance() -> felt252 {
        balance::read()
    }

    // Calls a function defined in outside module
    #[view]
    fn get_two() -> felt252 {
        hello_starknet::business_logic::utils::returns_two()
    }
}
