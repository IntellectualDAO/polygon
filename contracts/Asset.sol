//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Shares in a physical item
contract Intellectual is ERC721, Ownable {

    uint8 public immutable v;
    bytes32 public immutable r;
    bytes32 public immutable s;
    address public author;
    address public currentHolder;

    string public baseTokenURI;

    event UriUpdated(string oldUri, string newUri);

    /// @param _v v part of the signature.
    /// @param _r r part of the signature.
    /// @param _s s part of the signature.
    /// @dev The price of each NFT should be in _paymentTokens' decimal places, ie. 6 decimal places for USDC
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    ) ERC721(_name, _symbol) { 
        v = _v;
        r = _r;
        s = _s;
        _safeMint(address(this), 0);
    }

    modifier notAuthered() {
        require(author == address(0), "Intellectual: authored");
        _;
    }

    modifier notZero(address _address) {
        require(_address != address(0), "Intellectual: 0 address");
        _;
    }

    /// @param _baseTokenUri the collection's URL
    function setBaseTokenURI(string memory _baseTokenUri) external onlyOwner {
        require(bytes(_baseTokenUri).length > 0, "Asset: empty URI");
        string memory oldBaseTokenUri = baseTokenURI;
        baseTokenURI = _baseTokenUri;
        emit UriUpdated(oldBaseTokenUri, _baseTokenUri);
    }

    function _baseURI()
        internal
        view
        virtual
        override(ERC721)
        returns (string memory)
    {
        return baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view override(ERC721) returns (string memory) {
        require(tokenId != 0, "Intellectual: tokenId invalid");
        return baseTokenURI;
    }

    function _mint(address to, uint256 tokenId) internal pure override(ERC721) {
        revert("Intellectual: this method is not supported");
    }

}
