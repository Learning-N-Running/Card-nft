// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";


contract TinaCard is ERC721Enumerable , Ownable {
    uint public issuanceCost;
    address public issuanceAdminAddress;
    string private baseTokenURI;

    
     constructor(
        string memory _name,
        string memory _symbol,
        // string memory _baseTokenURI,
        uint256 _initialCost,
        address _issuanceAdminAddress
    ) ERC721(_name, _symbol) {
        // baseTokenURI= _baseTokenURI ;
        issuanceCost = _initialCost;
        issuanceAdminAddress = _issuanceAdminAddress;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    // 발행 비용을 변경하는 함수, 소유자만 호출 가능
    function setIssuanceCost(uint _newCost) external onlyOwner {
        issuanceCost = _newCost;
    }

    //nft 발행 함수
    function mintNFTs(address _to) external payable {
        require(msg.value >= issuanceCost,"Insufficient Payment");
        _mint(_to,totalSupply()) ; //_to 주소에 현재까지 발행된 토큰의 개수를 식별자로 가지는 새로운 ERC721 토큰을 발행. //ex) 현재까지 총 5개의 토큰이 발행되었다면 이 코드는 _to 주소에 ID가 5인 새로운 ERC721 토큰을 발행

    } 

    //nft 전송 함수
    function transferNFT(address _to, uint256 _tokenID) external {
        require(ownerOf(_tokenID)== msg.sender , "Not the NFT owner");
        safeTransferFrom(msg.sender,_to, _tokenID);
    }

     
}