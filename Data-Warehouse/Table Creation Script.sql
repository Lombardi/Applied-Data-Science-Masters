CREATE TABLE Dim_Account (
Account_ID INT PRIMARY KEY,
Client_ID INT NOT NULL,
Client_Name VARCHAR(100) NOT NULL,
Client_SSN INT NOT NULL,
Client_DOB Date NOT NULL,
Client_Email VARCHAR(50),
Client_PhoneNumber VARCHAR(20),
Account_Status BIT NOT NULL,
Account_OpenDate DATE NOT NULL,
Account_CloseDate DATE
);

CREATE TABLE Dim_Date (
Date_ID INT PRIMARY KEY,
Date_Year INT NOT NULL,
Date_MonthNumber INT NOT NULL,
Date_MonthName VARCHAR(20) NOT NULL,
Date_Day INT NOT NULL,
Date_DayofWeek VARCHAR(20) NOT NULL,
Date_CalendarDate DATE NOT NULL,
Date_WeekNum INT NOT NULL
);

CREATE TABLE Dim_Time (
Time_ID INT PRIMARY KEY,
time_Hour INT NOT NULL,
Time_Minute INT NOT NULL,
Time_Second INT NOT NULL,
Time_Milisecond INT NOT NULL,
Time_ClockHour TIME NOT NULL
);

CREATE TABLE Dim_Contracts (
Contract_ID INT PRIMARY KEY,
Account_ID INT NOT NULL,
Contract_SignDate DATE NOT NULL,
Contract_Status BIT NOT NULL,
Contract_TotalDue FLOAT NOT NULL,

CONSTRAINT accountFK FOREIGN KEY (Account_ID) REFERENCES Dim_Account(Account_ID)
);

CREATE TABLE Fact_Transactions (
Account_ID INT NOT NULL,
Date_ID INT NOT NULL,
Time_ID INT NOT NULL,
Transaction_Amount FLOAT NOT NULL,
Transaction_Type INT NOT NULL,
Transaction_Details VARCHAR(100),

CONSTRAINT trasactionPK PRIMARY KEY (Account_ID, Date_ID,Time_ID),
CONSTRAINT transaccFK FOREIGN KEY (Account_ID) REFERENCES Dim_Account(Account_ID),
CONSTRAINT DateFK FOREIGN KEY (Date_ID) REFERENCES Dim_Date(Date_ID),
CONSTRAINT timeFK FOREIGN KEY (Time_ID) REFERENCES Dim_Time(Time_ID),
);

CREATE TABLE Fact_Payments (
Contract_ID INT NOT NULL,
Date_ID INT NOT NULL,
Time_ID INT NOT NULL,
Due_Amount FLOAT NOT NULL,
Paid_Amount FLOAT NOT NULL,
Payment_Date DATE,

CONSTRAINT paymentPK PRIMARY KEY (Contract_ID, Date_ID, Time_ID),
CONSTRAINT contpayFK FOREIGN KEY (Contract_ID) REFERENCES Dim_Contracts(Contract_ID),
CONSTRAINT datepayFK FOREIGN KEY (Date_ID) REFERENCES Dim_Date(Date_ID),
CONSTRAINT timepayFK FOREIGN KEY (Time_ID) REFERENCES Dim_Time(Time_ID),
);