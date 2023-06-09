#0. DATABASE 생성 쿼리
CREATE DATABASE semiERP;
USE semiERP;

#1. 제품 테이블 쿼리
CREATE TABLE PRODUCT(
PRODUCT_ID VARCHAR(10) NOT NULL,
PRODUCT_NAME VARCHAR(30) NOT NULL,
AMOUNT INT NOT NULL DEFAULT 0,
P_PRICE INT NOT NULL DEFAULT 0,
P_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
PRIMARY KEY (PRODUCT_ID, PRODUCT_NAME, P_DATE)
);

#2. 품목코드 테이블 쿼리
CREATE TABLE ITEMS_SORTING_CODE(
SORT_ID VARCHAR(10) NOT NULL,
SORT_NAME VARCHAR(30) NOT NULL,
PRODUCT_ID VARCHAR(10) NOT NULL,
PRODUCT_NAME VARCHAR(30) NOT NULL,
P_FACTORY VARCHAR(30) NOT NULL,
PRIMARY KEY (SORT_ID),
FOREIGN KEY (PRODUCT_ID, PRODUCT_NAME) REFERENCES PRODUCT (PRODUCT_ID, PRODUCT_NAME)
);

#3. 자재 테이블 쿼리
CREATE TABLE MATERIALS(
MATERIALS_ID VARCHAR(10) NOT NULL,
MATERIALS_NAME VARCHAR(30) NOT NULL,
AMOUNT INT NOT NULL DEFAULT 0,
PRODUCT_ID VARCHAR(10) NOT NULL,
W_UNIT_PRICE INT NOT NULL,
W_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
PRIMARY KEY (MATERIALS_ID, MATERIALS_NAME, W_DATE),
FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
);

#4. 자재 사용 테이블 쿼리
CREATE TABLE MATERIALS_USE(
MATERIALS_ID VARCHAR(10) NOT NULL,
MATERIALS_NAME VARCHAR(30) NOT NULL,
USED_AMOUNT INT NOT NULL DEFAULT 0,
USED_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
PRIMARY KEY (MATERIALS_ID),
FOREIGN KEY (MATERIALS_ID, MATERIALS_NAME) REFERENCES MATERIALS (MATERIALS_ID, MATERIALS_NAME)
);

#5. 거래처 목록 테이블 쿼리
CREATE TABLE ACCOUNT_LIST(
ACCOUNT_BID VARCHAR(10) NOT NULL,
BUSINESS_NAME VARCHAR(30) NOT NULL,
CEO VARCHAR(30) NOT NULL,
ADDRESS VARCHAR(50),
EMAIL VARCHAR(30),
PHONE_NUMBER INT NOT NULL,
FAX INT,
DEAL_TYPE INT NOT NULL DEFAULT 0,
DEAL_ITEM_ID VARCHAR(30) NOT NULL,
PRIMARY KEY (ACCOUNT_BID),
FOREIGN KEY (DEAL_ITEM_ID) REFERENCES MATERIALS (MATERIALS_ID)
);

#6. 판매 단가 테이블 쿼리
CREATE TABLE UNIT_SALE_PRICE(
SALE_CODE VARCHAR(10) NOT NULL,
STORE_BID VARCHAR(10) NOT NULL,
PRODUCT_ID VARCHAR(10) NOT NULL,
AMOUNT INT NOT NULL DEFAULT 0,
S_UNIT_PRICE INT NOT NULL DEFAULT 0,
PRIMARY KEY (SALE_CODE, S_UNIT_PRICE),
FOREIGN KEY (STORE_BID) REFERENCES ACCOUNT_LIST (ACCOUNT_BID),
FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
);

#7. 부서 테이블 쿼리
CREATE TABLE DEPARTMENT(
D_ID VARCHAR(4) NOT NULL,
D_NAME VARCHAR(20) NOT NULL,
PRIMARY KEY (D_ID)
);

#8. 호봉 테이블 쿼리
CREATE TABLE SALARY_CLASS(
P_SALARY_CODE VARCHAR(10) NOT NULL,
SALARY INT NOT NULL DEFAULT 0,
PRIMARY KEY (P_SALARY_CODE, SALARY)
);

#9. 사원 테이블 쿼리
CREATE TABLE EMPLOYEE(
EID VARCHAR(10) NOT NULL,
E_NAME VARCHAR(20) NOT NULL,
PASSWORD INT NOT NULL DEFAULT 0000,
D_ID VARCHAR(4) NOT NULL,
POSITION VARCHAR(10) NOT NULL,
PHONE_NUMBER VARCHAR(13) DEFAULT '000-0000-0000',
P_SALARY_CODE VARCHAR(10) NOT NULL,
SALARY INT NOT NULL DEFAULT 0,
JOIN_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
PRIMARY KEY (EID),
FOREIGN KEY (D_ID) REFERENCES DEPARTMENT (D_ID),
FOREIGN KEY (P_SALARY_CODE, SALARY) REFERENCES SALARY_CLASS (P_SALARY_CODE, SALARY)
);

#10. 자재 창고 테이블 쿼리
CREATE TABLE MATERIALS_WAREHOUSE(
MATERIALS_ID VARCHAR(10) NOT NULL,
MATERIALS_NAME VARCHAR(30) NOT NULL,
AMOUNT INT NOT NULL DEFAULT 0,
W_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
MATERIALS_EID VARCHAR(10) NOT NULL,
PRIMARY KEY (MATERIALS_ID),
FOREIGN KEY (MATERIALS_ID, MATERIALS_NAME, W_DATE) REFERENCES MATERIALS (MATERIALS_ID, MATERIALS_NAME, W_DATE)
);

#11. 구매 테이블 쿼리
CREATE TABLE PURCHASE(
MATERIALS_ID VARCHAR(10) NOT NULL,
SELLER_BID VARCHAR(10) NOT NULL,
P_AMOUNT INT NOT NULL DEFAULT 0,
P_UNIT_PRICE INT NOT NULL DEFAULT 0,
P_PRICE INT NOT NULL DEFAULT 0,
D_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
PURCHASE_EID VARCHAR(10),
PURCHASE_CODE VARCHAR(10) NOT NULL,
PRIMARY KEY (MATERIALS_ID, P_AMOUNT, P_UNIT_PRICE, D_DATE),
FOREIGN KEY (MATERIALS_ID) REFERENCES MATERIALS (MATERIALS_ID),
FOREIGN KEY (SELLER_BID) REFERENCES ACCOUNT_LIST (ACCOUNT_BID),
FOREIGN KEY (PURCHASE_EID) REFERENCES EMPLOYEE (EID)
);

#12. 판매 테이블 쿼리
CREATE TABLE SALE(
SALE_CODE VARCHAR(10) NOT NULL,
VENDOR_BID VARCHAR(10) NOT NULL,
PRODUCT_ID VARCHAR(10) NOT NULL,
S_AMOUNT INT NOT NULL DEFAULT 0,
S_UNIT_PRICE INT NOT NULL DEFAULT 0,
S_PRICE INT NOT NULL DEFAULT 0,
D_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
SALE_EID VARCHAR(10),
PRIMARY KEY (SALE_CODE, S_AMOUNT, S_UNIT_PRICE, D_DATE),
FOREIGN KEY (SALE_CODE, S_UNIT_PRICE) REFERENCES UNIT_SALE_PRICE (SALE_CODE, S_UNIT_PRICE),
FOREIGN KEY (VENDOR_BID) REFERENCES ACCOUNT_LIST (ACCOUNT_BID),
FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
FOREIGN KEY (SALE_EID) REFERENCES EMPLOYEE (EID)
);

#13. 제품창고 테이블 쿼리
CREATE TABLE PRODUCT_WAREHOUSE(
PRODUCT_ID VARCHAR(10) NOT NULL,
PRODUCT_NAME VARCHAR(30) NOT NULL,
AMOUNT INT NOT NULL DEFAULT 0,
P_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
PRODUCT_EID VARCHAR(10) NOT NULL,
PRIMARY KEY (PRODUCT_ID),
FOREIGN KEY (PRODUCT_ID, PRODUCT_NAME, P_DATE) REFERENCES PRODUCT (PRODUCT_ID, PRODUCT_NAME, P_DATE),
FOREIGN KEY (PRODUCT_EID) REFERENCES EMPLOYEE (EID)
);

#14. 재고수불부 테이블 쿼리
CREATE TABLE INVENTORY_RECEIPTS(
D_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
P_AMOUNT INT NOT NULL DEFAULT 0,
P_UNIT_PRICE INT NOT NULL DEFAULT 0,
P_PRICE INT NOT NULL DEFAULT 0,
S_AMOUNT INT NOT NULL DEFAULT 0,
S_UNIT_PRICE INT NOT NULL DEFAULT 0,
S_PRICE INT NOT NULL DEFAULT 0,
SALE_CODE VARCHAR(10) NOT NULL,
STOCK_AMOUNT INT NOT NULL DEFAULT 0,
STOCK_UNIT_PRICE INT NOT NULL DEFAULT 0,
STOCK_PRICE INT NOT NULL DEFAULT 0,
DESCRIPTION	VARCHAR(50),
PRIMARY KEY (D_DATE)
-- FOREIGN KEY (SALE_CODE, STOCK_UNIT_PRICE) REFERENCES UNIT_SALE_PRICE (SALE_CODE, S_UNIT_PRICE),
-- FOREIGN KEY (SALE_CODE, S_AMOUNT, S_UNIT_PRICE, D_DATE) REFERENCES SALE (SALE_CODE, S_AMOUNT, S_UNIT_PRICE, D_DATE),
-- FOREIGN KEY (P_AMOUNT, P_UNIT_PRICE, STOCK_UNIT_PRICE, D_DATE) REFERENCES PURCHASE (P_AMOUNT, P_UNIT_PRICE, P_UNIT_PRICE, D_DATE)
-- FOREIGN KEY (STOCK_AMOUNT) REFERENCES PRODUCT_WAREHOUSE (AMOUNT),
-- FOREIGN KEY (STOCK_AMOUNT) REFERENCES MATERIALS_WAREHOUSE (AMOUNT) 
);

#15. 테이블 삭제 쿼리
drop table PRODUCT;
drop table ITEMS_SORTING_CODE;
drop table MATERIALS;
drop table MATERIALS_USE;
drop table ACCOUNT_LIST;
drop table UNIT_SALE_PRICE;
drop table DEPARTMENT;
drop table SALARY_CLASS;
drop table EMPLOYEE;
drop table MATERIALS_WAREHOUSE;
drop table PURCHASE;
drop table SALE;
drop table PRODUCT_WAREHOUSE;
drop table INVENTORY_RECEIPTS;