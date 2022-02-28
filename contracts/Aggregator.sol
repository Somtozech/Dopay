pragma solidity ^0.8.0;
import "./Oracle.sol";

contract Aggregator is Oracle {
    uint256 public ethPriceUSD;

    function callback(uint256 _price) public override {
        ethPriceUSD = _price;
    }

    function getLatestPrice() public returns (uint256) {
        return ethPriceUSD;
}
