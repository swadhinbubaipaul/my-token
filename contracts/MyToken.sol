// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    address public feeWallet;
    uint256 public feePercentage;

    event FeeConverted(address indexed wallet, uint256 amount);

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        address _feeWallet,
        uint256 _feePercentage
    ) ERC20(_name, _symbol) {
        feeWallet = _feeWallet;
        feePercentage = _feePercentage;

        _mint(msg.sender, _totalSupply);
    }

    function buyTokens() external payable {
        require(msg.value > 0, "Insufficient ETH sent");
        uint256 feeAmount = (msg.value * feePercentage) / 100;
        uint256 transferAmount = msg.value - feeAmount;

        _mint(msg.sender, transferAmount);
        _transfer(msg.sender, feeWallet, feeAmount);
    }

    function sellTokens(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        uint256 feeAmount = (amount * feePercentage) / 100;
        uint256 transferAmount = amount - feeAmount;

        _burn(msg.sender, transferAmount);
        _transfer(msg.sender, feeWallet, feeAmount);

        payable(msg.sender).transfer(transferAmount);
    }

    function setFeeWallet(address _feeWallet) external onlyOwner {
        require(_feeWallet != address(0), "Invalid fee wallet address");

        feeWallet = _feeWallet;
    }

    function setFeePercentage(uint256 _feePercentage) external onlyOwner {
        feePercentage = _feePercentage;
    }

    function convertFees(address treasuryAddress) external onlyOwner {
        uint256 feeBalance = balanceOf(feeWallet);
        require(feeBalance > 0, "No fees to convert");

        _burn(feeWallet, feeBalance);
        emit FeeConverted(feeWallet, feeBalance);

        payable(treasuryAddress).transfer(feeBalance);
    }

    function checkContractEthBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
