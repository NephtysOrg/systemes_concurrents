with TEXT_IO; use TEXT_IO;

procedure LecteurRedacteur is

    package int_io is new Integer_io(integer);
    use int_io;

    -- interface Ecrivain

    protected type Ecrivain is
        entry debut_lect;
        entry debut_red;
        entry fin_lect;
        entry fin_red;
    private
        nbLect : Integer := 0;
        nbRed : Integer := 0;
    end Ecrivain;

    E : Ecrivain;

    task type Lecteur is end Lecteur;     -- Interface Lecteur
    task type Redacteur is end Redacteur; -- Interface Redacteur

    --body  Ecrivain
    protected body Ecrivain is
        entry debut_lect
            when (nbRed + debut_red'count = 0) is
        begin
            put_line("debut_lect");
            nbLect := nbLect + 1;
        end debut_lect;

        entry fin_lect
            when(true) is
        begin
            put_line("fin_lect");
            nbLect := nbLect - 1;
        end fin_lect;

        entry debut_red
            when (nbLect + debut_lect'count + nbRed = 0) is
        begin
            put_line("debut_red");
            nbRed := nbRed + 1;
        end debut_red;

        entry fin_red
            when(true) is
        begin
            put_line("fin_red");
            nbRed := nbRed - 1;
        end fin_red;
    end Ecrivain;

    task body Lecteur is
        value : Integer := 3;
    begin
        for i in 1..20 loop
            E.debut_lect;
            E.fin_lect;
        end loop;
    end Lecteur;


    task body Redacteur is
        value : Integer := 0;
    begin
        for i in 1..10 loop
            E.debut_red;
            E.fin_red;
        end loop;
    end Redacteur;

    L : Lecteur;
    R : Redacteur;

    begin
        null;
end LecteurRedacteur;