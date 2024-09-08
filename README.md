# MoneyBuddy

MoneyBuddy is a simple transaction management application built using ASP.NET Web Forms and ADO.NET. It helps users manage their financial transactions, providing features such as transaction storage, statistics, and data visualization.

## Project Overview

MoneyBuddy allows users to:
- Store transaction details including description, amount, date & time, and categories.
- View statistics on transactions including total transactions, average transaction amount, monthly breakdown, and weekly statistics.

## Features

- **User Registration and Login:** Secure user authentication and session management.
- **Transaction Management:** Add, view, and manage transactions.
- **Statistics:** View financial statistics and breakdowns.
- **Responsive Design:** Clean and user-friendly interface.

## Technologies Used

- **ASP.NET Framework 3.1** (Web Forms)
- **ADO.NET** for data access
- **SQL Server** for database management

## Installation

### Prerequisites

- .NET Framework 3.1
- SQL Server Management Studio (SSMS)

### Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/your-username/moneybuddy.git
   cd moneybuddy
2. **Setup the Database**

   - Open SQL Server Management Studio (SSMS).
   - Execute the following SQL script to create the database and tables:

   ```sql
   CREATE DATABASE MoneyBuddy;

   USE MoneyBuddy;

   CREATE TABLE Users (
       UserId INT IDENTITY(1,1) PRIMARY KEY,   
       UserName NVARCHAR(50) NOT NULL UNIQUE,  
       Password NVARCHAR(255) NOT NULL         
   );

   CREATE TABLE Transactions (
       TransactionId INT IDENTITY(1,1) PRIMARY KEY,   
       Description NVARCHAR(255) NOT NULL,            
       Amount DECIMAL(18, 2) NOT NULL,                
       TransactionDate DATE NOT NULL,             
       UserId INT NOT NULL,                          
       CONSTRAINT FK_User_Transactions FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
   );

3. **Configure the Application**

    - Open the solution in Visual Studio.
    - Update the connection string in the `Web.config` file to match your SQL Server configuration.

   ```xml
   <connectionStrings>
       <add name="MoneyBuddyConnectionString" connectionString="Server=your_server;Database=MoneyBuddy;User Id=your_user;Password=your_password;" providerName="System.Data.SqlClient"/>
   </connectionStrings>
   
## Usage

1. **Register an Account**

   - Navigate to the registration page.
   - Fill in the required details and submit the form.

2. **Log In**

   - Use the credentials created during registration to log in.

3. **Manage Transactions**

   - After logging in, navigate to the transactions page to add, view, and manage your transactions.

4. **View Statistics**

   - Access the statistics page to view various breakdowns of your transactions.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature/your-feature`).
6. Create a new Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
