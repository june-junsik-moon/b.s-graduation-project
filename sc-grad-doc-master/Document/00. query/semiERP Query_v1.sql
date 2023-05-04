#0. DATABASE 생성 쿼리
CREATE DATABASE semiERP;
USE semiERP;

#1. 제품 테이블 쿼리
CREATE TABLE PRODUCT(
PRODUCT_ID VARCHAR(10) NOT NULL,
PRODUCT_NAME VARCHAR(30) NOT NULL,
AMOUNT INT(20) NOT NULL DEFAULT 0,
P_PRICE INT(30) NOT NULL DEFAULT 0,
P_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
CONSTRAINT PROD_PID_PK PRIMARY KEY (PRODUCT_ID)
);

#2. 품목코드 테이블 쿼리
CREATE TABLE ITEMS_SORTING_CODE(
SORT_ID VARCHAR(10) NOT NULL,
SORT_NAME VARCHAR(30) NOT NULL,
PRODUCT_ID VARCHAR(10) NOT NULL,
PRODUCT_NAME VARCHAR(30) NOT NULL,
P_FACTORY VARCHAR(30) NOT NULL,
CONSTRAINT ITEM_SID_PK PRIMARY KEY (SORT_ID),
CONSTRAINT PROD_PID_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
CONSTRAINT PROD_PNAME_FK FOREIGN KEY (PRODUCT_NAME) REFERENCES PRODUCT (PRODUCT_NAME)
);

#3. 자재 테이블 쿼리
CREATE TABLE MATERIALS(
MATERIALS_ID VARCHAR(10) NOT NULL,
MATERIALS_NAME VARCHAR(30) NOT NULL,
AMOUNT INT(20) NOT NULL DEFAULT 0,
PRODUCT_ID VARCHAR(10) NOT NULL,
W_UNIT_PRICE INT(30) NOT NULL,
W_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
CONSTRAINT MAT_MID_PK PRIMARY KEY (MATERIALS_ID),
CONSTRAINT PROD_PID_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
);

#4. 자재 사용 테이블 쿼리
CREATE TABLE MATERIALS_USE(
MATERIALS_ID VARCHAR(10) NOT NULL,
MATERIALS_NAME VARCHAR(30) NOT NULL,
USED_AMOUNT INT(20) NOT NULL DEFAULT 0,
USED_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
CONSTRAINT MAT_USE_MID_PK PRIMARY KEY (MATERIALS_ID),
CONSTRAINT MAT_MID_FK FOREIGN KEY (MATERIALS_ID) REFERENCES MATERIALS (MATERIALS_ID),
CONSTRAINT MAT_MNAME_FK FOREIGN KEY (MATERIALS_NAME) REFERENCES MATERIALS (MATERIALS_NAME)
);

#5. 거래처 목록 테이블 쿼리
CREATE TABLE ACCOUNT_LIST(
ACCOUNT_BID VARCHAR(10) NOT NULL,
BUSINESS_NAME VARCHAR(30) NOT NULL,
CEO VARCHAR(30) NOT NULL,
ADDRESS VARCHAR(50),
EMAIL VARCHAR(30),
PHONE_NUMBER INT(20) NOT NULL,
FAX INT(30),
DEAL_TYPE INT(1) NOT NULL DEFAULT 0,
DEAL_ITEM_ID VARCHAR(30) NOT NULL,
CONSTRAINT AC_LIST_BID_PK PRIMARY KEY (ACCOUNT_BID),
CONSTRAINT MAT_MID_FK FOREIGN KEY (DEAL_ITEM_ID) REFERENCES MATERIALS (MATERIALS_ID)
);

#6. 판매 단가 테이블 쿼리
CREATE TABLE UNIT_SALE_PRICE(
SALE_CODE VARCHAR(10) NOT NULL,
STORE_BID VARCHAR(10) NOT NULL,
PRODUCT_ID VARCHAR(10) NOT NULL,
AMOUNT INT(20) NOT NULL DEFAULT 0,
S_UNIT_PRICE INT(30) NOT NULL DEFAULT 0,
CONSTRAINT UNIT_S_CODE_PK PRIMARY KEY (SALE_CODE),
CONSTRAINT AC_LIST_AC_BID_FK FOREIGN KEY (STORE_BID) REFERENCES ACCOUNT_LIST (ACCOUNT_BID),
CONSTRAINT PROD_PID_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
);

#7. 부서 테이블 쿼리
CREATE TABLE DEPARTMENT(
D_ID VARCHAR(4) NOT NULL,
D_NAME VARCHAR(20) NOT NULL,
CONSTRAINT DEPARTMENT_ID_PK PRIMARY KEY (D_ID)
);

#8. 호봉 테이블 쿼리
CREATE TABLE SALARY_CLASS(
P_SALARY_CODE VARCHAR(10) NOT NULL,
SALARY INT(30) NOT NULL DEFAULT 0,
CONSTRAINT SALARY_CLASS_PK PRIMARY KEY (P_SALARY_CODE)
);

#9. 사원 테이블 쿼리
CREATE TABLE EMPLOYEE(
EID VARCHAR(10) NOT NULL,
E_NAME VARCHAR(20) NOT NULL,
PASSWORD INT(10) NOT NULL DEFAULT 0000,
D_ID VARCHAR(4) NOT NULL,
POSITION VARCHAR(10) NOT NULL,
PHONE_NUMBER INT(12) DEFAULT '000-0000-0000',
SALARY INT(30) DEFAULT 0,
JOIN_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
CONSTRAINT EMPOYEE_ID_PK PRIMARY KEY (EID),
CONSTRAINT DEPARTMENT_DID_FK FOREIGN KEY (D_ID) REFERENCES DEPARTMENT (D_ID),
CONSTRAINT SALARY_FK FOREIGN KEY (SALARY) REFERENCES SALARY_CLASS (SALARY)
);

#10. 자재 창고 테이블 쿼리
CREATE TABLE MATERIALS_WAREHOUSE(
MATERIALS_ID VARCHAR(10) NOT NULL,
MATERIALS_NAME VARCHAR(30) NOT NULL,
AMOUNT INT(20) NOT NULL DEFAULT 0,
W_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
MATERIALS_EID VARCHAR(10) NOT NULL,
CONSTRAINT MAT_WAREHOUSE_PK PRIMARY KEY (MATERIALS_ID),
CONSTRAINT MAT_MID_FK FOREIGN KEY (MATERIALS_ID) REFERENCES MATERIALS (MATERIALS_ID),
CONSTRAINT MAT_MNAME_FK FOREIGN KEY (MATERIALS_NAME) REFERENCES MATERIALS (MATERIALS_NAME),
CONSTRAINT MAT_PDATE_FK FOREIGN KEY (W_DATE) REFERENCES MATERIALS (W_DATE)
);

#11. 구매 테이블 쿼리
CREATE TABLE PURCHASE(
MATERIALS_ID VARCHAR(10) NOT NULL,
SELLER_BID VARCHAR(10) NOT NULL,
P_AMOUNT INT(20) NOT NULL DEFAULT 0,
P_UNIT_PRICE INT(30) NOT NULL DEFAULT 0,
P_PRICE INT(30) NOT NULL DEFAULT 0,
D_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
PURCHASE_EID VARCHAR(10),
PURCHASE_CODE VARCHAR(10) NOT NULL,
CONSTRAINT PURCHASE_MID_PK PRIMARY KEY (MATERIALS_ID),
CONSTRAINT MAT_MID_FK FOREIGN KEY (MATERIALS_ID) REFERENCES MATERIALS (MATERIALS_ID),
CONSTRAINT AC_LIST_AC_BID_FK FOREIGN KEY (SELLER_BID) REFERENCES ACCOUNT_LIST (ACCOUNT_BID),
CONSTRAINT EMPLOYEE_EID_FK FOREIGN KEY (PURCHASE_EID) REFERENCES EMPLOYEE (EID)
);

#12. 판매 테이블 쿼리
CREATE TABLE SALE(
SALE_CODE VARCHAR(10) NOT NULL,
VENDOR_BID VARCHAR(10) NOT NULL,
PRODUCT_ID VARCHAR(10) NOT NULL,
S_AMOUNT INT(20) NOT NULL DEFAULT 0,
S_UNIT_PRICE INT(30) NOT NULL DEFAULT 0,
S_PRICE INT(30) NOT NULL DEFAULT 0,
D_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
SALE_EID VARCHAR(10),
CONSTRAINT SALE_S_CODE_PK PRIMARY KEY (SALE_CODE),
CONSTRAINT UNIT_S_CODE_FK FOREIGN KEY (SALE_CODE) REFERENCES UNIT_SALE_PRICE (SALE_CODE),
CONSTRAINT AC_LIST_AC_BID_FK FOREIGN KEY (VENDOR_BID) REFERENCES ACCOUNT_LIST (ACCOUNT_BID),
CONSTRAINT PROD_PID_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
CONSTRAINT UNIT_S_PRICE_FK FOREIGN KEY (S_UNIT_PRICE) REFERENCES UNIT_SALE_PRICE (S_UNIT_PRICE),
CONSTRAINT EMPLOYEE_EID_FK FOREIGN KEY (SALE_EID) REFERENCES EMPLOYEE (EID)
);

#13. 제품창고 테이블 쿼리
CREATE TABLE PRODUCT_WAREHOUSE(
PRODUCT_ID VARCHAR(10) NOT NULL,
PRODUCT_NAME VARCHAR(30) NOT NULL,
AMOUNT INT(20) NOT NULL DEFAULT 0,
P_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
PRODUCT_EID VARCHAR(10) NOT NULL,
CONSTRAINT P_WAREHOUSE_PID_PK PRIMARY KEY (PRODUCT_ID),
CONSTRAINT PROD_PID_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
CONSTRAINT PROD_PNAME_FK FOREIGN KEY (PRODUCT_NAME) REFERENCES PRODUCT (PRODUCT_NAME),
CONSTRAINT PROD_PDATE_FK FOREIGN KEY (P_DATE) REFERENCES PRODUCT (P_DATE),
CONSTRAINT EMPLOYEE_EID_FK FOREIGN KEY (PRODUCT_EID) REFERENCES EMPLOYEE (EID)
);

#14. 재고수불부 테이블 쿼리
CREATE TABLE INVENTORY_RECEIPTS(
D_DATE VARCHAR(10) NOT NULL DEFAULT '0000-00-00',
P_AMOUNT INT(20) NOT NULL DEFAULT 0,
P_UNIT_PRICE INT(30) NOT NULL DEFAULT 0,
P_PRICE INT(30) NOT NULL DEFAULT 0,
S_AMOUNT INT(20) NOT NULL DEFAULT 0,
S_UNIT_PRICE INT(30) NOT NULL DEFAULT 0,
S_PRICE INT(30) NOT NULL DEFAULT 0,
STOCK_AMOUNT INT(20) NOT NULL DEFAULT 0,
STOCK_UNIT_PRICE INT(30) NOT NULL DEFAULT 0,
STOCK_PRICE INT(30) NOT NULL DEFAULT 0,
DESCRIPTION	VARCHAR(50),
CONSTRAINT I_RECEIPTS_D_DATE_PK PRIMARY KEY (D_DATE),
CONSTRAINT UNIT_S_PRICE_FK FOREIGN KEY (STOCK_UNIT_PRICE) REFERENCES UNIT_SALE_PRICE (S_UNIT_PRICE),
CONSTRAINT SALE_DATE_FK FOREIGN KEY (D_DATE) REFERENCES SALE (D_DATE),
CONSTRAINT SALE_AMOUNT_FK FOREIGN KEY (S_AMOUNT) REFERENCES SALE (S_AMOUNT),
CONSTRAINT SALE_U_PRICE_FK FOREIGN KEY (S_UNIT_PRICE) REFERENCES SALE (S_UNIT_PRICE),
CONSTRAINT PURCHASE_AMOUNT_FK FOREIGN KEY (P_AMOUNT) REFERENCES PURCHASE (P_AMOUNT),
CONSTRAINT PURCHASE_AMOUNT_FK FOREIGN KEY (P_UNIT_PRICE) REFERENCES PURCHASE (P_UNIT_PRICE),
CONSTRAINT PURCHASE_AMOUNT_FK FOREIGN KEY (STOCK_UNIT_PRICE) REFERENCES PURCHASE (P_UNIT_PRICE),
CONSTRAINT PURCHASE_AMOUNT_FK FOREIGN KEY (D_DATE) REFERENCES PURCHASE (D_DATE),
CONSTRAINT P_WAREHOUSE_AMOUNT_FK FOREIGN KEY (STOCK_AMOUNT) REFERENCES PRODUCT_WAREHOUSE (AMOUNT),
CONSTRAINT M_WAREHOUSE_AMOUNT_FK FOREIGN KEY (STOCK_AMOUNT) REFERENCES MATERIALS_WAREHOUSE (AMOUNT)
);

#15. 테이블 삭제 쿼리
drop table ACCOUNT_LIST;
drop table ITEMS_SORTING_CODE;
drop table PRODUCT;
drop table MATERIALS;
drop table UNIT_SALE_PRICE;
drop table SALE;
drop table PURCHASE;
drop table PRODUCT_WAREHOUSE;
drop table MATERIALS_WAREHOUSE;
drop table MATERIALS_USE;
drop table INVENTORY_RECEIPTS;
drop table EMPLOYEE;
drop table DEPARTMENT;
drop table SALARY_CLASS;