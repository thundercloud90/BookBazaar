--create procedure LoginingIn 
--@UserName varchar(30)
--@Password varchar(10)
--AS
--LoginingIn 
SELECT User_PhoneNum FROM Login 
WHERE UserName = @UserName  
AND Password = @Password
AND Baned = 0

--create procedure dbo.Viewlistings (@Phonenumber)
--AS
--Viewlistings
SELECT bookname, filename, Author, FileName, Condition, Edition, TimePosted
FROM Book
JOIN Postings on Book.Isbn = Posting.Books_ISBN
Where User_PhoneNum = @Phonenumber


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

--Check if user is admin
SELECT IsAdmin
FROM User
Where Phonenum = @PhoneNumber

--create procedure dbo.ReportAbuse(@Report, @PhoneNumber)
--AS
--report abuse
INSERT INTO Abuse (Report, PhoneNumber)
value (@Report, @PhoneNumber)


--create procedure dbo.ViewAbuse()
--AS
--View abuse that has been posted
SELECT AbuserNumber, User_PhoneNum, Report
FROM Abuse
Where Solved = False

--create procedure dbo.SolveAbuse (@AbuserNumber)
--as
--put that abuse has been resolved
Insert Into Abuse (Solved)
value (True)
Where ABuse.AbuserNumber = @AbuserNumber



--create procedure dbo.Search (@Input)
--AS
--search listings
SELECT DISTINCT bookname, Author, FileName, Condition, Edition, TimePosted
FROM Book
JOIN Postings on Book.Isbn = Posting.Books_ISBN
Where Isbn = @Input or Bookname = @Input or Author= @Input or Condition= @Input or Edition= @Input

--create procedure dbo.banAccount (@Phonenumber varchar(10))
--AS
--ban someones account
INSERT INTO Login (Baned)
VALUES (True)
WHERE User_PhoneNum = @phonenumber


