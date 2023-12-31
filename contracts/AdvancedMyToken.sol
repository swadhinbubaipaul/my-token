// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract AdvancedMyToken is ERC20, Ownable {
    using Address for address payable;

    address private immutable _feeReceiver;
    IUniswapV2Router02 private immutable _router;
    address private immutable _weth9;
    bool public _tradingStatus = false;

    constructor(
        address feeReceiver_,
        address router_
    ) ERC20("AdvancedMyToken", "AMT") {
        _mint(msg.sender, 10000000000000000000 * 10 ** decimals());
        _feeReceiver = feeReceiver_;
        _router = IUniswapV2Router02(router_);
        _weth9 = _router.WETH();
    }

    function enableDisableTrading() external onlyOwner {
        _tradingStatus = !_tradingStatus;
    }

    function _transfer(
        address sender_,
        address recipient_,
        uint256 amount_
    ) internal virtual override {
        if (sender_ == address(this) || !_tradingStatus) {
            super._transfer(sender_, recipient_, amount_);
        } else {
            uint fee = (amount_ / 100) * 5; // 5% fee
            uint amt = amount_ - fee;

            super._transfer(sender_, address(this), fee);

            super._transfer(sender_, recipient_, amt);
        }
    }

    function _distributeFee() external {
        uint amount = balanceOf(address(this));
        require(amount > 0, "Nothing to distribute");
        _swapTokensForETH(amount);
    }

    function _swapTokensForETH(uint256 amount_) internal {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = _weth9;
        _approve(address(this), address(_router), amount_);
        _router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            amount_,
            0,
            path,
            _feeReceiver,
            block.timestamp + 3600
        );
    }
}
