-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2023-01-15 22:36:40 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



DROP TABLE artista CASCADE CONSTRAINTS;

DROP TABLE client CASCADE CONSTRAINTS;

DROP TABLE "COL.LECCIO" CASCADE CONSTRAINTS;

DROP TABLE distribuidor CASCADE CONSTRAINTS;

DROP TABLE editorial CASCADE CONSTRAINTS;

DROP TABLE factura CASCADE CONSTRAINTS;

DROP TABLE factura_client CASCADE CONSTRAINTS;

DROP TABLE personatge CASCADE CONSTRAINTS;

DROP TABLE personatge_personatge CASCADE CONSTRAINTS;

DROP TABLE premi CASCADE CONSTRAINTS;

DROP TABLE publicacio CASCADE CONSTRAINTS;

DROP TABLE "PUBLICACIO_COL.LECCIO_EDITORIAL" CASCADE CONSTRAINTS;

DROP TABLE publicacio_factura CASCADE CONSTRAINTS;

DROP TABLE publicacio_tiquet CASCADE CONSTRAINTS;

DROP TABLE salo CASCADE CONSTRAINTS;

DROP TABLE tiquet CASCADE CONSTRAINTS;

DROP TABLE ubicacio CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE artista (
    artista_id     NUMBER NOT NULL,
    nom_artistic   VARCHAR2(100),
    nacionalitat   VARCHAR2(100),
    data_naixement DATE,
    nom            VARCHAR2(100)
);

ALTER TABLE artista ADD CONSTRAINT artista_pk PRIMARY KEY ( artista_id );

CREATE TABLE client (
    nif          NUMBER NOT NULL,
    nom          VARCHAR2(100),
    adre�a       VARCHAR2(100),
    poblacio     VARCHAR2(100),
    codi_postal  NUMBER,
    preferencies VARCHAR2(100)
);

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( nif );

CREATE TABLE "COL.LECCIO" (
    titol            VARCHAR2(100) NOT NULL,
    idioma           VARCHAR2(100),
    n_exemplars      NUMBER,
    genere           VARCHAR2(100),
    ambient          VARCHAR2(100),
    "TANCADA/OBERTA" CHAR(1),
    any_inici        NUMBER,
    any_final        NUMBER
);

ALTER TABLE "COL.LECCIO" ADD CONSTRAINT "COL.LECCIO_PK" PRIMARY KEY ( titol );

CREATE TABLE distribuidor (
    nif             VARCHAR2(100) NOT NULL,
    nom             VARCHAR2(100),
    adre�a          VARCHAR2(100),
    poblacio        VARCHAR2(100),
    codi_postal     NUMBER,
    adre�a_contacte VARCHAR2(100)
);

ALTER TABLE distribuidor ADD CONSTRAINT distribuidor_pk PRIMARY KEY ( nif );

CREATE TABLE editorial (
    nom         VARCHAR2(100) NOT NULL,
    adre�a      VARCHAR2(100),
    responsable VARCHAR2(100)
);

ALTER TABLE editorial ADD CONSTRAINT editorial_pk PRIMARY KEY ( nom );

CREATE TABLE factura (
    preu_unitari     NUMBER,
    exemplars        VARCHAR2(100),
    data             DATE,
    preu_total       NUMBER,
    numeracio        NUMBER NOT NULL,
    distribuidor_nif VARCHAR2(100) NOT NULL
);

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( numeracio );

CREATE TABLE factura_client (
    factura_numeracio NUMBER NOT NULL,
    client_nif        NUMBER NOT NULL
);

ALTER TABLE factura_client ADD CONSTRAINT factura_client_pk PRIMARY KEY ( factura_numeracio,
                                                                          client_nif );

CREATE TABLE personatge (
    tipus    VARCHAR2(100),
    genere   VARCHAR2(100),
    caracter VARCHAR2(100),
    nom      VARCHAR2(100) NOT NULL,
    ambient  VARCHAR2(100)
);

ALTER TABLE personatge ADD CONSTRAINT personatge_pk PRIMARY KEY ( nom );

CREATE TABLE personatge_personatge (
    personatge_nom  VARCHAR2(100) NOT NULL,
    personatge_nom1 VARCHAR2(100) NOT NULL
);

ALTER TABLE personatge_personatge ADD CONSTRAINT personatge_personatge_pk PRIMARY KEY ( personatge_nom,
                                                                                        personatge_nom1 );

CREATE TABLE premi (
    tipus       VARCHAR2(100) NOT NULL,
    edicio      VARCHAR2(100) NOT NULL,
    salo_nom    VARCHAR2(100) NOT NULL,
    salo_edicio VARCHAR2(100) NOT NULL
);

ALTER TABLE premi
    ADD CONSTRAINT premi_pk PRIMARY KEY ( tipus,
                                          salo_nom,
                                          edicio );

CREATE TABLE publicacio (
    titol              CHAR 
--  WARNING: CHAR size not specified 
    ,
    isbn               NUMBER NOT NULL,
    autor              VARCHAR2(100),
    preu               NUMBER,
    edicio             VARCHAR2(100),
    n_exemplars        NUMBER,
    idioma             VARCHAR2(100),
    "ANY"              NUMBER,
    tipus              VARCHAR2(100),
    numero             NUMBER,
    personatge_nom     VARCHAR2(100) NOT NULL,
    premi_tipus        VARCHAR2(100) NOT NULL,
    artista_artista_id NUMBER NOT NULL,
    premi_salo_nom     VARCHAR2(100) NOT NULL,
    premi_edicio       VARCHAR2(100) NOT NULL
);

ALTER TABLE publicacio ADD CONSTRAINT publicacio_pk PRIMARY KEY ( isbn );

--  ERROR: Table name length exceeds maximum allowed length(30) 
CREATE TABLE "PUBLICACIO_COL.LECCIO_EDITORIAL" (
    editorial_nom      VARCHAR2(100) NOT NULL,
    "COL.LECCIO_TITOL" VARCHAR2(100) NOT NULL,
    publicacio_isbn    NUMBER NOT NULL
);

COMMENT ON COLUMN "PUBLICACIO_COL.LECCIO_EDITORIAL".publicacio_isbn IS
    'marcar com a pk les que son N
';

--  ERROR: PK name length exceeds maximum allowed length(30) 
ALTER TABLE "PUBLICACIO_COL.LECCIO_EDITORIAL"
    ADD CONSTRAINT "PUBLICACIO_COL.LECCIO_EDITORIAL_PK" PRIMARY KEY ( editorial_nom,
                                                                      "COL.LECCIO_TITOL",
                                                                      publicacio_isbn );

CREATE TABLE publicacio_factura (
    publicacio_isbn   NUMBER NOT NULL,
    factura_numeracio NUMBER NOT NULL,
    n_unitats         NUMBER
);

ALTER TABLE publicacio_factura ADD CONSTRAINT publicacio_factura_pk PRIMARY KEY ( publicacio_isbn,
                                                                                  factura_numeracio );

CREATE TABLE publicacio_tiquet (
    publicacio_isbn  NUMBER NOT NULL,
    tiquet_numeracio NUMBER NOT NULL,
    n_unitats        NUMBER
);

ALTER TABLE publicacio_tiquet ADD CONSTRAINT publicacio_tiquet_pk PRIMARY KEY ( publicacio_isbn,
                                                                                tiquet_numeracio );

CREATE TABLE salo (
    nom    VARCHAR2(100) NOT NULL,
    edicio VARCHAR2(100) NOT NULL,
    tipus  VARCHAR2(100)
);

ALTER TABLE salo ADD CONSTRAINT salo_pk PRIMARY KEY ( nom,
                                                      edicio );

CREATE TABLE tiquet (
    numeracio    NUMBER NOT NULL,
    preu_total   NUMBER,
    preu_unitari NUMBER,
    exemplars    VARCHAR2(100),
    data         DATE
);

ALTER TABLE tiquet ADD CONSTRAINT tiquet_pk PRIMARY KEY ( numeracio );

CREATE TABLE ubicacio (
    columna         NUMBER NOT NULL,
    fila            NUMBER NOT NULL,
    estant          NUMBER NOT NULL,
    sala            NUMBER NOT NULL,
    isbn_publicacio unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
    ,
    publicacio_isbn NUMBER NOT NULL
);

ALTER TABLE ubicacio
    ADD CONSTRAINT ubicacio_pk PRIMARY KEY ( columna,
                                             fila,
                                             estant,
                                             sala );

ALTER TABLE factura_client
    ADD CONSTRAINT factura_client_client_fk FOREIGN KEY ( client_nif )
        REFERENCES client ( nif );

ALTER TABLE factura_client
    ADD CONSTRAINT factura_client_factura_fk FOREIGN KEY ( factura_numeracio )
        REFERENCES factura ( numeracio );

ALTER TABLE factura
    ADD CONSTRAINT factura_distribuidor_fk FOREIGN KEY ( distribuidor_nif )
        REFERENCES distribuidor ( nif );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE personatge_personatge
    ADD CONSTRAINT personatge_personatge_personatge_fk FOREIGN KEY ( personatge_nom )
        REFERENCES personatge ( nom );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE personatge_personatge
    ADD CONSTRAINT personatge_personatge_personatge_fkv1 FOREIGN KEY ( personatge_nom1 )
        REFERENCES personatge ( nom );

ALTER TABLE premi
    ADD CONSTRAINT premi_salo_fk FOREIGN KEY ( salo_nom,
                                               salo_edicio )
        REFERENCES salo ( nom,
                          edicio );

ALTER TABLE publicacio
    ADD CONSTRAINT publicacio_artista_fk FOREIGN KEY ( artista_artista_id )
        REFERENCES artista ( artista_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE "PUBLICACIO_COL.LECCIO_EDITORIAL"
    ADD CONSTRAINT "PUBLICACIO_COL.LECCIO_EDITORIAL_COL.LECCIO_FK" FOREIGN KEY ( "COL.LECCIO_TITOL" )
        REFERENCES "COL.LECCIO" ( titol );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE "PUBLICACIO_COL.LECCIO_EDITORIAL"
    ADD CONSTRAINT "PUBLICACIO_COL.LECCIO_EDITORIAL_EDITORIAL_FK" FOREIGN KEY ( editorial_nom )
        REFERENCES editorial ( nom );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE "PUBLICACIO_COL.LECCIO_EDITORIAL"
    ADD CONSTRAINT "PUBLICACIO_COL.LECCIO_EDITORIAL_PUBLICACIO_FK" FOREIGN KEY ( publicacio_isbn )
        REFERENCES publicacio ( isbn );

ALTER TABLE publicacio_factura
    ADD CONSTRAINT publicacio_factura_factura_fk FOREIGN KEY ( factura_numeracio )
        REFERENCES factura ( numeracio );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE publicacio_factura
    ADD CONSTRAINT publicacio_factura_publicacio_fk FOREIGN KEY ( publicacio_isbn )
        REFERENCES publicacio ( isbn );

ALTER TABLE publicacio
    ADD CONSTRAINT publicacio_personatge_fk FOREIGN KEY ( personatge_nom )
        REFERENCES personatge ( nom );

ALTER TABLE publicacio
    ADD CONSTRAINT publicacio_premi_fk FOREIGN KEY ( premi_tipus,
                                                     premi_salo_nom,
                                                     premi_edicio )
        REFERENCES premi ( tipus,
                           salo_nom,
                           edicio );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE publicacio_tiquet
    ADD CONSTRAINT publicacio_tiquet_publicacio_fk FOREIGN KEY ( publicacio_isbn )
        REFERENCES publicacio ( isbn );

ALTER TABLE publicacio_tiquet
    ADD CONSTRAINT publicacio_tiquet_tiquet_fk FOREIGN KEY ( tiquet_numeracio )
        REFERENCES tiquet ( numeracio );

ALTER TABLE ubicacio
    ADD CONSTRAINT ubicacio_publicacio_fk FOREIGN KEY ( publicacio_isbn )
        REFERENCES publicacio ( isbn );

CREATE SEQUENCE artista_artista_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER artista_artista_id_trg BEFORE
    INSERT ON artista
    FOR EACH ROW
    WHEN ( new.artista_id IS NULL )
BEGIN
    :new.artista_id := artista_artista_id_seq.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             0
-- ALTER TABLE                             34
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  10
-- WARNINGS                                 1
