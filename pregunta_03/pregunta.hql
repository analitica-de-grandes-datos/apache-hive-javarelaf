/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Escriba una consulta que devuelva los cinco valores diferentes más pequeños 
de la tercera columna.

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/
DROP TABLE IF EXISTS data;

CREATE TABLE data (letras     STRING,
                   fecha      STRING,
                   numero     INT)
ROW FORMAT SERDE
    'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   'separatorChar' = "\t",
   'quoteChar'     = '\'',
   'escapeChar'    = "\\");

LOAD DATA LOCAL INPATH 'data.tsv' OVERWRITE INTO TABLE data;

INSERT OVERWRITE LOCAL DIRECTORY 'output/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT  numero FROM data GROUP BY numero ORDER BY cast(numero as int) asc LIMIT 5;

