/*Without indexes*/
/*Question 1*/
SELECT COUNT(*)
FROM part_nyc
WHERE on_hand > 70;

/*Question 2*/
SELECT SUM(
	(SELECT COUNT(N.on_hand)
	FROM part_nyc N, color C
	WHERE N.color = C.color_id AND color_name = 'Red')
+
	(SELECT COUNT(S.on_hand)
	FROM part_sfo S, color C
	WHERE S.color = C.color_id AND color_name = 'Red'))
AS red_sum;

/*Question 3*/
SELECT S.supplier_id, S.supplier_name
FROM supplier S
WHERE
	(SELECT SUM(NYC.on_hand)
	FROM part_nyc NYC
	WHERE S.supplier_id = NYC.supplier)
>
	(SELECT SUM(SFO.on_hand)
	FROM part_sfo SFO
	WHERE S.supplier_id = SFO.supplier)
ORDER BY S.supplier_id;

/*Question 4*/
SELECT DISTINCT S.supplier_id, S.supplier_name
FROM supplier S, part_nyc NYC
WHERE S.supplier_id = NYC.supplier AND NYC.part_number IN
	(SELECT NYC1.part_number
	FROM supplier S, part_nyc NYC1
	WHERE S.supplier_id = NYC1.supplier
	EXCEPT
	SELECT SFO.part_number
	FROM supplier S, part_sfo SFO
	WHERE S.supplier_id = SFO.supplier)
ORDER BY S.supplier_id;

/*Question 5*/
UPDATE part_nyc
SET on_hand = on_hand - 10;
WHERE on_hand > 9;

/*Question 6*/
DELETE FROM part_nyc
WHERE on_hand < 30;