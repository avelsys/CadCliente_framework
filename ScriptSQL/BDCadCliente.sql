If(db_id(N'BdCadCliente') IS NULL)
	CREATE DATABASE BdCadCliente;
GO

USE BdCadCliente;

IF NOT EXISTS (SELECT * 
                 FROM sysobjects 
                WHERE name='tbCliente' 
                  and xtype='U')
    CREATE TABLE tbCliente (
        cdCliente 		INT 			NOT NULL IDENTITY (1, 1),
        dsName 			VARCHAR(100)	NOT NULL,
        fgTipoCliente   CHAR(1) 		NOT NULL CHECK(fgTipoCliente IN ('F','J')),
        nmCpfCnpj       VARCHAR(14) 	NOT NULL,
        nmRGIE          VARCHAR(30), 
        dtCadastro      datetime 		DEFAULT CURRENT_TIMESTAMP,
        fgAtivo         bit 			DEFAULT 1,  
    CONSTRAINT PK_CLIENTE PRIMARY KEY(cdCliente));
   
IF NOT EXISTS (SELECT * 
                 FROM sysobjects 
                WHERE name='tbCliente_Telefone' 
                  and xtype='U')
    CREATE TABLE tbCliente_Telefone(
    	cdTelefone      INT 			NOT NULL IDENTITY (1, 1),
        cdClienteFK  	INT 			NOT NULL,
        nmDDD		    VARCHAR(3)	    NOT NULL,
        nmTelefone		VARCHAR(9)	    NOT NULL,
    CONSTRAINT PK_TELEFONE 		   	PRIMARY KEY(cdTelefone, cdClienteFK),
    CONSTRAINT FK_TELEFONE_CLIENTE 	FOREIGN KEY(cdClienteFK) REFERENCES tbCliente(cdCliente) ON DELETE CASCADE ON UPDATE CASCADE );
   
IF NOT EXISTS (SELECT * 
                 FROM sysobjects 
                WHERE name='tbCliente_Endereco' 
                  and xtype='U')
    CREATE TABLE tbCliente_Endereco(
    	cdEndereco      INT 			NOT NULL IDENTITY (1, 1),
        cdClienteFK  	INT 			NOT NULL,
        dsLogradouro    VARCHAR(100),
        nmNumero		VARCHAR(10),
        dsBairro		VARCHAR(50),
        dsCidade		VARCHAR(50),
        fgUF			VARCHAR(02),
        nmCep           VARCHAR(08),
        dsPais          VARCHAR(50),
    CONSTRAINT PK_ENDERECO 		   	PRIMARY KEY(cdEndereco, cdClienteFK),
    CONSTRAINT FK_ENDERECO_CLIENTE 	FOREIGN KEY(cdClienteFK) REFERENCES tbCliente(cdCliente) ON DELETE CASCADE ON UPDATE CASCADE );   
   
