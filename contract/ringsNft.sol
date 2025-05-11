// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RingsNFT is ERC721, ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Counters.Counter private _itemsSold;
    Counters.Counter private _eventIds;

    // Circles token address on Gnosis Chain
    IERC20 public constant CRC = IERC20(0x29b9a7fbb8995b2423a71cc17cf9810798f6c543);

    uint256 public listingPrice = 10 * 10**18;
    uint256 public resellingPrice = 15 * 10**18;
    address public contractOwner;

    mapping(uint256 => MarketItem) private idToMarketItem;

    struct MarketItem {
        uint256 tokenId;
        uint256 eventId;
        address payable seller;
        address payable owner;
        address payable host;
        uint256 price;
        bool sold;
        bool resell;
    }

    event MarketItemCreated (
        uint256 indexed tokenId,
        uint256 eventId,
        address seller,
        address owner,
        address host,
        uint256 price,
        bool sold,
        bool resell
    );

    constructor() ERC721("RingsNFT", "RNF") {
        contractOwner = msg.sender;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function updateListingPrice(uint _listingPrice) public {
        require(msg.sender == contractOwner, "Only marketplace owner can update listing price.");
        listingPrice = _listingPrice;
    }

    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    function updateResellingPrice(uint _resellingPrice) public {
        require(msg.sender == contractOwner, "Only marketplace owner can update reselling price.");
        resellingPrice = _resellingPrice;
    }

    function getResellingPrice() public view returns (uint256) {
        return resellingPrice;
    }

    function updateContractOwner() public {
        require(msg.sender == contractOwner, "Only current owner can update owner.");
        contractOwner = msg.sender;
    }

    function createToken(uint256 _amount, uint256 eventId, string memory uri, uint256 price) public {
        uint256 totalCost = listingPrice * _amount;
        require(CRC.transferFrom(msg.sender, contractOwner, totalCost), "CRC payment failed");

        for (uint256 i = 0; i < _amount; i++) {
            _tokenIds.increment();
            uint256 newTokenId = _tokenIds.current();
            _mint(msg.sender, newTokenId);
            _setTokenURI(newTokenId, uri);
            createMarketItem(newTokenId, eventId, price);
        }
    }

    function createMarketItem(
        uint256 tokenId,
        uint256 eventId,
        uint256 price
    ) private {
        require(price >= 0, "Price must be at least 0");

        idToMarketItem[tokenId] = MarketItem(
            tokenId,
            eventId,
            payable(msg.sender),
            payable(address(this)),
            payable(msg.sender),
            price,
            false,
            false
        );

        _transfer(msg.sender, address(this), tokenId);

        emit MarketItemCreated(
            tokenId,
            eventId,
            msg.sender,
            address(this),
            msg.sender,
            price,
            false,
            false
        );
    }

    function resellToken(uint256 tokenId, uint256 price) public {
        require(idToMarketItem[tokenId].owner == msg.sender, "Only item owner");
        require(CRC.transferFrom(msg.sender, contractOwner, resellingPrice), "Reselling payment failed");

        idToMarketItem[tokenId].sold = false;
        idToMarketItem[tokenId].price = price;
        idToMarketItem[tokenId].seller = payable(msg.sender);
        idToMarketItem[tokenId].owner = payable(address(this));
        idToMarketItem[tokenId].resell = true;
        _itemsSold.decrement();

        _transfer(msg.sender, address(this), tokenId);
    }

    function createMarketSale(uint256 tokenId) public {
        uint256 price = idToMarketItem[tokenId].price;
        address seller = idToMarketItem[tokenId].seller;

        require(CRC.transferFrom(msg.sender, seller, price), "CRC transfer failed");

        idToMarketItem[tokenId].owner = payable(msg.sender);
        idToMarketItem[tokenId].sold = true;
        idToMarketItem[tokenId].seller = payable(address(0));
        _itemsSold.increment();

        _transfer(address(this), msg.sender, tokenId);
    }

    function fetchMarketItems() public view returns (MarketItem[] memory) {
        uint itemCount = _tokenIds.current();
        uint unsoldItemCount = _tokenIds.current() - _itemsSold.current();
        uint currentIndex = 0;

        MarketItem[] memory items = new MarketItem[](unsoldItemCount);
        for (uint i = 0; i < itemCount; i++) {
            if (idToMarketItem[i + 1].owner == address(this)) {
                uint currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    function fetchSoldItems() public view returns (MarketItem[] memory) {
        uint itemCount = _tokenIds.current();
        uint soldItemCount = _itemsSold.current();
        uint currentIndex = 0;

        MarketItem[] memory items = new MarketItem[](soldItemCount);
        for (uint i = 0; i < itemCount; i++) {
            if (idToMarketItem[i + 1].sold == true) {
                uint currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    function fetchMyNFTs() public view returns (MarketItem[] memory) {
        uint totalItemCount = _tokenIds.current();
        uint itemCount = 0;
        uint currentIndex = 0;

        for (uint i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                itemCount += 1;
            }
        }

        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].owner == msg.sender) {
                uint currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    function fetchItemsCreated() public view returns (MarketItem[] memory) {
        uint totalItemCount = _tokenIds.current();
        uint itemCount = 0;
        uint currentIndex = 0;

        for (uint i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                itemCount += 1;
            }
        }

        MarketItem[] memory items = new MarketItem[](itemCount);
        for (uint i = 0; i < totalItemCount; i++) {
            if (idToMarketItem[i + 1].seller == msg.sender) {
                uint currentId = i + 1;
                MarketItem storage currentItem = idToMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }
}
