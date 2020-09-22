-- NOT EXISTS * 2
SELECT 교과목명
FROM 교과목
WHERE NOT EXISTS ( SELECT 학생.학번 FROM 학생 WHERE
				   NOT EXISTS ( SELECT 이수.학번 FROM 이수
										WHERE 교과목.교과목번호 = 이수.교과목번호
										AND 학생.학번 = 이수.학번));

-- NOT EXISTS, NOT IN
SELECT *
FROM 교과목
WHERE NOT EXISTS ( SELECT 학생.학번 FROM 학생 WHERE 학번
					NOT IN ( SELECT 학번 FROM 이수 WHERE 이수.교과목번호 = 교과목.교과목번호 ));



-- 2번 1번째 풀이
SELECT 성명
FROM 학생
WHERE NOT EXISTS ( SELECT * FROM 교과목 A WHERE 학과명='소프트웨어개발과'
											AND	NOT EXISTS 
					(SELECT * FROM 이수 B WHERE A.교과목번호 = B.교과목번호
											AND B. 학번=학생.학번));

--2번 2번째 풀이
SELECT *
FROM 학생
WHERE NOT EXISTS ( SELECT * FROM 교과목 WHERE 학과명='소프트웨어개발과'
					AND 교과목번호 NOT IN ( SELECT 교과목번호
											FROM 이수
											WHERE 학생.학번=이수.학번) );
