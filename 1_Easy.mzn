% DREAN (2408681)
% SEGONNE (2409827)

include "globals.mzn";

%-----------------------------------------------------------------------------%
% Données
%-----------------------------------------------------------------------------%

% Nombre d'acteurs et de rôles
int: n;
% Couleurs des costumes
enum costumes; 
% Costume démandé pour un rôle i (première dimension) par un acteur j (seconde dimension)
array[1..n,1..n] of costumes: choix_costume;

%-----------------------------------------------------------------------------%
% Variables de décisions
%-----------------------------------------------------------------------------%

% Variables de décision pour assigner un acteur à un rôle
array [1..n] of var 1..n: assignation_role;

%-----------------------------------------------------------------------------%
% Partie étudiant
%-----------------------------------------------------------------------------%

% pas 2 fois le même rôle
constraint alldifferent(assignation_role);

% pas 2 fois le même costume
constraint forall (i,j in 1..n where i != j) (choix_costume[assignation_role[i],i] != choix_costume[assignation_role[j],j]);

% 2 acteurs adjacents n'ont pas un rôle adjacent

constraint forall(i in 1..n-1) (assignation_role[i+1] != assignation_role[i]+1);
constraint forall(i in 1..n-1) (assignation_role[i+1] != assignation_role[i]-1);

solve satisfy;
%-----------------------------------------------------------------------------%

output	
  ["L'acteur " ++ format(i) ++ 
   " prendra le rôle " ++ format(fix(assignation_role[i])) ++ 
   " (costume " ++ format(choix_costume[fix(assignation_role[i]), i]) ++ ")" ++"\n" 
  | i in 1..n];