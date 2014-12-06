--create procedure LoginingIn 
--@UsersName varchar(30)
--@Password varchar(10)
--AS
--LoginingIn 
SELECT User_PhoneNum, FirstName, LastName, Street, City, State, ZipCode, IsAdmin, AvatarFilename 
FROM Login 
JOIN Users ON Login.User_PhoneNum = Users.Phonenum
WHERE UsersName = @UsersName 
AND Password = @Password
AND Baned = 0

--create procedure dbo.Viewlistings (@Phonenumber)
--AS
--Viewlistings
SELECT *
FROM Books
JOIN Postings ON Book.Isbn = Posting.Books_ISBN
WHERE User_PhoneNum = @Phonenumber
ORDER BY TimePosted DESC


--create procedure dbo.Postlisting (@Book_ISBN, @Phonenumber, @TimeNow)
--AS
--Postlisting
INSERT INTO Posting (Book_ISBN, Phonenumber, TimeNow, Price)
VALUES (@Book_ISBN, @Phonenumber, @TimeNow ,@Price)

--create procedure dbo.newBook (@Isbn, @Bookname, @filename, @Author, @FileName, @`Condition`, @`Edition`)
--AS
--And a new book to the table
INSERT INTO Books (Isbn, Bookname, Author, FileName, Condition, Edition)
VALUES (@Isbn, @Bookname, @Author, @FileName, @Condition, @Edition)


--create procedure dbo.DeleteListing(@Book_ISBN)
--AS
--delete a listing
DELETE FROM dbo.Postings
WHERE Book_ISBN=@Book_ISBN AND PhoneNumber=@PhoneNumber

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
SELECT * FROM Books 
JOIN Postings ON Books.Isbn = Postings.Books_ISBN
WHERE lower(Isbn)= lower(@Input) 
OR lower(Bookname) = lower(@Input) 
OR lower(Author) = lower(@Input)
ORDER BY TimePosted DESC


--create procedure dbo.banAccount (@Phonenumber varchar(10))
--AS
--ban someones account
UPDATE Login 
SET Baned = True
WHERE User_PhoneNum = @phonenumber

--Intital Search
SELECT  bookname, Author, FileName, Condition, Edition, TimePosted, Posting.User_PhoneNum, Price
FROM Book
JOIN Postings ON Book.Isbn = Posting.Books_ISBN
ORDER BY TimePosted DESC

--Users data pull
SELECT * 
FROM Users 
WHERE PhoneNum = @phonenumber

--Create User
INSERT INTO Users (PhoneNum, FirstName, LastName, Street, City, State, ZipCode, IsAdmin, AvatarFilename)
value (@PhoneNum, @FirstName, @LastName, @Street, @City, @State, @ZipCode, @IsAdmin, @AvatarFilename)
INSERT INTO Login (UsersName, Password, User_PhoneNum)
value (@UsersName, @Password, @PhoneNum)
