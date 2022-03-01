// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Oracle is Ownable {
    uint256 public constant EXPIRY_TIME = 5 minutes;
    uint256 private randomNonce = 0;
    mapping(uint256 => bytes32) pendingRequests;

    event OracleRequest(uint256 indexed id, address sender, uint256 expiration);

    function oracleRequest(address _sender) public {
        randomNonce++;

        // generate random number
        uint256 id = uint256(
            keccak256(
                abi.encodePacked(block.timestamp, msg.sender, randomNonce)
            )
        ) % 1000;
        uint256 expiration = block.timestamp + EXPIRY_TIME;
        bytes32 hash = keccak256(abi.encodePacked(id, _sender, expiration));
        pendingRequests[id] = hash;

        emit OracleRequest(id, _sender, expiration);
    }

    function fulfillOracleRequest(
        uint256 _id,
        address _sender,
        uint256 _expiration,
        uint256 _data
    ) public onlyOwner {
        bytes32 hash = keccak256(abi.encodePacked(_id, _sender, _expiration));

        require(hash == pendingRequests[_id], "Params dosen't match");
        delete pendingRequests[_id];

        callback(_data);
    }

    function callback(uint256 _data) internal virtual returns (uint256) {
        return _data;
    }
}
