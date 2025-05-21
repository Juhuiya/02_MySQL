-- 1. 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.
    /*
        ----------- 출력 예시 ----------------
        총합
        ---------------------------------------
        17700000
    */
SELECT
    emp_id       AS 사번
     , emp_name     AS 사원명
     , TRUNCATE(
        DATEDIFF(
                NOW(),
                CONCAT(
                        IF(SUBSTR(emp_no, 8, 1) IN (1, 2), 19, 20),
                    LEFT(emp_no, 6)
                    )
        ) / 360, 0
       )            AS 나이
     , b.dept_title AS 부서명
     , c.job_name   AS 직급명
FROM
    employee a
        JOIN department b
             ON a.dept_code = b.dept_id
        JOIN job c ON a.job_code = c.job_code
ORDER BY
    나이
    LIMIT 1;

-- 2. 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 사원명, 부서코드, 급여를 출력하세요.
--    참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임
    /*
        ----------------- 출력 예시 --------------------
        사원번호     사원명     부서코드        급여
        ------------------------------------------------
        206          박나라      D5             1800000
        207          하이유      D5             2200000
        208          김해술      D5             2500000
        209          심봉선      D5             3500000
        210          윤은해      D5             2000000
        215          대북혼      D5             3760000
        203          송은희      D6             2800000
        204          유재식      D6             3400000
        205          정중하      D6             3900000
    */
SELECT
    emp_name     AS 사원명
     , b.job_name   AS 직급명
     , dept_code    AS 부서코드
     , c.dept_title AS 부서명
FROM
    employee a
        JOIN job b USING (job_code)
        JOIN department c ON a.dept_code = c.dept_id
WHERE
    c.dept_title LIKE '해외영업%';
 
-- 3. 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.

    /*
        ----------------- 출력 예시 --------------------
        사원번호    직원명        부서명     급여
        ------------------------------------------------
        206         박나라        해외영업1부  1800000
        207         하이유        해외영업1부  2200000
        208         김해술        해외영업1부  2500000
        209         심봉선        해외영업1부  3500000
        210         윤은해        해외영업1부  2000000
        215         대북혼        해외영업1부  3760000
        203         송은희        해외영업2부  2800000
        204         유재식        해외영업2부  3400000
        205         정중하        해외영업2부  3900000

    */
SELECT
    emp_name     AS 사원명
     , bonus        AS 보너스포인트
     , b.dept_title AS 부서명
     , c.local_name AS 근무지역명
FROM
    employee a
        JOIN department b ON a.dept_code = b.dept_id
        JOIN location c ON b.location_id = c.local_code
WHERE
    bonus IS NOT NULL;

-- 4. 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출하는 쿼리를 작성하세요.
--    2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 사원명, 급여, 부서명, (부서의) 국가명을 출력하세요.
--       단, 국가명 내림차순으로 출력되도록 하세요.

    /*
    ------------------------- 출력 예시 --------------------------
    사원번호        사원명     급여      부서명     (부서의) 국가명
    ---------------------------------------------------------------
    214             방명수     1380000   인사관리부        한국
    216             차태연     2780000   인사관리부        한국
    217             전지연     3660000   인사관리부        한국
    219             임시환     1550000   회계관리부        한국
    220             이중석     2490000   회계관리부        한국
    221             유하진     2480000   회계관리부        한국
    223             고두밋     4480000   회계관리부        한국
    200             선동일     8000000   총무부            한국
    201             송종기     6000000   총무부            한국
    ...
    총 row수 22개

    */
SELECT
    emp_name                                  AS 사원명
     , dept_title                                AS 직급명
     , salary                                    AS 급여
     , (salary + salary * IFNULL(bonus, 0)) * 12 AS 연봉
     , max_sal                                   AS 최대급여
FROM
    employee a
        JOIN department b ON a.dept_code = b.dept_id
        JOIN sal_grade c USING (sal_level)
WHERE
    salary > c.max_sal;













