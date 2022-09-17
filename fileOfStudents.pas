PROGRAM fileOfStudents;
      CONST
            MAX = 10;
      TYPE
            tpStudent = RECORD
                  nombre: STRING;
                  edad: INTEGER;
            END;
            tpListStudents = ARRAY[1..MAX] OF tpStudent;
      VAR
            nombreFile: STRING;
            estudianteData: tpStudent;
            listStudents: tpListStudents;
            dimListStudents: 1..MAX;  

      { Funciones }
      FUNCTION escribirFile(nameFile: STRING; lData: tpListStudents; dimData: INTEGER): BOOLEAN;
      VAR
            fileStudents: FILE OF tpStudent; { Archivo, en donde el contenido son datos de tipo estudiante}
            indexList: 1..MAX;
      BEGIN
            Assign(fileStudents, nameFile); { Asigna la variable archivo al archivo fisico}
            Rewrite(fileStudents); { Crea el archivo y situa el cursor al incio del archivo, borrando lo existente}
            FOR indexList := 1 TO dimData DO
                  BEGIN
                        Write(fileStudents, lData[indexList]);
                  END;
            Close(fileStudents); { Cierra el archivo}
            escribirFile := TRUE;  
      END;

      FUNCTION leerFile(nameFile: STRING): BOOLEAN;
      VAR
            fileStudents: FILE OF tpStudent;
            studentOut: tpStudent;
      BEGIN
            Assign(fileStudents, nameFile);
            Reset(fileStudents); { Situa el cursor al inicio del archivo}
            WHILE NOT EOF(fileStudents) DO
                  BEGIN
                        READ(fileStudents, studentOut);
                        WRITELN(studentOut.nombre, ' - ', studentOut.edad);
                  END;
            Close(fileStudents);
            leerFile := TRUE;
      END;
BEGIN
      dimListStudents := 1;
      nombreFile := 'estudiantes.dat';
      
      estudianteData.nombre := 'David';
      estudianteData.edad := 19;
      listStudents[dimListStudents] := estudianteData;
      dimListStudents := dimListStudents + 1;

      estudianteData.nombre := 'Elina';
      estudianteData.edad := 7;
      listStudents[dimListStudents] := estudianteData;

      escribirFile(nombreFile, listStudents, dimListStudents);

      WRITELN;
      leerFile(nombreFile);
      WRITELN;      

      READLN;
END.
