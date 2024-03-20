CREATE TABLE Typ (
    ID_Typ INT PRIMARY KEY AUTO_INCREMENT,
    Typ_uzytkownika CHAR(50) NOT NULL
);


-- Tabela użytkowników
CREATE TABLE Uzytkownik (
    ID_Uzytkownik INT(11) PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Haslo VARCHAR(255) NOT NULL,
    Login VARCHAR(50) NOT NULL,
    ID_Typ INT(11) NOT NULL,
    FOREIGN KEY (ID_Typ) REFERENCES Typ(ID_Typ)
);

-- Tabela producentów
CREATE TABLE Producent (
    ID_Producent INT(11) PRIMARY KEY AUTO_INCREMENT,
    Nazwa CHAR(100) NOT NULL,
    Siedziba CHAR(100) NOT NULL
);


-- Tabela filmów
CREATE TABLE Film (
    ID_Film INT(11) PRIMARY KEY AUTO_INCREMENT,
    Tytul VARCHAR(70),
    Data_wydania DATE,
    Dlugosc INT,
    Opis VARCHAR(MAX),
    ID_Producent INT,
    FOREIGN KEY (ID_Producent) REFERENCES Producent(ID_Producent),
    FOREIGN KEY (ID_Kategoria) REFERENCES Kategoria(ID_Kategoria)
);

-- Tabela ocen
CREATE TABLE Ocena (
    ID_Ocena INT(11) PRIMARY KEY AUTO_INCREMENT,
    Ocena INT NOT NULL
);

-- Tabela kategorii filmowych
CREATE TABLE Kategoria (
    ID_Kategoria INT(11) PRIMARY KEY AUTO_INCREMENT,
    Nazwa CHAR(100) NOT NULL
);

CREATE TABLE Film_Kategoria (
    ID_Film INT(11),
    ID_Kategoria INT(11),
    PRIMARY KEY (ID_Film, ID_Kategoria),
    FOREIGN KEY (ID_Film) REFERENCES Film(ID_Film),
    FOREIGN KEY (ID_Kategoria) REFERENCES Kategoria(ID_Kategoria)
);

-- Tabela średnich ocen filmów
CREATE TABLE SredniaOcena (
    ID_Film INT(11),
    Srednia FLOAT,
    FOREIGN KEY (ID_Film) REFERENCES Film(ID_Film)
);

-- Tabela relacji wiele do wielu między Film a Ocena
CREATE TABLE FilmOcena (
    ID_Film INT(11),
    ID_Ocena INT(11),
    FOREIGN KEY (ID_Film) REFERENCES Film(ID_Film),
    FOREIGN KEY (ID_Ocena) REFERENCES Ocena(ID_Ocena),
    PRIMARY KEY (ID_Film, ID_Ocena)
);

-- Wypełnienie tabeli Typ
INSERT INTO Typ (Typ_uzytkownika) VALUES
('pracownik'),
('administrator'),
('uzytkownik');

-- Wypełnienie tabeli Producent
INSERT INTO Producent (Nazwa, Siedziba) VALUES
('Warner Bros', 'Los Angeles'),
('Universal Pictures', 'Hollywood'),
('Paramount Pictures', 'Los Angeles');

-- Wypełnienie tabeli Kategoria
INSERT INTO Kategoria (Nazwa) VALUES
('Dramat'),
('Komedia'),
('Akcja');

-- Wypełnienie tabeli Film
INSERT INTO Film (Tytul, Data_wydania, Dlugosc, Opis, ID_Producent,) VALUES
('Incepcja', '2010-07-16', 148, 'Opis filmu Incepcja', 1),
('Zielona Mila', '1999-12-10', 189, 'Opis filmu Zielona Mila', 2),
('Avengers', '2012-04-11', 143, 'Opis filmu Avengers', 3);

INSERT INTO Film_Kategoria (ID_Film, ID_Kategoria) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3); 

-- Wypełnienie tabeli Ocena
INSERT INTO Ocena (Ocena) VALUES
(1),
(2),
(3),
(4),
(5);

-- Wypełnienie tabeli Uzytkownik
INSERT INTO Uzytkownik (Email, Haslo, Login, ID_Typ) VALUES
('jan@kowalski.com', 'haslo123', 'jan123', 1),
('adam@nowak.com', 'qwerty', 'adam90', 3),
('admin@admin.com', 'admin', 'admin', 2);

-- Wypełnienie tabeli FilmOcena
INSERT INTO FilmOcena (ID_Film, ID_Ocena) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4),
(3, 5),
(3, 3);

-- Wypełnienie tabeli SredniaOcena (dla przykładu)
-- W prawdziwym środowisku zazwyczaj oblicza się to dynamicznie, a nie przechowuje w oddzielnej tabeli
INSERT INTO SredniaOcena (ID_Film, Srednia)
SELECT ID_Film, AVG(Ocena)
FROM FilmOcena
GROUP BY ID_Film;