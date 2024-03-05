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

        mintedMaincardAmount=0;
    }

    enum CardType {
        MainCharacter, //본캐
        SubCharacter //부캐
    }

    //State Variables
    MainCard[] mainCards; //MainCard들 종류 배열
    SubCard[] subCards; //SubCards들 배열
    uint firstMintPrice; // 처음 민팅되는 가격
    uint mintPrice; //최초 민팅 이후 10개씩 민팅할 때마다 가격
    uint firstMintAmount; // 처음 민팅되는 양
    uint mintedMaincardAmount; //민팅된 Maincard amount


    //Mappings
    mapping(address => uint256) internal mainCardAmount; // 주소로 

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
    /**최초 MainCard 민팅 시*/
    function firstMainMint( 
        string memory _name,
        string memory _portfolio,
        string memory _email,
        string memory _company,
        string memory _university,
        string memory _major,
        string memory _phone
    ) public {
        MainCard memory mainCard = MainCard({ //MainCard에 들어갈 내용을 작성하는 부분
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
        mainCards.push(mainCard);
        mintedMaincardAmount+=firstMintAmount;
        for (uint _id= mintedMaincardAmount+1; _id<= (mintedMaincardAmount+firstMintAmount);_id++){
            _safeMint(msg.sender,_id);
            emit MainCardCreated(_id, _name, _portfolio, _email, CardType.MainCharacter, msg.sender, _company, _university, _major, _phone);
        }
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

    function getAddress() external view returns(address) {
        return address(this);
    }

}