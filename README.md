# MyToken Contract

## Overview

The `MyToken` contract is an ERC20 token contract that allows users to buy and sell tokens. It includes functionality for setting a fee wallet and fee percentage, converting fees to ETH, and checking the contract's ETH balance.

## Contract Details

- SPDX-License-Identifier: MIT
- Solidity Version: ^0.8.0
- Imports:
  - `ERC20` from "@openzeppelin/contracts/token/ERC20/ERC20.sol"
  - `Ownable` from "@openzeppelin/contracts/access/Ownable.sol"

## Contract Structure

The `MyToken` contract inherits from `ERC20` and `Ownable`, making it an ERC20 token contract with additional ownership functionality.

### State Variables

- `feeWallet`: The address of the wallet where fees are transferred to.
- `feePercentage`: The percentage of fees charged on token transfers.

### Events

- `FeeConverted(address indexed wallet, uint256 amount)`: Triggered when fees are converted to ETH.

### Constructor

The constructor initializes the token with the specified name, symbol, total supply, fee wallet address, and fee percentage. It also mints the total supply of tokens to the contract deployer.

### Functions

- `buyTokens()`: Allows users to buy tokens by sending ETH to the contract.
- `sellTokens(uint256 amount)`: Allows users to sell tokens and receive ETH in return.
- `setFeeWallet(address _feeWallet)`: Sets the fee wallet address.
- `setFeePercentage(uint256 _feePercentage)`: Sets the fee percentage.
- `convertFees(address treasuryAddress)`: Converts fees to ETH and transfers them to the specified treasury address.
- `checkContractEthBalance()`: Returns the current ETH balance of the contract.

## Usage

1. Deploy the `MyToken` contract, providing the required constructor parameters.
2. Set the fee wallet address and fee percentage using the `setFeeWallet` and `setFeePercentage` functions, respectively.
3. Users can buy tokens by calling the `buyTokens` function and sending ETH to the contract.
4. Users can sell tokens by calling the `sellTokens` function and specifying the amount of tokens to sell.
5. The contract owner can convert fees to ETH by calling the `convertFees` function and specifying the treasury address.
6. The contract owner can check the current ETH balance of the contract by calling the `checkContractEthBalance` function.

## Contract deployed to mumbai testnet:

Contract address: 0xDCD3B39F7e6E56f3205b7609E672Ae0Eb2c19cb2

Link: https://mumbai.polygonscan.com/address/0xDCD3B39F7e6E56f3205b7609E672Ae0Eb2c19cb2
