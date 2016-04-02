-- SELECT DISTINCT SUBSTR(PHONE,4,4) AS PHONE_AREACODE FROM cop.qyw_4th_user WHERE PHONE is not null;
-- SELECT DISTINCT LEFT(PHONE,7) AS PHONE_PREFIX FROM cop.qyw_4th_user WHERE PHONE is not null;
-- INSERT INTO cop.qyw_4th_area SELECT DISTINCT LEFT(PHONE,7) AS PHONE_PREFIX, SUBSTR(PHONE,4,4) AS PHONE_AREACODE, '' AS AREA FROM cop.qyw_4th_user WHERE PHONE is not null;

-- error correct
-- UPDATE cop.qyw_4th_area SET PHONE_AREACODE = RIGHT(PHONE_PREFIX,4);

-- SELECT USER_ID, GENDER, BIRTHDAY, REGISTER_DATE, PHONE, SUBSTRING_INDEX(AREA,' ',1) AS PROVINCE, SUBSTRING_INDEX(AREA, ' ', -1) AS CITY FROM cop.qyw_4th_user INNER JOIN cop.qyw_4th_area ON LEFT(PHONE, 7) = PHONE_PREFIX;

-- UPDATE cop.qyw_4th_user INNER JOIN cop.qyw_4th_area ON LEFT(PHONE, 7) = PHONE_PREFIX SET PROVINCE = SUBSTRING_INDEX(AREA,' ',1), CITY = SUBSTRING_INDEX(AREA,' ',-1);

-- SELECT * FROM (SELECT * FROM qyw.qyw_4th_visit WHERE HOSPITAL_ID = '270001' AND USER_ID > 0 ORDER BY USER_ID) AS t1 INNER JOIN (SELECT * FROM qyw.qyw_4th_user ORDER BY USER_ID) AS t2 ON t1.USER_ID = t2.USER_ID ORDER BY VISIT_TIME;

-- SELECT * FROM (SELECT * FROM qyw.qyw_4th_visit WHERE HOSPITAL_ID = '5510002' AND USER_ID > 0 ORDER BY USER_ID) AS t1 INNER JOIN (SELECT * FROM qyw.qyw_4th_user ORDER BY USER_ID) AS t2 ON t1.USER_ID = t2.USER_ID ORDER BY VISIT_TIME;

-- SELECT * FROM (SELECT * FROM qyw.qyw_4th_visit WHERE USER_ID > 0 ORDER BY USER_ID) AS t1 INNER JOIN (SELECT * FROM qyw.qyw_4th_user ORDER BY USER_ID) AS t2 ON t1.USER_ID = t2.USER_ID ORDER BY VISIT_TIME;

-- 上面两个SQL可以发现所有的记录都在USER表中找到对应（因为user表是选取了distinct user_id的，下面两个SQL可以证明），但是反之不能证明

-- SELECT COUNT(DISTINCT USER_ID) FROM qyw.qyw_4th_user;

-- SELECT COUNT(*) FROM qyw.qyw_4th_user;

-- SELECT PROVINCE, CITY, COUNT(DISTINCT USER_ID) AS USER_CNT FROM (SELECT * FROM (SELECT * FROM qyw.qyw_4th_visit WHERE USER_ID > 0 ORDER BY USER_ID) AS t1 INNER JOIN (SELECT USER_ID AS CUS_ID, PROVINCE, CITY, BIRTHDAY, GENDER, REGISTER_DATE FROM qyw.qyw_4th_user ORDER BY CUS_ID) AS t2 ON t1.USER_ID = t2.CUS_ID) AS t3 WHERE PROVINCE IS NOT null AND CITY IS NOT null GROUP BY PROVINCE, CITY ORDER BY USER_CNT DESC;

-- SELECT HOSPITAL_ID, PROVINCE, CITY, COUNT(DISTINCT USER_ID) AS USER_CNT FROM (SELECT * FROM (SELECT * FROM qyw.qyw_4th_visit WHERE USER_ID > 0 ORDER BY USER_ID) AS t1 INNER JOIN (SELECT USER_ID AS CUS_ID, PROVINCE, CITY, BIRTHDAY, GENDER, REGISTER_DATE FROM qyw.qyw_4th_user ORDER BY CUS_ID) AS t2 ON t1.USER_ID = t2.CUS_ID) AS t3 WHERE PROVINCE IS NOT null AND CITY IS NOT null GROUP BY HOSPITAL_ID, PROVINCE, CITY ORDER BY HOSPITAL_ID, USER_CNT DESC;

-- SELECT PUBLIC_SERVICE_TYPE, COUNT(DISTINCT USER_ID) AS USER_CNT FROM qyw.qyw_4th_visit WHERE PUBLIC_SERVICE_TYPE IS NOT null GROUP BY PUBLIC_SERVICE_TYPE;

-- SELECT CONCAT_WS('@', IF(t2.PUBLIC_SERVICE_MEAN IS null, '其他渠道', t2.PUBLIC_SERVICE_MEAN), t1.PUBLIC_SERVICE_TYPE) AS PUBLIC_SERVICE_TYPE, USER_CNT FROM (SELECT PUBLIC_SERVICE_TYPE, COUNT(DISTINCT USER_ID) AS USER_CNT FROM qyw.qyw_4th_visit WHERE PUBLIC_SERVICE_TYPE IS NOT null GROUP BY PUBLIC_SERVICE_TYPE) AS t1 LEFT JOIN (SELECT * FROM qyw.qyw_4th_public_service_type) AS t2 ON t1.PUBLIC_SERVICE_TYPE = t2.PUBLIC_SERVICE_TYPE;

-- Every Second
-- SELECT SUBSTRING_INDEX(VISIT_TIME,' ',-1) AS VISIT_TIME, COUNT(*) AS CNT FROM qyw.qyw_4th_visit GROUP BY SUBSTRING_INDEX(VISIT_TIME,' ',-1) ORDER BY VISIT_TIME;

-- Every Minute
-- SELECT CONCAT_WS(':',SUBSTRING_INDEX(SUBSTRING_INDEX(VISIT_TIME,' ',-1),':',2),'00') AS VISIT_TIME, COUNT(*) AS CNT FROM qyw.qyw_4th_visit GROUP BY SUBSTRING_INDEX(SUBSTRING_INDEX(VISIT_TIME,' ',-1),':',2) ORDER BY VISIT_TIME;

-- Every Day Every Second
-- SELECT VISIT_TIME, COUNT(*) AS CNT FROM qyw.qyw_4th_visit GROUP BY VISIT_TIME ORDER BY VISIT_TIME;

-- Every Day Every Minute
-- SELECT CONCAT_WS(':',SUBSTRING_INDEX(VISIT_TIME,':',2),'00') AS VISIT_TIME, COUNT(*) AS CNT FROM qyw.qyw_4th_visit GROUP BY SUBSTRING_INDEX(VISIT_TIME,':',2) ORDER BY VISIT_TIME; 

-- Every Second
-- SELECT SUBSTRING_INDEX(VISIT_TIME,' ',-1) AS VISIT_TIME, COUNT(DISTINCT USER_ID) AS CNT FROM qyw.qyw_4th_visit GROUP BY SUBSTRING_INDEX(VISIT_TIME,' ',-1) ORDER BY VISIT_TIME;

-- Every Minute
-- SELECT CONCAT_WS(':',SUBSTRING_INDEX(SUBSTRING_INDEX(VISIT_TIME,' ',-1),':',2),'00') AS VISIT_TIME, COUNT(DISTINCT USER_ID) AS CNT FROM qyw.qyw_4th_visit GROUP BY SUBSTRING_INDEX(SUBSTRING_INDEX(VISIT_TIME,' ',-1),':',2) ORDER BY VISIT_TIME;

-- Every Day Every Second
-- SELECT VISIT_TIME, COUNT(DISTINCT USER_ID) AS CNT FROM qyw.qyw_4th_visit GROUP BY VISIT_TIME ORDER BY VISIT_TIME;

-- Every Day Every Minute
-- SELECT CONCAT_WS(':',SUBSTRING_INDEX(VISIT_TIME,':',2),'00') AS VISIT_TIME, COUNT(DISTINCT USER_ID) AS CNT FROM qyw.qyw_4th_visit GROUP BY SUBSTRING_INDEX(VISIT_TIME,':',2) ORDER BY VISIT_TIME; 

-- SELECT * FROM (SELECT * FROM qyw.qyw_4th_visit_pay WHERE AMOUNT IS NOT null) AS t1 INNER JOIN (SELECT DISTINCT VISIT_TIME, USER_ID FROM qyw.qyw_4th_visit_pay WHERE AMOUNT IS NOT null) AS t2 ON t1.USER_ID = t2.USER_ID AND t1.VISIT_TIME = t2.VISIT_TIME;

-- SELECT * FROM qyw.qyw_4th_visit_pay WHERE AMOUNT IS NOT null;

-- INSERT INTO qyw.qyw_4th_visit_pay_base SELECT * FROM qyw.qyw_4th_visit_pay WHERE AMOUNT IS NOT null;

-- UPDATE qyw.qyw_4th_visit_pay_base SET VISIT_OP = REPLACE(VISIT_OP, 'http://app.quyiyuan.com:8888', '');

-- UPDATE qyw.qyw_4th_visit_pay_base SET VISIT_OP = REPLACE(VISIT_OP, 'http://100.98.41.195:8888', '');

-- UPDATE qyw.qyw_4th_visit_pay_base SET VISIT_OP = REPLACE(VISIT_OP, 'http://app.quyiyuan.com:8888', '');

-- UPDATE qyw.qyw_4th_visit_pay_base SET VISIT_OP = REPLACE(VISIT_OP, 'http://luoyang.quyiyuan.com:8888', '');

-- SELECT t2.CATEGORIES, COUNT(*) AS CAT_CNT FROM qyw.qyw_4th_visit_pay_base AS t1 INNER JOIN (SELECT VISIT_OP, GROUP_CONCAT(MEAN) AS MEANS, GROUP_CONCAT(CATEGORY) AS CATEGORIES, COUNT(*) FROM qyw.qyw_4th_business_dict GROUP BY VISIT_OP) AS t2 ON t1.VISIT_OP=t2.VISIT_OP GROUP BY t2.CATEGORIES; 

-- GROUP BY USRE_ID, VISIT_TIME, VISIT_OP or GROUP BY USER_ID, VISIT_TIME ??

-- SELECT t1.USER_ID, t1.HOSPITAL_ID, t1.VISIT_OP, t2.MEANS, t1.VISIT_TIME, t1.AMOUNT, t1.PHONETYPE FROM qyw.qyw_4th_visit_pay_base AS t1 INNER JOIN (SELECT VISIT_OP, GROUP_CONCAT(MEAN) AS MEANS, GROUP_CONCAT(CATEGORY) AS CATEGORIES, COUNT(*) FROM qyw.qyw_4th_business_dict GROUP BY VISIT_OP) AS t2 ON t1.VISIT_OP = t2.VISIT_OP ORDER BY t1.USER_ID, t1.VISIT_TIME, t1.VISIT_OP;

-- SELECT t1.USER_ID, t1.VISIT_TIME, t1.VISIT_OP, t2.MEANS, COUNT(*) AS VISIT_CNT, AVG(AMOUNT) AS AVG FROM qyw.qyw_4th_visit_pay_base AS t1 INNER JOIN (SELECT VISIT_OP, GROUP_CONCAT(MEAN) AS MEANS, GROUP_CONCAT(CATEGORY) AS CATEGORIES, COUNT(*) FROM qyw.qyw_4th_business_dict GROUP BY VISIT_OP) AS t2 ON t1.VISIT_OP=t2.VISIT_OP GROUP BY t1.USER_ID, t1.VISIT_TIME ORDER BY t1.USER_ID, t1.VISIT_TIME, t1.VISIT_OP;

-- Best solution
-- SELECT t1.USER_ID, t1.VISIT_TIME, COUNT(*) AS VISIT_CNT, AVG(AMOUNT) AS TOTAL FROM qyw.qyw_4th_visit_pay_base AS t1 INNER JOIN (SELECT VISIT_OP, GROUP_CONCAT(MEAN) AS MEANS, GROUP_CONCAT(CATEGORY) AS CATEGORIES, COUNT(*) FROM qyw.qyw_4th_business_dict GROUP BY VISIT_OP) AS t2 ON t1.VISIT_OP=t2.VISIT_OP GROUP BY t1.USER_ID, t1.VISIT_TIME, t1.VISIT_OP ORDER BY t1.USER_ID, t1.VISIT_TIME, t1.VISIT_OP;

-- ?? over

-- SELECT VISIT_OP, GROUP_CONCAT(MEAN) AS MEANS, GROUP_CONCAT(CATEGORY), COUNT(*) FROM qyw.qyw_4th_business_dict GROUP BY VISIT_OP;

-- SELECT t1.USER_ID, t1.VISIT_TIME, t2.MEANS, COUNT(*) AS VISIT_CNT, AVG(AMOUNT) AS AVG FROM qyw.qyw_4th_visit_pay_base AS t1 INNER JOIN (SELECT VISIT_OP, GROUP_CONCAT(MEAN) AS MEANS, GROUP_CONCAT(CATEGORY) AS CATEGORIES, COUNT(*) FROM qyw.qyw_4th_business_dict GROUP BY VISIT_OP) AS t2 ON t1.VISIT_OP=t2.VISIT_OP GROUP BY t1.USER_ID, t1.VISIT_TIME, t1.VISIT_OP ORDER BY t1.USER_ID, t1.VISIT_TIME;

-- SELECT t2.MEANS, COUNT(*) AS OP_CNT FROM qyw.qyw_4th_visit_pay_base AS t1 INNER JOIN (SELECT VISIT_OP, GROUP_CONCAT(MEAN) AS MEANS, GROUP_CONCAT(CATEGORY) AS CATEGORIES, COUNT(*) FROM qyw.qyw_4th_business_dict GROUP BY VISIT_OP) AS t2 ON t1.VISIT_OP=t2.VISIT_OP GROUP BY t1.VISIT_OP; 

-- SELECT MEANS, SUM(VISIT_CNT) FROM (SELECT t1.USER_ID, t1.VISIT_TIME, t2.MEANS, COUNT(*) AS VISIT_CNT, AVG(AMOUNT) AS AVG FROM qyw.qyw_4th_visit_pay_base AS t1 INNER JOIN (SELECT VISIT_OP, GROUP_CONCAT(MEAN) AS MEANS, GROUP_CONCAT(CATEGORY) AS CATEGORIES, COUNT(*) FROM qyw.qyw_4th_business_dict GROUP BY VISIT_OP) AS t2 ON t1.VISIT_OP=t2.VISIT_OP GROUP BY t1.USER_ID, t1.VISIT_TIME, t1.VISIT_OP) AS t3 GROUP BY t3.MEANS;

SELECT t1.USER_ID, t1.VISIT_TIME, t2.MEANS, COUNT(*) AS VISIT_CNT, AVG(AMOUNT) AS AVG FROM qyw.qyw_4th_visit_pay_base AS t1 INNER JOIN (SELECT VISIT_OP, GROUP_CONCAT(MEAN) AS MEANS, GROUP_CONCAT(CATEGORY) AS CATEGORIES, COUNT(*) FROM qyw.qyw_4th_business_dict GROUP BY VISIT_OP) AS t2 ON t1.VISIT_OP=t2.VISIT_OP GROUP BY t1.USER_ID, t1.VISIT_TIME, t1.VISIT_OP;