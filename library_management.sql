-- Library Management System Database Creation Script

-- Drop tables if they exist to start with a clean slate
DROP TABLE IF EXISTS BookAuthors, Loans, Books, Authors, Members, Categories;

-- Categories Table (1-M relationship with Books)
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique ID for each category
    category_name VARCHAR(100) NOT NULL UNIQUE     -- Name of the category (e.g., Fiction, Science)
);

-- Members Table (1-M relationship with Loans)
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,       -- Unique ID for each member
    name VARCHAR(100) NOT NULL,                      -- Member's name
    email VARCHAR(100) UNIQUE,                       -- Unique email for each member
    join_date DATE NOT NULL,                         -- Date when the member joined
    phone VARCHAR(20)                                -- Optional phone number
);

-- Authors Table (1-M relationship with BookAuthors)
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,       -- Unique ID for each author
    first_name VARCHAR(50) NOT NULL,                 -- Author's first name
    last_name VARCHAR(50) NOT NULL                   -- Author's last name
);

-- Books Table (1-M relationship with Categories)
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,         -- Unique ID for each book
    title VARCHAR(200) NOT NULL,                     -- Book title
    isbn VARCHAR(20) UNIQUE NOT NULL,                -- Unique ISBN for the book
    published_year INT,                              -- Year the book was published
    category_id INT,                                 -- Foreign Key to Categories table
    total_copies INT DEFAULT 1,                      -- Total number of copies available
    available_copies INT DEFAULT 1,                  -- Available copies for borrowing
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)   -- Foreign Key constraint
);

-- BookAuthors Table (Many-to-Many relationship between Books and Authors)
CREATE TABLE BookAuthors (
    book_id INT,                                    -- Foreign Key to Books table
    author_id INT,                                  -- Foreign Key to Authors table
    PRIMARY KEY (book_id, author_id),               -- Composite Primary Key
    FOREIGN KEY (book_id) REFERENCES Books(book_id), -- Foreign Key constraint to Books table
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) -- Foreign Key constraint to Authors table
);

-- Loans Table (1-M relationship with Members, 1-M relationship with Books)
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique ID for each loan transaction
    book_id INT NOT NULL,                           -- Foreign Key to Books table
    member_id INT NOT NULL,                         -- Foreign Key to Members table
    loan_date DATE NOT NULL,                        -- Date the book was loaned out
    due_date DATE NOT NULL,                         -- Due date for returning the book
    return_date DATE,                               -- Return date of the book (nullable)
    FOREIGN KEY (book_id) REFERENCES Books(book_id),  -- Foreign Key constraint to Books table
    FOREIGN KEY (member_id) REFERENCES Members(member_id) -- Foreign Key constraint to Members table
);
