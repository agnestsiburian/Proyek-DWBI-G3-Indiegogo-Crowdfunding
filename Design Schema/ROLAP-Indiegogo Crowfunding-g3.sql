/*-- Step 1: Create the database
CREATE DATABASE IndiegogoDB;
GO

USE IndiegogoDB;
GO

DROP DATABASE IndiegogoDB;*/

-- Step 2: Create Dimension Tables
CREATE TABLE DimCurrency (
    currency_id INT PRIMARY KEY,
    currency NVARCHAR(50)
);

CREATE TABLE DimProduct (
    product_id INT PRIMARY KEY,
    product_stage NVARCHAR(50)
);

CREATE TABLE DimTag (
    tag_id INT PRIMARY KEY,
    tag NVARCHAR(50)
);

CREATE TABLE DimCategory (
    category_id INT PRIMARY KEY,
    category NVARCHAR(50)
);

CREATE TABLE DimProject (
    project_id INT PRIMARY KEY,
    category NVARCHAR(50),
    project_type NVARCHAR(50),
    tag NVARCHAR(50)
);

CREATE TABLE DimTime (
    project_id INT,
    open_date DATE,
    open_time TIME,
    close_date DATE,
    close_time TIME,
    FOREIGN KEY (project_id) REFERENCES DimProject(project_id),
);

-- Step 3: Create Fact Table
CREATE TABLE FactIndiegogo (
    project_id INT,
    currency_id INT,
    category_id INT,
    product_id INT,
    tag_id INT,
    funds_raised_amount DECIMAL(18, 2),
    open_date DATE,
    close_date DATE,
    perk_goal_percentage DECIMAL(5, 2),
    is_proven BIT,
    funds_raised_percent DECIMAL(5, 2),
    PRIMARY KEY (project_id, currency_id, category_id, product_id, tag_id),
    FOREIGN KEY (project_id) REFERENCES DimProject(project_id),
    FOREIGN KEY (currency_id) REFERENCES DimCurrency(currency_id),
    FOREIGN KEY (category_id) REFERENCES DimCategory(category_id),
    FOREIGN KEY (product_id) REFERENCES DimProduct(product_id),
    FOREIGN KEY (tag_id) REFERENCES DimTag(tag_id)
);
