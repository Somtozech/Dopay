pragma solidity ^0.8.0;
import "./Oracle.sol";

contract Aggregator is Oracle {
    uint256 public ethPriceUSD;

    function callback(uint256 _price) internal override {
        ethPriceUSD = _price;
    }

    function getLatestPrice() external view returns (uint256) {
        return ethPriceUSD;
}
