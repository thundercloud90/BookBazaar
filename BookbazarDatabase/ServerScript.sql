--create procedure LoginingIn 
--@UsersName varchar(30)
--@Password varchar(10)
--AS
--LoginingIn 
SELECT User_PhoneNum FROM Login 
WHERE UsersName = @UsersName  
AND Password = @Password
AND Baned = 0

--create procedure dbo.Viewlistings (@Phonenumber)
--AS
--Viewlistings
SELECT bookname, filename, Author, FileName, Condition, Edition, TimePosted
FROM Book
JOIN Postings ON Book.Isbn = Posting.Books_ISBN
WHERE User_PhoneNum = @Phonenumber


--create procedure dbo.Postlisting (@Book_ISBN, @Phonenumber, @TimeNow)
--AS
--Postlisting
INSERT INTO Posting (Book_ISBN, Phonenumber, TimeNow)
VALUES (@Book_ISBN, @Phonenumber, @TimeNow)

--create procedure dbo.newBook (@Isbn, @Bookname, @filename, @Author, @FileName, @`Condition`, @`Edition`)
--AS
--And a new book to the table
INSERT INTO Books (Isbn, Bookname, filename, Author, FileName, Condition, Edition)
VALUES (@Isbn, @Bookname, @filename, @Author, @FileName, @Condition, @Edition)


--create procedure dbo.DeleteListing(@Book_ISBN)
--AS
--delete a listing
DELETE FROM dbo.Postings
WHERE Book_ISBN=@Book_ISBN

--Check if Users is admin
SELECT IsAdmin
FROM Users
WHERE Phonenum = @PhoneNumber

--create procedure dbo.ReportAbuse(i should @Report, @PhoneNumber)
--AS
--report abuse
INSERT INTO Abuse (Report, PhoneNumber)
value (@Report, @PhoneNumber)


--create procedure dbo.ViewAbuse()
--AS
--View abuse that has been posted
SELECT AbUsersNumber, User_PhoneNum, Report
FROM Abuse
WHERE Solved = False

--create procedure dbo.SolveAbuse (@AbUsersNumber)
--as
--put that abuse has been resolved
UPDATE Abuse 
SET Solved = True
WHERE ABuse.AbUsersNumber = @AbUsersNumber



--create procedure dbo.Search (@Input)
--AS
--search listings
SELECT DISTINCT bookname, Author, FileName, Condition, Edition, TimePosted
FROM Book
JOIN Postings ON Book.Isbn = Posting.Books_ISBN
WHERE Isbn = @Input OR Bookname = @Input OR Author = @Input OR Condition = @Input OR Edition = @Input

--create procedure dbo.banAccount (@Phonenumber varchar(10))
--AS
--ban someones account
UPDATE Login 
SET Baned = True
WHERE User_PhoneNum = @phonenumber


