% DREAN (2408681)
% SEGONNE (2409827)

include "globals.mzn"; 

%-----------------------------------------------------------------------------%
% Données
%-----------------------------------------------------------------------------%

% Nombre de tâches
int: n;
% Durée maximal du projet
int: m;
% Limite de ressources pouvant être partagées entre les tâches en cours
int: limite;

% Durée des tâches
array[1..n] of 1..m: duree_tache;
% Ressources requises par les tâches
array[1..n] of 1..m: ressource_tache;

%-----------------------------------------------------------------------------%
% Variables de décisions
%-----------------------------------------------------------------------------%

array[1..n] of var 1..m: debut_tache; % Début des tâches
array[1..n] of var 1..m: fin_tache; % Fin des tâches

%array[1..n] of var 0..2: nbr_occurence_debut; % Nombre d'occurence de chaque date de début de tâche (pour la contrainte : pas plus de 2 tâches démarrent en même temps)

%-----------------------------------------------------------------------------%
% Objectif
%-----------------------------------------------------------------------------%

% Fin du projet
var int: fin_projet = max(fin_tache);

%-----------------------------------------------------------------------------%
% Partie étudiant
%-----------------------------------------------------------------------------%

constraint forall(i in 1..n) (duree_tache[i] = fin_tache[i]-debut_tache[i]);

%pas plus de 2 tâches démarrent en même temps
%constraint forall (date in debut_tache) (nbr_occurence_debut[date] = sum([date == debut_tache[i] | i in 1..n]));    NON FONCTIONNEL

constraint forall(date in debut_tache) (sum(i in 1..n) (if debut_tache[i] = date then 1 else 0 endif)<3);


%contrainte de ressources
constraint cumulative (debut_tache,duree_tache,ressource_tache,limite);

solve minimize fin_projet;
%-----------------------------------------------------------------------------%

output [
  "Envergure du projet  : ", show(fin_projet), "\n",
  "Début des tâches     : ", show(debut_tache), "\n",
  "Fin des tâches       : ", show(fin_tache), "\n",
];