// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Oracle.sol";

contract Aggregator is Oracle {
    uint256 public ethPriceUSD;

    function callback(uint256 _price) internal override returns (uint256) {
        ethPriceUSD = _price;
        return ethPriceUSD;
    }

    function getLatestPrice() external view returns (uint256) {
        return ethPriceUSD;
    }
}
