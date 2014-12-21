with TEXT_IO; use TEXT_IO;

procedure LecteurRedacteur is
    package int_io is new Integer_io(integer);
    use int_io;

    -- Interface  Ecrivain
    task type Ecrivain is
        entry barriere;
        entry debut_lect;
        entry debut_red;
        entry fin_lect;
        entry fin_red;
    end Ecrivain;

    E : Ecrivain;

    task type Lecteur is end Lecteur;     -- Interface Lecteur
    task type Redacteur is end Redacteur; -- Interface Redacteur

    -- Body Ecrivain
    task body Ecrivain is
        nbLect : Integer := 0;
        nbRed : Integer := 0;
        drapeau : Integer := 0;
    begin
        loop
            select
                when (drapeau = 0) => accept barriere
                    do
                        drapeau := 1;
                    end;
            or
                when (nbRed = 0) => accept debut_lect
                    do 
                        put_line("debut_lect");
                        nbLect := nbLect + 1;
                        drapeau := 0;
                    end;
            or
                when (nbLect+nbRed = 0) => accept debut_red
                    do 
                        put_line("debut_red");
                        nbRed := nbRed + 1;
                    end;
            or
                accept fin_lect 
                do 
                    put_line("fin_lect");
                    nbLect := nbLect - 1;
                end;
            or
                accept fin_red  
                do 
                    put_line("fin_red");
                    nbRed := nbRed - 1;
                    drapeau := 0;
                end;
                    
            end select;
        end loop;
    end Ecrivain;

    task body Lecteur is
    begin
        for i in 1..10 loop
            E.barriere;
            E.debut_lect;
            E.fin_lect;
        end loop;
    end Lecteur;

    task body Redacteur is
    begin
        for i in 1..10 loop
            E.barriere;
            E.debut_red;
            E.fin_red;
        end loop;
    end Redacteur;

    l : Lecteur;
    r : Redacteur;

begin -- LecteurRedacteur
    null;
end LecteurRedacteur;