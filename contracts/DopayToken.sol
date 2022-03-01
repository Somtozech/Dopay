pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

interface AggregatorInterface {
    function getLatestPrice() external view returns (uint256);
}

contract DopayToken is ERC20, Ownable {
    using SafeMath for uint256;

    uint256 public constant INITIAL_SUPPLY = 100000 * 10**18;
    // token price in USD
    uint256 public constant TOKEN_PRICE = 10;

    address private aggregatorAddress;
    AggregatorInterface internal aggregator;

    constructor(address _aggregatorAddress) ERC20("DopayToken", "Dopay") {
        aggregatorAddress = _aggregatorAddress;
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function setAggregatorAddress(address _aggregatorAddress) public onlyOwner {
        aggregatorAddress = _aggregatorAddress;
    }

    function swapToken(uint256 amount) external payable {
        uint256 ethPriceUSD = aggregator.getLatestPrice();
        uint256 amountToSwap = ethPriceUSD.div(TOKEN_PRICE);
        require(amount >= amountToSwap, "Amount less than current value");

        _transfer(owner(), msg.sender, amountToSwap);
    }
}
