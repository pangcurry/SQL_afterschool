# EXISTS,IN,NOT EXISTS, NOT IN 비교

---

![1604396075796](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1604396075796.png)

![1604396115326](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1604396115326.png)

# IN

---

![1604396583523](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1604396583523.png)

```mysql
SELECT * FROM TB_FOOD f
WHERE f.number IN (SELECT c.number FROM TB_COLOR c);
```

- 먼저 TB_COLOR 테이블에 접근하여 number 값들을 가져온다.
- 가져온 정보를 IN 이하에 뿌려준다.
- 그 후, TB_FOOD 에서 하나의 레코드씩 IN 이하의 요소들과 일치하는지 비교한다.



# EXISTS

---

![1604396640360](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1604396640360.png)

```mysql
SELECT * FROM TB_FOOD f
WHERE EXISTS (SELECT c.number FROM TB_COLOR c);
```

- 먼저 TB_FOOD에 접근하여 하나의 레코드를 가져온다.
- 레코드에 대해서 EXISTS 이하의 서브쿼리를 실행한다.
- 서브쿼리에 대한 결과가 '존재하는지' 확인한다.

### 결과가 위처럼 다 나온 이유

- 서브쿼리는 어떠한 레코드하고도 연관이 없기 때문에 항상 결과값을 가진다.

### 수정한 결과

![1604397011725](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1604397011725.png)

```mysql
SELECT * FROM TB_FOOD f
WHERE EXISTS (SELECT c.number FROM TB_COLOR c
              WHERE c.number = f.number);
```



# NOT IN

---

![1604397520622](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1604397520622.png)

```mysql
SELECT * FROM TB_FOOD f
WHERE f.number NOT IN (SELECT c.number FROM TB_COLOR c);
```

- 위의 쿼리는 아무것도 출력되지 않는다.
- 서브쿼리부터 실행되므로 서브쿼리는 (1,2,3,4,5,6,NULL) 이 반환된다.
- NOT IN 구문이므로 소괄호의 요소들과 일치하지 않아야 결과로 반환한다.

```mysql
SELECT * FROM TB_FOOD f
WHERE f.number NOT IN (1,2,3,4,5,6,NULL);
```

- 위 쿼리는 아래 쿼리와 같이 동작한다.

```mysql
SELECT * FROM TB_FOOD f
WHERE f.number != 1
AND f.number != 2
AND f.number != 3
AND f.number != 4
AND f.number != 5
AND f.number != 6
AND f.number != NULL;
```

- number 값이 NULL과 연산을 진행하게 되는데, 이때 NULL과의 비교연산은 항상 UNKNOWN 값을 반환한다.
- 그러므로 WHERE 절 이하는 TRUE가 아니여서 레코드 출력이 안 된다.

### 수정한 쿼리

![1604397970696](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1604397970696.png)

```mysql
SELECT * FROM TB_FOOD f
WHERE f.number NOT IN (SELECT c.number FROM TB_COLOR c
                       WHERE c.number IS NOT NULL);
```



# NOT EXISTS

---

![1604399724321](C:\Users\user\AppData\Roaming\Typora\typora-user-images\1604399724321.png)

```mysql
SELECT * FROM TB_FOOD f
WHERE NOT EXISTS (SELECT c.number FROM TB_COLOR)
```

- 먼저 TB_FOOD에서 레코드를 가져오고 해당 레코드의 number를 NOT EXISTS 이하의 서브쿼리에 전달하여 해당 서브쿼리에서 값이 존재하는지를 확인한다.
- NOT EXISTS 구문이므로 해당 서브쿼리의 값이 존재하지 않으면 레코드를 출력한다.
- NULL에 대한 비교연산은 항상 UNKNOWN 값을 반환하므로 해당 쿼리의 결과가 존재하지 않게 되고, 이에 따라서 [ NULL / 타코 ] 레코드가 출력된다.





