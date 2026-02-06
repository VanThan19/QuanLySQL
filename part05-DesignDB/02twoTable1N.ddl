CREATE TABLE Student (
  StudentId char(8) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  LastName  varchar(30) NOT NULL, 
  MajorID   char(2) NOT NULL, 
  PRIMARY KEY (StudentId));
CREATE TABLE Major (
  MajorID   char(2) NOT NULL, 
  MajorName varchar(40) NOT NULL, 
  PRIMARY KEY (MajorID));
ALTER TABLE Student ADD CONSTRAINT FKStudent939401 FOREIGN KEY (MajorID) REFERENCES Major (MajorID) ON UPDATE Cascade ON DELETE Set null;
