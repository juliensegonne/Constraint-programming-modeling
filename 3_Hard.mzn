% DREAN (2408681)
% SEGONNE (2409827)

include "globals.mzn"; 

%-----------------------------------------------------------------------------%
% Données
%-----------------------------------------------------------------------------%

% Nombre de villes à visiter + point de départ de la tournée
int: n;
 % Distance entre chaque villes (symétrique)
array[1..n,1..n] of int: distance;
 % Distance minimale possible entre deux villes différentes
int: min_val = min([distance[i,j] | i,j in 1..n where distance[i,j] > 0]);
% Distance maximale possible entre deux villes différentes
int: max_val = max([distance[i,j] | i,j in 1..n]);

% Fenêtre de temps (1 = début, 2 = fin) durant laquelle il est possible de jouer pour chaque ville
array[1..n,1..2] of int: fenetre_arrivee;
% Temps maximum pour tout le trajet
int: max_trajet = max([fenetre_arrivee[i,2] | i in 1..n]);
% Fenêtre de temps la plus grande du trajet
int: max_fenetre = max([fenetre_arrivee[i,2] - fenetre_arrivee[i,1]| i in 2..n]);

%-----------------------------------------------------------------------------%
% Variables de décisions
%-----------------------------------------------------------------------------%

% Ordre des villes visitées par la tournée, chemin_tournee[i] = ville visitée en i-ème position
array[1..n] of var 1..n: chemin_tournee;
% Circuit de la tournée, circuit_tournee[i] = j => j est le successeur de i
array[1..n] of var 1..n: circuit_tournee;
% Temps cumulé lors de l'arrivé au point i de la tournée
array[1..n] of var 0..max_trajet: cumul_temps;
% Temps d'attente avant le spectacle en ville i
array[1..n] of var 0..max_fenetre: temps_attente;
% Temps d'attente total 
var 0..max_trajet: total_temps_attentes = sum(temps_attente);

%-----------------------------------------------------------------------------%
% Objectif
%-----------------------------------------------------------------------------%

% Temps de trajet à minimiser
var int: temps_trajet = cumul_temps[n];


%-----------------------------------------------------------------------------%
% Partie étudiant
%-----------------------------------------------------------------------------%

%def de cumul_temps
constraint cumul_temps[1] = distance[1,chemin_tournee[1]] + temps_attente[chemin_tournee[1]];
constraint forall(i in 2..n) (cumul_temps[i] = cumul_temps[i-1] + distance[chemin_tournee[i-1], chemin_tournee[i]] + temps_attente[chemin_tournee[i]]);


% toutes les villes sont visitées une seule fois
constraint alldifferent(circuit_tournee);
constraint alldifferent(chemin_tournee);

% la dernière ville visitée est celle de départ
constraint chemin_tournee[n] = 1;

% def de circuit_tournee
constraint forall(i in 1..n-1) (circuit_tournee[chemin_tournee[i]] = chemin_tournee[i+1]);


% temps de trajet total inférieur à la borne sup de la fenêtre et supérieur à la borne inf
constraint forall(i in 1..n)(cumul_temps[i] <= fenetre_arrivee[chemin_tournee[i],2]);
constraint forall(i in 1..n)(cumul_temps[i] >= fenetre_arrivee[chemin_tournee[i],1]);


% possibilité d'arriver en avance
constraint temps_attente[chemin_tournee[1]] = max(0, fenetre_arrivee[chemin_tournee[1],1] - distance[1,chemin_tournee[1]]);
constraint forall(i in 2..n) (temps_attente[chemin_tournee[i]] = max(0,fenetre_arrivee[chemin_tournee[i],1] - cumul_temps[i-1] - distance[chemin_tournee[i],chemin_tournee[i-1]]));


% on impose 2 stratégies de recherche :
% on choisit les villes qui ont le plus petit domaine (les plus fortes contraintes) et la plus petite valeur en premier
% on choisit le cumul_temps qui a le plus grand ensemble de valeurs possibles et on lui assigne la plus petite

solve :: seq_search([int_search(chemin_tournee,first_fail,indomain_min,complete),
int_search(cumul_temps,largest,indomain_min,complete)])
minimize temps_trajet;


%-----------------------------------------------------------------------------%

output [
  "Chemin de la tournée                   : \(chemin_tournee)\n",
  "Circuit de la tournée                  : \(circuit_tournee)\n",
  "Temps cumulés avant d'entrer en ville  : \(cumul_temps)\n",
  "Temps d'attente avant l'entrée en ville: \(temps_attente)\n",
  "Temps d'attente total                  : \(total_temps_attentes)\n",
  "Temps de trajet total                  : \(temps_trajet)\n",
];