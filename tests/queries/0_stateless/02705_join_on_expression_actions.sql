
SET allow_experimental_analyzer = 1;

DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;


CREATE TABLE t1 (key String, attr String, a UInt64, b UInt64, c UInt64) ENGINE = Memory;
INSERT INTO t1 VALUES ('key1', 'a', 1, 1, 1), ('key1', 'b', 2, 2, 2), ('key1', 'c', 3, 3, 3), ('key1', 'd', 4, 4, 4), ('key1', 'e', 5, 5, 5), ('key2', 'a2', 1, 1, 1);


CREATE TABLE t2 (key String, attr String, a UInt64, b UInt64, c UInt64) ENGINE = Memory;
INSERT INTO t2 VALUES ('key1', 'A', 1, 1, 1), ('key1', 'B', 2, 2, 2), ('key1', 'C', 3, 3, 3), ('key1', 'D', 4, 4, 4), ('key3', 'a3', 1, 1, 1);

SELECT 'left join';
SELECT t1.attr, t2.attr FROM t1 LEFT JOIN t2 ON (t1.a < t2.a OR lower(t1.attr) == lower(t2.attr)) AND t1.key = t2.key ORDER BY (t1.attr, t1.c);
SELECT 'inner';
SELECT t1.attr, t2.attr FROM t1 JOIN t2 ON (t1.a < t2.a OR lower(t1.attr) == lower(t2.attr)) AND t1.key = t2.key ORDER BY (t1.attr, t1.c);

SELECT count() FROM t1 RIGHT JOIN t2 ON t1.key = t2.key AND t1.a < t2.a; -- { serverError NOT_IMPLEMENTED }
SELECT count() FROM t1 FULL JOIN t2 ON t1.key = t2.key AND t1.a < t2.a; -- { serverError NOT_IMPLEMENTED }
SELECT count() FROM t1 ANY JOIN t2 ON t1.key = t2.key AND t1.a < t2.a; -- { serverError NOT_IMPLEMENTED }
SELECT count() FROM t1 JOIN t2 ON t1.key = t2.key AND t1.a < t2.a SETTINGS join_algorithm = 'partial_merge'; -- { serverError NOT_IMPLEMENTED }
SELECT count() FROM t1 JOIN t2 ON t1.key = t2.key AND t1.a < t2.a SETTINGS join_algorithm = 'grace_hash'; -- { serverError NOT_IMPLEMENTED }
SELECT count() FROM t1 JOIN t2 ON t1.key = t2.key AND t1.a < t2.a SETTINGS join_algorithm = 'full_sorting_merge'; -- { serverError NOT_IMPLEMENTED }
SELECT count() FROM t1 JOIN t2 ON t1.key = t2.key AND t1.a < t2.a SETTINGS join_algorithm = 'parallel_hash'; -- { serverError NOT_IMPLEMENTED }
SELECT count() FROM t1 JOIN t2 ON t1.key = t2.key AND t1.a < t2.a SETTINGS join_algorithm = 'auto'; -- { serverError NOT_IMPLEMENTED }
SELECT count() FROM t1 JOIN t2 ON t1.key = t2.key AND t1.a < t2.a SETTINGS join_algorithm = 'direct'; -- { serverError NOT_IMPLEMENTED }
