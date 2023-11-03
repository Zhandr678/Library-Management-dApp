

const {expect} = require("Chai");
const {ethers} = require("ethers");


function getRandomInt(min,max){
    return Math.floor(Math.random() * (max-min)) + min;
}

describe("Library Contract", function(){
    let Library;
    let library; // an object of contract
    let owner;

    const NUM_UNFINISHED_BOOK = 5
    const NUM_FINISHED_BOOK = 3;
    
    let unfinishedBookList;
    let finishedBookList;

    beforeEach(async function(){
        Library = await ethers.getContractFactory("Library");
        library = await Library.deploy();
        [owner] = await ethers.getSigners();

        unfinishedBookList = [];
        finishedBookList = [];

        for(let i=0; i < NUM_UNFINISHED_BOOK; i++){
            let book = {
                'name': getRandomInt(1, 1000).toString(),
                'year': getRandomInt(1800, 2023).toString(),
                'author': getRandomInt(1, 1000).toString(),
                'finished': false
            };

            await library.addbook(book.name, book.year, book.author, book.finished);
            unfinishedBookList.push(book);
        }

        for(let i=0; i < NUM_FINISHED_BOOK; i++){
            let book = {
                'name': getRandomInt(1, 1000).toString(),
                'year': getRandomInt(1800, 2023).toString(),
                'author': getRandomInt(1, 1000).toString(),
                'finished': true
            };

            await library.addbook(book.name, book.year, book.author, book.finished);
            finishedBookList.push(book);
        }
    });

});