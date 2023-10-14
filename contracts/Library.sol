pragma solidity ^0.8.0;

contract Library
{
    struct Book
    {
        uint id;
        string name;
        uint year;
        string author;
        bool finished;
    }

    Book[] private bookList;

    mapping(uint256 => address) bookToOwner;

    event AddBlock(address recipient, uint bookId);

    function addBlock(string memory name, uint year, string memory author, bool finished) external
    {
        uint bookId = bookList.length;
        bookList.push(Book(bookId, name, year, author, finished));
        bookToOwner[bookId] = msg.sender;
        emit AddBlock(msg.sender, bookId);
    }
}
