// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

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

    event AddBook(address recipient, uint bookId);
    event SetFinished(uint bookId, bool finished);

    modifier onlyOwner(uint bookId) {
        require(bookToOwner[bookId] == msg.sender, "You are not the owner of this book");
        _;
    }

    modifier validBookName(string memory name) {
        require(bytes(name).length > 0, "Book name cannot be empty");
        _;
    }

    modifier validYear(uint year) {
        require(year > 0, "Year should be greater than 0");
        _;
    }

    modifier validAuthor(string memory author) {
        require(bytes(author).length > 0, "Author name cannot be empty");
        _;
    }

    function addBook(string memory name, uint year, string memory author, bool finished) external
        validBookName(name)
        validYear(year)
        validAuthor(author)
    {
        uint bookId = bookList.length;
        bookList.push(Book(bookId, name, year, author, finished));
        bookToOwner[bookId] = msg.sender;
        emit AddBook(msg.sender, bookId);
    }

    function _getBookList(bool finished) private view returns (Book[] memory)
    {
        Book[] memory temp = new Book[](bookList.length);
        uint count = 0;

        for (uint i = 0; i < bookList.length; i++)
        {
            if (bookToOwner[i] == msg.sender && bookList[i].finished == finished) 
            {
                temp[count] = bookList[i];
                count++;
            }
        }

        Book[] memory result = new Book[](count);
        for (uint i = 0; i < count; i++)
        {
            result[i] = temp[i];
        }
        return result;
    }

    function getFinishedBooks() external view returns (Book[] memory)
    {
        return _getBookList(true);
    }

    function getUnfinishedBooks() external view returns (Book[] memory)
    {
        return _getBookList(false);
    }

    function setFinished(uint bookId, bool finished) external
        onlyOwner(bookId)
    {
        bookList[bookId].finished = finished;
        emit SetFinished(bookId, finished);
    }
}