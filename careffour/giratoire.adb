with TEXT_IO; use TEXT_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure Giratoire is
    package int_io is new Integer_io(integer);
    use int_io;

    -- Declaration de variables
    capacite : Integer := 5;   -- Capacite du carrefour
    subtype type_voie is Integer range 0..10;

    -- Interface carrefour
    protected type Carrefour is
        -- Signal d'entree dans le carrefour
        entry entrer(type_voie);
        -- Signal de sortie du carrefour
        procedure sortir;

    private
        compteur : Integer := 0; -- Nombre de véhicule dans le carrefour
        carrefour_vide : Boolean := true;
        voie_courrante : type_voie;
    end Carrefour;

    protected body Carrefour is
        entry entrer(for numVoie in type_voie)
            when (numVoie = voie_courrante and compteur < capacite ) or (compteur=0 and carrefour_vide) is
        begin
            compteur := compteur +1 ;
            voie_courrante := numVoie;
            put_line("Voie courante :"  & Integer'Image(voie_courrante));
        end entrer;

        procedure sortir is
        begin
            compteur := compteur -1 ;
            -- Si on est le dernier vehicule, 
            -- quil y ait ou non dautres véhicules qui attendent
            -- on passe la voie courante a la voie suivante et on dit que le carrefour est vide
            -- ainsi, si la voie suivante contient des vehicules ils passent,
            -- si elle nen contient pas, les autres peuvent passer aussi etant donné que 
            -- compteur = 0 et carrefour_vide = true
            if compteur = 0
                then    voie_courrante := (voie_courrante+1) mod type_voie'Last;
                        carrefour_vide := true;
            end if;
        end sortir;
    end Carrefour;

    C : Carrefour;

    task type Voiture is end Voiture;
    task body Voiture is
    begin
        for i in type_voie loop
            C.entrer(i);
            put_line(Integer'Image(i));
            C.sortir;
        end loop;
    end Voiture;

v1 : Voiture;
v2 : Voiture;
v3 : Voiture;
v4 : Voiture;
v5 : Voiture;
v6 : Voiture;
v7 : Voiture;
v8 : Voiture;
v9 : Voiture;
v10 : Voiture;


begin -- Giratoire
    null;
end Giratoire;