// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";



contract TinaCard is ERC721Enumerable , Ownable {
    uint public issuanceCost;
    address public issuanceAdminAddress;
    string private baseTokenURI;
    uint256 private _currentTokenId = 0;

    
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

        // _mint(_to,totalSupply()) ; //_to 주소에 (현재까지 발행된 토큰의 개수)를 식별자로 가지는 새로운 ERC721 토큰을 발행. //ex) 현재까지 총 5개의 토큰이 발행되었다면 이 코드는 _to 주소에 ID가 5인 새로운 ERC721 토큰을 발행
        uint256 newTokenId = _getNextTokenId();
        _mint(_to, newTokenId);
        _incrementTokenId();

    }


    function _getNextTokenId() private view returns (uint256) {
        return _currentTokenId+1;
    }

    function _incrementTokenId() private {
        _currentTokenId++;
    }

    //nft 전송 함수
    function transferNFT(address _to, uint256 _tokenID) external {
        require(ownerOf(_tokenID)== msg.sender , "Not the NFT owner");
        safeTransferFrom(msg.sender,_to, _tokenID);
    }

    function tokenURI(uint256 tokenId) override public pure returns (string memory) {
        string[3] memory parts;

        parts[0] = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 300px; }</style><rect width='100%' height='100%' fill='brown' /><text x='100' y='260' class='base'>";

        parts[1] = Strings.toString(tokenId);

        parts[2] = "</text></svg>";

        string memory json = Base64.encode(bytes(string(abi.encodePacked(
            "{\"name\":\"Tina's Card #", 
            Strings.toString(tokenId), 
            "\",\"description\":\"Card NFT for Blockchain Valley Assignment.\",",
            "\"image\": \"data:image/svg+xml;base64,", 
            // Base64.encode(bytes(output)), 
            Base64.encode(bytes(abi.encodePacked(parts[0], parts[1], parts[2]))),     
            "\"}"
            ))));

        return string(abi.encodePacked("data:application/json;base64,", json));
    }  
     
}