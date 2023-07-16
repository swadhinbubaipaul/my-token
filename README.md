# MyToken Contract

## MyToken Contract

### Overview

The `MyToken` contract is an ERC20 token contract that allows users to buy and sell tokens. It implements a fee mechanism where a percentage of each transaction is deducted as a fee and transferred to a designated fee wallet. The contract also provides functions to set the fee wallet address and fee percentage, as well as convert the accumulated fees to ETH and transfer them to a treasury address.

### Contract Details

- SPDX-License-Identifier: MIT
- Solidity Version: ^0.8.0
- Imports:
  - `@openzeppelin/contracts/token/ERC20/ERC20.sol`
  - `@openzeppelin/contracts/access/Ownable.sol`

### Contract Functions

- `constructor(string memory _name, string memory _symbol, uint256 _totalSupply, address _feeWallet, uint256 _feePercentage)`: Initializes the token contract with the specified parameters.
- `buyTokens() external payable`: Allows users to buy tokens by sending ETH to the contract.
- `sellTokens(uint256 amount) external`: Allows users to sell a specified amount of tokens.
- `setFeeWallet(address _feeWallet) external onlyOwner`: Sets the fee wallet address.
- `setFeePercentage(uint256 _feePercentage) external onlyOwner`: Sets the fee percentage.
- `convertFees(address treasuryAddress) external onlyOwner`: Converts the accumulated fees to ETH and transfers them to a treasury address.
- `checkContractEthBalance() external view returns (uint256)`: Returns the current ETH balance of the contract.

## AdvancedMyToken Contract

### Overview

The `AdvancedMyToken` contract is an ERC20 token contract that implements an advanced decentralized exchange (DEX) mechanism. It allows users to trade tokens and charges a 5% fee on each transaction. The fee is distributed to the contract itself, and owner converts the accumulated fees to ETH and transfers them to a designated fee receiver address.

### Contract Details

- SPDX-License-Identifier: MIT
- Solidity Version: ^0.8.9
- Imports:
  - `@openzeppelin/contracts/utils/Address.sol`
  - `@openzeppelin/contracts/token/ERC20/ERC20.sol`
  - `@openzeppelin/contracts/access/Ownable.sol`
  - `@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol`

### Contract Functions

- `constructor(address feeReceiver_, address router_)`: Initializes the token contract with the specified fee receiver address and Uniswap V2 router address.
- `enableDisableTrading() external onlyOwner`: Allows the contract owner to enable/disable trading of the token.
- `_transfer(address sender_, address recipient_, uint256 amount_) internal virtual override`: Handles the transfer of tokens between addresses.
- `_distributeFee() internal nonReentrant`: Distributes the accumulated fees by swapping tokens for ETH and transferring them to the fee receiver address.
- `_swapTokensForETH(uint256 amount_) internal`: Swaps the specified amount of tokens for ETH using the Uniswap V2 router.

## Usage

To use the `MyToken` contract, follow these steps:

1. Deploy the contract by providing the required constructor parameters: name, symbol, total supply, fee wallet address, and fee percentage.
2. Call the `buyTokens` function and send ETH to the contract to purchase tokens.
3. Call the `sellTokens` function to sell a specified amount of tokens and receive ETH in return.
4. Use the `setFeeWallet` function to set the fee wallet address.
5. Use the `setFeePercentage` function to set the fee percentage.
6. Call the `convertFees` function to convert the accumulated fees to ETH and transfer them to a treasury address.
7. Use the `checkContractEthBalance` function to check the current ETH balance of the contract.

To use the `AdvancedMyToken` contract, follow these steps:

1. Deploy the contract by providing the required constructor parameters: fee receiver address and Uniswap V2 router address.
2. Call the `enableTrading` function to enable trading of the token.
3. Transfer tokens between addresses using the regular ERC20 transfer functions.
4. The contract will automatically deduct a 5% fee on each transaction and distribute the accumulated fees.
5. Convert the accumulated fees to ETH using the Uniswap V2 router and transfer them to the fee receiver address.

## Contract deployed to Goerli testnet:

MyToken Contract address: 0x8A42AF05734B79C6493eA0B0243A0De5E8F0Ab95

Link: https://goerli.etherscan.io/address/0x8A42AF05734B79C6493eA0B0243A0De5E8F0Ab95

AdvancedMyToken Contract address: 0xD3411184789A71207148DFd265d7C9FDaB770808

Link: https://goerli.etherscan.io/address/0xD3411184789A71207148DFd265d7C9FDaB770808
