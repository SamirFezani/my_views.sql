CREATE OR REPLACE FORCE EDITIONABLE VIEW "STUDENT28"."ALL_WORKERS" ("LAST_NAME", "FIRST_NAME", "AGE", "START_DATE") AS 
  SELECT last_name, first_name, age, first_day AS start_date
FROM WORKERS_FACTORY_1
WHERE last_day IS NULL
ORDER BY first_day DESC
;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "STUDENT28"."ALL_WORKERS_ELAPSED" ("LAST_NAME", "FIRST_NAME", "AGE", "START_DATE", "DAYS_ELAPSED") AS 
  SELECT last_name, first_name, age, start_date, SYSDATE - start_date AS days_elapsed
FROM ALL_WORKERS
;

CREATE OR REPLACE EDITIONABLE TRIGGER "STUDENT28"."ALL_WORKERS_ELAPSED_TRIGGER" 
INSTEAD OF INSERT OR UPDATE OR DELETE ON ALL_WORKERS_ELAPSED
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Modification de données non autorisée sur la vue ALL_WORKERS_ELAPSED.');
END;

/
ALTER TRIGGER "STUDENT28"."ALL_WORKERS_ELAPSED_TRIGGER" ENABLE;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "STUDENT28"."BEST_SUPPLIERS" ("SUPPLIER_ID", "NAME") AS 
  SELECT s.supplier_id, s.name
FROM SUPPLIERS s
JOIN SUPPLIERS_BRING_TO_FACTORY_1 sbtf1 ON s.supplier_id = sbtf1.supplier_id
GROUP BY s.supplier_id, s.name
HAVING SUM(sbtf1.quantity) > 1000
ORDER BY SUM(sbtf1.quantity) DESC
;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "STUDENT28"."ROBOTS_FACTORIES" ("ROBOT_ID", "FACTORY_LOCATION") AS 
  SELECT r.id AS robot_id, f.main_location AS factory_location
FROM ROBOTS r
JOIN ROBOTS_FROM_FACTORY rf ON r.id = rf.robot_id
JOIN FACTORIES f ON rf.factory_id = f.id
;

