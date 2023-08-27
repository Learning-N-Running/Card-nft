// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./ERC721EnumerableUpgradeable.sol";
import "./access/Ownable.sol";
import "./security/ReentrancyGuard.sol";
import "./library/SafeToken.sol";

contract GachaCard is ERC721EnumerableUpgradeable, ReentrancyGuard {
    constructor(
        uint _firstMintPrice,
        uint _mintPrice,
        uint _firstMintAmount
    ) {
        firstMintPrice = _firstMintPrice;
        mintPrice = _mintPrice;
        firstMintAmount = _firstMintAmount;
    }

    enum CardType {
        MainCharacter, //본캐
        SubCharacter //부캐
    }

    //State Variables
    MainCard[] mainCards; //MainCard들 배열
    SubCard[] subCards; //SubCards들 배열
    uint firstMintPrice; // 처음 민팅되는 가격
    uint mintPrice; //최초 민팅 이후 10개씩 민팅할 때마다 가격
    uint firstMintAmount; // 처음 민팅되는 양


    //Mappings
    struct MainCard {
        //essential
        string name;
        string portfolio;
        string email;
        CardType cardType;
        address owner;

        //optional
        string company;
        string university;
        string major;
        string phone;
        
    }
    
    struct SubCard {
        string name;
        CardType cardType;
        address owner;
    }

    //Events
    event MainCardCreated (
        uint indexed id,
        string name,
        string portfolio,
        string email,
        CardType cardType,
        address owner,
        string company,
        string university,
        string major,
        string phone
    );
    event SubCardCreated (
        uint indexed id,
        string name,
        CardType cardType,
        address owner
    );

    

    //Functions
    function _writeMainInfo(
        string memory _name,
        string memory _portfolio,
        string memory _email,
        string memory _company,
        string memory _university,
        string memory _major,
        string memory _phone
    ) private {
        MainCard memory mainCard = MainCard({
        name: _name,
        portfolio: _portfolio,
        email: _email,
        cardType : CardType.MainCharacter,
        owner: msg.sender,
        company: _company,
        university: _university,
        major: _major,
        phone: _phone
        });
        mainCards.push(mainCard); //그 사람이 갖고 있는 개수 추가하는 것부터 만들면 됨.
    }
    
    function getFirstMintPrice() external view returns(uint) {
        return firstMintPrice;
    }
    function getMintPrice() external view returns(uint) {
        return mintPrice;
    }
    function getFirstMintAmount() view external returns(uint) {
        return firstMintAmount;
    }

}