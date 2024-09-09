/* Table creation and row insertion for lab 04. */

/* department */
CREATE TABLE department (
  dept_name VARCHAR(15) NOT NULL,
  dept_floor SMALLINT NOT NULL,
  dept_phone SMALLINT NOT NULL,
  empl_number SMALLINT NOT NULL,
  CONSTRAINT pk_dept PRIMARY KEY(dept_name)
);

/* employee */
CREATE TABLE employee (
  empl_number INTEGER NOT NULL,
  empl_firstname VARCHAR(10),
  empl_salary DECIMAL(7,0),
  dept_name VARCHAR(15),
  boss_number INTEGER,
  CONSTRAINT pk_emp PRIMARY KEY(empl_number),
  CONSTRAINT fk_belong_dept FOREIGN KEY (dept_name) REFERENCES department(dept_name),
  CONSTRAINT fk_has_boss FOREIGN KEY (boss_number) REFERENCES employee(empl_number)
);

/* product */
CREATE TABLE product (
  prod_id INTEGER NOT NULL,
  prod_description VARCHAR(30),
  prod_cost DECIMAL(9,2),
  prod_price DECIMAL(9,2),
  CONSTRAINT pk_product PRIMARY KEY(prod_id)
);

/* assembly */
CREATE TABLE assembly (
  quantity INTEGER NOT NULL,
  prod_id INTEGER NOT NULL,
  subprod_id INTEGER NOT NULL,
  CONSTRAINT pk_assembly PRIMARY KEY(prod_id, subprod_id),
  CONSTRAINT fk_assembly_product FOREIGN KEY(prod_id) REFERENCES product(prod_id),
  CONSTRAINT fk_assembly_subproduct FOREIGN KEY(subprod_id) REFERENCES product(prod_id)
);

/* department */
INSERT INTO department VALUES ('Management', 5, 2001, 1);
INSERT INTO department VALUES ('Marketing', 1, 2002, 2);
INSERT INTO department VALUES ('Accounting', 4, 2003, 5);
INSERT INTO department VALUES ('Purchasing', 4, 2004, 7);
INSERT INTO department VALUES ('Personnel', 1, 2005, 9);

/* employee */
INSERT INTO employee (empl_number, empl_firstname, empl_salary, dept_name) VALUES (1, 'Alice', 75000, 'Management');
INSERT INTO employee VALUES (2, 'Ned', 45000, 'Marketing', 1);
INSERT INTO employee VALUES (3, 'Andrew', 25000, 'Marketing', 2);
INSERT INTO employee VALUES (4, 'Clare', 22000, 'Marketing', 2);
INSERT INTO employee VALUES (5, 'Todd', 38000, 'Accounting', 1);
INSERT INTO employee VALUES (6, 'Nancy', 22000, 'Accounting', 5);
INSERT INTO employee VALUES (7, 'Brier', 43000, 'Purchasing', 1);
INSERT INTO employee VALUES (8, 'Sarah', 56000, 'Purchasing', 7);
INSERT INTO employee VALUES (9, 'Sophie', 35000, 'Personnel', 1);
INSERT INTO employee VALUES (10, 'Bob', 30000, 'Purchasing', 8);
INSERT INTO employee VALUES (11, 'Sue', 31000, 'Purchasing', 8);
INSERT INTO employee VALUES (12, 'Dylan', 18000, 'Marketing', 2);

/* product */
INSERT INTO product (prod_id, prod_description, prod_price) VALUES (1000, 'Animal photography kit', 725);
INSERT INTO product (prod_id, prod_description, prod_price) VALUES (2000, 'Portrait photography kit', 925);
INSERT INTO product VALUES (101, '35mm camera', 150, 300);
INSERT INTO product VALUES (102, 'Camera case', 10, 15);
INSERT INTO product VALUES (103, '70-210 zoom lens', 125, 200);
INSERT INTO product VALUES (104, '28-85 zoom lens', 115, 185);
INSERT INTO product VALUES (105, 'Photographers vest', 25, 40);
INSERT INTO product VALUES (106, 'Lens cleaning cloth', 1, 1);
INSERT INTO product VALUES (107, 'Tripod', 35, 45);
INSERT INTO product VALUES (108, '24/100 ASA 35mm color neg film', 0.85, 1);
INSERT INTO product VALUES (201, 'Digital camera', 200, 400);

/* assembly */
INSERT INTO assembly VALUES (1, 1000, 101);
INSERT INTO assembly VALUES (1, 1000, 102);
INSERT INTO assembly VALUES (1, 1000, 103);
INSERT INTO assembly VALUES (1, 1000, 104);
INSERT INTO assembly VALUES (1, 1000, 105);
INSERT INTO assembly VALUES (2, 1000, 106);
INSERT INTO assembly VALUES (1, 1000, 107);
INSERT INTO assembly VALUES (10, 1000, 108);
INSERT INTO assembly VALUES (1, 2000, 201);
INSERT INTO assembly VALUES (1, 2000, 107);
INSERT INTO assembly VALUES (1, 2000, 105);
INSERT INTO assembly VALUES (1, 2000, 106);
INSERT INTO assembly VALUES (1, 2000, 102);

