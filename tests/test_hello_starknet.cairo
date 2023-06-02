use array::ArrayTrait;
use result::ResultTrait;
use debug::PrintTrait;

#[test]
fn test_increase_balance() {
    let hello_address = deploy_contract('hello2', @ArrayTrait::new()).unwrap();

    let mut hello_args = ArrayTrait::new();
    hello_args.append(1);
    //hello_args.append(hello_address.try_into().unwrap());

    let contract_address = deploy_contract('hello_starknet', @hello_args).unwrap();

    let result_before = call(contract_address, 'get_balance', @ArrayTrait::new()).unwrap();
    assert(*result_before.at(0_u32) == 1, 'Invalid balance');

    let mut invoke_calldata = ArrayTrait::new();
    invoke_calldata.append(10);
    invoke(contract_address, 'increase_balance', @invoke_calldata).unwrap();

    let result_after = call(contract_address, 'get_balance', @ArrayTrait::new()).unwrap();
    assert(*result_after.at(0_u32) == 11, 'Invalid balance');
}

#[test]
fn test_cannot_increase_balance_with_zero_value() {
    let mut hello_args = ArrayTrait::new();
    hello_args.append(1);

    let contract_address = deploy_contract('hello_starknet', @hello_args).unwrap();

    let result_before = call(contract_address, 'get_balance', @ArrayTrait::new()).unwrap();
    assert(*result_before.at(0_u32) == 1, 'Invalid balance');

    let mut invoke_calldata = ArrayTrait::new();
    invoke_calldata.append(0);
    let invoke_result = invoke(contract_address, 'increase_balance', @invoke_calldata);

    assert(invoke_result.is_err(), 'Invoke should fail');
}
