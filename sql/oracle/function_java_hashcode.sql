------------------------------------------------------------
-- Oracle function to calculate a Java hashCode from String
-- test: select FUNC_JAVA_HASHCODE('test') from dual;
-- result: 3556498
------------------------------------------------------------
create or replace FUNCTION FUNC_JAVA_HASHCODE(
         F_PARAMETER       IN VARCHAR2
        ) RETURN VARCHAR2 AS

        v_length             INTEGER;
        v_hash_temp          CHAR(1);
        v_hash               INTEGER;
        v_mnumber            NUMBER;

    BEGIN
    v_length   := LENGTH(F_PARAMETER);
    v_hash     :=0;
    v_mnumber  :=31;

    FOR rec in 1 .. v_length  LOOP
        v_hash_temp := substr(F_PARAMETER,rec,1);
        v_hash := v_mnumber *  v_hash + ASCII(v_hash_temp);
        while v_hash > 2147483647 OR   v_hash <  -2147483648 LOOP
            IF v_hash > 2147483647
            THEN
                v_hash := v_hash - 4294967296;
            ELSIF v_hash <  -2147483648
            THEN
                v_hash := v_hash + 4294967296;
            END IF;
        END LOOP;
    END LOOP;
    IF (v_hash < 0 ) THEN
        v_hash := v_hash * (-1);
    END IF;

    RETURN (v_hash);
END FUNC_JAVA_HASHCODE;