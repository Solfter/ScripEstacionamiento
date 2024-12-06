CREATE TABLE espacio_favorito (
    rut_usuario        NUMBER(5) NOT NULL,
    id_estacionamiento NUMBER(3) NOT NULL
);

ALTER TABLE espacio_favorito 
    ADD CONSTRAINT espacio_favorito_pk PRIMARY KEY ( rut_usuario,id_estacionamiento );

CREATE TABLE estacionamiento (
    id_estacionamiento     NUMBER(3) NOT NULL,
    nro_estacionamiento    NUMBER(3) NOT NULL,
    id_est_estacionamiento NUMBER(1) NOT NULL,
    id_sensor              NUMBER(3) NOT NULL,
    id_zona                CHAR(1) NOT NULL
);

ALTER TABLE estacionamiento 
    ADD CONSTRAINT estacionamiento_pk PRIMARY KEY ( id_estacionamiento );

CREATE TABLE estado_estacionamiento (
    id_est_estacionamiento      NUMBER(1) NOT NULL,
    desc_estado_estacionamiento VARCHAR2(20) NOT NULL
);

ALTER TABLE estado_estacionamiento 
    ADD CONSTRAINT estado_estacionamiento_pk PRIMARY KEY ( id_est_estacionamiento );

CREATE TABLE estado_incidente (
    id_estado_incidente   NUMBER NOT NULL,
    desc_estado_incidente VARCHAR2(20) NOT NULL
);

ALTER TABLE estado_incidente 
    ADD CONSTRAINT estado_incidente_pk PRIMARY KEY ( id_estado_incidente );

CREATE TABLE estado_reserva (
    id_tpo_est_reserva   NUMBER(1) NOT NULL,
    id_reserva           NUMBER NOT NULL,
    fecha_estado_reserva DATE
);

ALTER TABLE estado_reserva 
    ADD CONSTRAINT estado_reserva_pk PRIMARY KEY ( id_tpo_est_reserva, id_reserva );

CREATE TABLE feedback (
    id_feedback    NUMBER NOT NULL,
    fecha_feedback DATE NOT NULL,
    desc_feedback  VARCHAR2(300) NOT NULL,
    rut_usuario    NUMBER(5) NOT NULL
);

ALTER TABLE feedback 
    ADD CONSTRAINT feedback_pk PRIMARY KEY ( id_feedback );

CREATE TABLE incidente (
    id_incidente        NUMBER NOT NULL,
    fecha_incidente     DATE NOT NULL,
    descripcion         VARCHAR2(300) NOT NULL,
    id_estado_incidente NUMBER NOT NULL,
    rut_usuario         NUMBER(5) NOT NULL
);

ALTER TABLE incidente 
    ADD CONSTRAINT incidente_pk PRIMARY KEY ( id_incidente );

CREATE TABLE marca (
    id_marca     NUMBER(3) NOT NULL,
    nombre_marca VARCHAR2(50) NOT NULL
);

ALTER TABLE marca 
    ADD CONSTRAINT marca_pk PRIMARY KEY ( id_marca );

CREATE TABLE modelo (
    id_modelo     NUMBER(3) NOT NULL,
    nombre_modelo VARCHAR2(50) NOT NULL,
    id_marca      NUMBER(3) NOT NULL
);

ALTER TABLE modelo 
    ADD CONSTRAINT modelo_pk PRIMARY KEY ( id_modelo );

CREATE TABLE reporte (
    id_reporte   NUMBER NOT NULL,
    fec_reporte  DATE NOT NULL,
    rut_usuario  NUMBER(5) NOT NULL,
    desc_reporte VARCHAR2(200) NOT NULL
);

ALTER TABLE reporte 
    ADD CONSTRAINT reporte_pk PRIMARY KEY ( id_reporte );

CREATE TABLE reserva (
    id_reserva             NUMBER NOT NULL,
    fecha_creacion_reserva DATE NOT NULL,
    fecha_reserva          DATE NOT NULL,
    hora_inicio            DATE NOT NULL,
    hora_fin               DATE NOT NULL,
    rut_usuario            NUMBER NOT NULL,
    id_estacionamiento     NUMBER(3) NOT NULL
);

ALTER TABLE reserva 
    ADD CONSTRAINT reserva_pk PRIMARY KEY ( id_reserva );

CREATE TABLE sensor (
    id_sensor NUMBER(3) NOT NULL,
    id_zona   CHAR(1) NOT NULL
);

ALTER TABLE sensor 
    ADD CONSTRAINT sensor_pk PRIMARY KEY ( id_sensor );

CREATE TABLE tipo_estado_reserva (
    id_tpo_est_reserva   NUMBER(1) NOT NULL,
    desc_tpo_est_reserva VARCHAR2(20) NOT NULL
);

ALTER TABLE tipo_estado_reserva 
    ADD CONSTRAINT tipo_estado_reserva_pk PRIMARY KEY ( id_tpo_est_reserva );

CREATE TABLE tipo_usuario (
    id_tipo_usuario   NUMBER(2) NOT NULL,
    desc_tipo_usuario VARCHAR2(50) NOT NULL
);

ALTER TABLE tipo_usuario 
    ADD CONSTRAINT tipo_usuario_pk PRIMARY KEY ( id_tipo_usuario );

CREATE TABLE usuario (
    rut_usuario              NUMBER(5) NOT NULL,
    pnombre_usuario          VARCHAR2(50) NOT NULL,
    snombre_usuario          VARCHAR2(50),
    apellido_paterno_usuario VARCHAR2(50) NOT NULL,
    apellido_materno_usuario VARCHAR2(50) NOT NULL,
    correo                   VARCHAR2(50) NOT NULL,
    nro_celular              NUMBER(8) NOT NULL,
    id_tipo_usuario          NUMBER(2) NOT NULL
);

ALTER TABLE usuario 
    ADD CONSTRAINT usuario_pk PRIMARY KEY ( rut_usuario );

CREATE TABLE vehiculo (
    patente     VARCHAR2(6) NOT NULL,
    color       VARCHAR2(20),
    rut_usuario NUMBER(5) NOT NULL,
    id_modelo   NUMBER(3) NOT NULL,
    ano         DATE
);

ALTER TABLE vehiculo 
    ADD CONSTRAINT vehiculo_pk PRIMARY KEY ( patente );

CREATE TABLE zona (
    id_zona CHAR(1) NOT NULL
);

ALTER TABLE zona 
    ADD CONSTRAINT zona_pk PRIMARY KEY ( id_zona );

ALTER TABLE espacio_favorito
    ADD CONSTRAINT espacio_favorito_fk FOREIGN KEY ( id_estacionamiento )
        REFERENCES estacionamiento ( id_estacionamiento );

ALTER TABLE espacio_favorito
    ADD CONSTRAINT espacio_favorito_usuario_fk FOREIGN KEY ( rut_usuario )
        REFERENCES usuario ( rut_usuario );

ALTER TABLE estacionamiento
    ADD CONSTRAINT estacionamiento_sensor_fk FOREIGN KEY ( id_sensor )
        REFERENCES sensor ( id_sensor );

ALTER TABLE estacionamiento
    ADD CONSTRAINT estacionamiento_zona_fk FOREIGN KEY ( id_zona )
        REFERENCES zona ( id_zona );

ALTER TABLE estacionamiento
    ADD CONSTRAINT estado_estacionamiento_fk FOREIGN KEY ( id_est_estacionamiento )
        REFERENCES estado_estacionamiento ( id_est_estacionamiento );

ALTER TABLE feedback
    ADD CONSTRAINT feedback_usuario_fk FOREIGN KEY ( rut_usuario )
        REFERENCES usuario ( rut_usuario );

ALTER TABLE incidente
    ADD CONSTRAINT incidente_estado_incidente_fk FOREIGN KEY ( id_estado_incidente )
        REFERENCES estado_incidente ( id_estado_incidente );

ALTER TABLE incidente
    ADD CONSTRAINT incidente_usuario_fk FOREIGN KEY ( rut_usuario )
        REFERENCES usuario ( rut_usuario );

ALTER TABLE modelo
    ADD CONSTRAINT modelo_marca_fk FOREIGN KEY ( id_marca )
        REFERENCES marca ( id_marca );

ALTER TABLE reporte
    ADD CONSTRAINT reporte_usuario_fk FOREIGN KEY ( rut_usuario )
        REFERENCES usuario ( rut_usuario );

ALTER TABLE reserva
    ADD CONSTRAINT reserva_estacionamiento_fk FOREIGN KEY ( id_estacionamiento )
        REFERENCES estacionamiento ( id_estacionamiento );

ALTER TABLE estado_reserva
    ADD CONSTRAINT reserva_fk FOREIGN KEY ( id_reserva )
        REFERENCES reserva ( id_reserva );

ALTER TABLE sensor
    ADD CONSTRAINT sensor_zona_fk FOREIGN KEY ( id_zona )
        REFERENCES zona ( id_zona );

ALTER TABLE estado_reserva
    ADD CONSTRAINT tipo_estado_reserva_fk FOREIGN KEY ( id_tpo_est_reserva )
        REFERENCES tipo_estado_reserva ( id_tpo_est_reserva );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_tipo_usuario_fk FOREIGN KEY ( id_tipo_usuario )
        REFERENCES tipo_usuario ( id_tipo_usuario );

ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_modelo_fk FOREIGN KEY ( id_modelo )
        REFERENCES modelo ( id_modelo );

ALTER TABLE vehiculo
    ADD CONSTRAINT vehiculo_usuario_fk FOREIGN KEY ( rut_usuario )
        REFERENCES usuario ( rut_usuario );