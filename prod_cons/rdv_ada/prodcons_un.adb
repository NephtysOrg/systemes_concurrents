with TEXT_IO; use TEXT_IO;

-- Producteur consommateur avec un tampon de taille 1 : 
    -- echange synchrone du message : le producteur ne peut produire que quand le lecteur a lu et inversement. 

procedure ProdCons is
    package int_io is new Integer_io(integer);
    use int_io;
    cpt : Integer := 0;
    tampon : Integer;

    -- Interface Producteur
    task type Producteur is 

    end Producteur;

    -- Interface consommateur
    task type Consommateur is 
        entry echange(Mess : IN OUT Integer);
    end Consommateur;

    -- corps Consommateur
    task body Consommateur is
        Mess : Integer := 0;
    begin
        for i in 1..10 loop
            loop
                select
                    -- si le producteur a rempli le tampon
                    when (true) => accept echange(Mess : IN OUT Integer)
                    do
                        put_line("consommer");
                        Mess := tampon;
                        cpt := 0;
                    end;
                end select;
            end loop;
        end loop;
    end Consommateur;

    c : Consommateur;



    -- corps Producteur
    task body Producteur is
        Mess : Integer := 1;
    begin
        for i in 1..10 loop
        put_line("produire");
        tampon := Mess;
        cpt := 1;
        c.echange(tampon);
        end loop;
    end Producteur;


    p : Producteur;


begin
    null;
end ProdCons; 