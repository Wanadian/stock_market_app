# Stocket
*Créé par Amandine Carlier et William Denorme - FISA5*

Ce projet s'appelle Stocket, il s'agit d'une application mobile de marché boursier.

## Premiers Pas

Pour exécuter le projet sur votre téléphone :

- Assurez-vous que votre téléphone est connecté à votre ordinateur et que Flutter et le SDK Dart sont installés sur votre ordinateur.
- Exécutez `flutter devices` et assurez-vous que le périphérique que vous utiliserez pour l'application est répertorié.
- Placez-vous à la racine du projet et exécutez `flutter run` pour lancer le projet (ajoutez ` --release` à la commande si vous souhaitez que l'application reste sur votre téléphone).

*Attention : lors du premier lancement de l'application (dans la journée), veuillez prendre en compte un temps d'initialisation d'environ 2 à 3 minutes. Cela est nécessaire pour permettre à l'application d'effectuer l'appel à l'API (3 x 13 secondes, car nous sommes limités par l'API) et de remplir la base de données. Vous avez également la possibilité d'ouvrir la base de données en temps réel via votre navigateur pour observer le processus de remplissage en direct. Cette courte période d'attente initiale garantit que l'application dispose des données les plus récentes.*

### Choix d'architecture

Notre application mobile Flutter repose sur une architecture n-tiers soigneusement conçue pour offrir une expérience utilisateur fluide et des performances optimales. Au cœur de cette architecture, nous avons mis en place une structure bien organisée, composée de plusieurs éléments clés.

- <u>Services et Repositories</u> : Nous avons développé des services et des repositories pour gérer la logique métier de notre application de manière modulaire. Les services sont responsables de l'interaction avec nos sources de données, tandis que les repositories agissent comme une couche d'abstraction pour accéder aux données. Cette approche permet une gestion efficace des données et de la logique tout en favorisant la réutilisation du code.
- <u>DTO (Data Transfer Objects)</u> : Les DTO sont des objets spécialement conçus pour transférer des données entre différentes parties de l'application. Ils garantissent une communication fluide et structurée entre les couches de notre architecture.
- <u>Base de données Firebase</u> : Pour stocker et gérer nos données de manière fiable, nous avons intégré Firebase, une puissante base de données en temps réel. Grâce à Firebase, nous pouvons offrir des fonctionnalités de synchronisation en temps réel, ce qui améliore considérablement l'expérience utilisateur.
- <u>Entities</u> : Nos modèles, que nous appelons "Entities," représentent les objets dans notre base de données Firebase (Firestore Database). Ces entités reflètent la structure de nos données et sont essentielles pour garantir la cohérence des informations stockées l'application et dans la base de données.
- <u>Context</u> : Nous avons mis en place un context qui gère le partage de données entre les différentes pages de l'application. Cela permet d'éviter les redondances de code et d'assurer une communication fluide entre les différents composants de l'application. Nous utilisons pour cela "inheritedServices" et "rootWidget", pour garantir une gestion efficace de ce context.
- <u>Gestion des erreurs</u> : Dans un souci de gestion des erreurs, nous avons regroupé les exceptions que nous pouvons rencontrer dans un package dédié appelé "errors." Cela simplifie la gestion des erreurs et nous pouvons retracer facilement les éventuelles complications qui peuvent survenir.
- <u>Répertoires "Screens" et "Widgets"</u> : Pour maintenir une structure claire et organisée de notre code, nous avons divisé notre application en deux répertoires distincts. "Screens" regroupe l'implémentation des pages de notre application, tandis que "Widgets" contient les différents composants réutilisables qui sont utilisés pour construire ces pages. Cette approche favorise la maintenabilité et la réutilisation du code.

En somme, notre application mobile Flutter est construite autour d'une architecture solide et modulaire, qui garantit une gestion efficace des données, une expérience utilisateur optimale, et une maintenance simplifiée. Les choix technologiques que nous avons faits, tels que l'utilisation de Firebase, des DTO, et de la gestion des erreurs, contribuent à faire de notre application une solution robuste et performante.

## Fonctionnalités côté Back

Les fonctionnalités côté back-end de l'application sont accessibles via les services que nous avons mis en place. Ces services agissent comme une couche intermédiaire entre les Front et les données stockées dans la base de données Firebase. Voici une description des fonctionnalités offertes par chaque service en fonction du code que vous avez fourni :

- <u>SymbolService</u> :
  - getAllSymbols() : Renvoie une liste de toutes les symboles (codes) des entreprises disponibles.
  - getAllCompanyNames() : Renvoie une liste de tous les noms d'entreprises associés aux symboles.
  - getSymbolByCompanyName(String companyName) : Renvoie le symbole correspondant à un nom d'entreprise donné.
  - getCompanyNameBySymbol(String symbol) : Renvoie le nom de l'entreprise correspondant à un symbole donné.

- <u>ShareService</u> :
  - getShareFromAPI(String symbol) : Récupère les données sur les actions d'une entreprise depuis la source API externe Alpha Vantage.
  - convertListToStream(List<String> stringList) : Convertit une liste de symboles en un flux (stream) pour gérer les appels limités à l'API (un appel toutes les 13 secondes).
  - addSharesFromAPIToDB() : Met à jour la base de données avec les dernières données sur les actions à partir de l'API.
  - getAllShares() : Renvoie une liste de toutes les actions enregistrées dans la base de données (toutes dates confondues).
  - getLatestShares() : Renvoie les actions les plus récentes pour toutes les entreprises.
  - getSharesPrices() : Renvoie les prix actuels (autrement-dit, les plus récents) de toutes les actions.
  - getSymbolSharesPricesHistory(String symbol) : Renvoie l'historique des prix d'une action spécifique.
  - getSymbolSharesPricesHistoryWithDate(String symbol, DateTime startTime) : Renvoie l'historique des prix d'une action spécifique à partir d'une date donnée.
  - getLatestRefreshDate() : Renvoie la date de la dernière actualisation des données (sauvegardée en base de données).
  - getLatestShare(String symbol) : Renvoie les données les plus récentes pour une action spécifique.
  - getPriceDifference(String symbol) : Calcule la variation en pourcentage du prix entre les deux dernières données d'une action (autrement-dit des deux dernières dates connues en base de données).
  - addNbShares(String symbol, int nbSharesToAdd) : Ajoute un certain nombre d'actions pour une entreprise donnée.
  - removeNbShares(String symbol, int nbSharesToAdd) : Supprime un certain nombre d'actions pour une entreprise donnée.
  - getPrice(String symbol) : Renvoie le prix actuel (le plus récent) d'une action.
  - getNbShares(String symbol) : Renvoie le nombre d'actions d'une entreprise.

- <u>UserSharesService</u> :
  - getAllUserShares() : Renvoie la liste des actions détenues par l'utilisateur.
  - getUserShares(String symbol) : Renvoie les actions d'un utilisateur pour une entreprise spécifique.
  - addUserShares(String symbol, int nbSharesToAdd) : Ajoute des actions à l'utilisateur, sous réserve de conditions de solde suffisant, pour une entreprise spécifique.
  - removeUserShares(String symbol, int nbSharesToRemove) : Supprime des actions de l'utilisateur pour une entreprise spécifique.
  - getUserNbShares(String symbol) : Renvoie le nombre d'actions détenues par l'utilisateur pour une entreprise spécifique.
  - getUserSharesBalanceEstimationAsString() : Renvoie une estimation du solde global de l'utilisateur basée sur les actions détenues (argent virtuel).

- <u>WalletService</u> :
  - getWalletBalanceAsString() : Renvoie le solde du portefeuille de l'utilisateur (argent réel) sous forme de chaîne de caractères.
  - creditWalletBalanceWithDouble(double sumToCredit) : Crédite le solde du portefeuille (argent réel) avec un montant en double.
  - creditWalletBalanceWithInt(int sumToCredit) : Crédite le solde du portefeuille (argent réel) avec un montant entier.
  - debitWalletBalance(double sumToDebit) : Débite le solde du portefeuille (argent réel) avec un montant en double.

- <u>CardService</u> :
  - getAllCards() : Renvoie la liste des informations de cartes enregistrées.
  - getCard(String label) : Renvoie les détails des informations d'une carte en fonction de son label.
  - addCard(String label, String holderName, int number, int safeCode, DateTime expirationDate) : Ajoute les informations d'une nouvelle carte à la liste des cartes.
  - updateLabel(String label, String newLabel) : Met à jour le label d'une carte existante.
  - deleteCard(String label) : Supprime les informations d'une carte de la liste.
  
Chaque service offre des fonctionnalités spécifiques pour gérer les données, les actions et les cartes associées à l'application, en garantissant une interaction fluide avec la base de données Firebase et en respectant les règles métier définies.

## Fonctionnalités côté Front

Au niveau de l'interface, nous pourvons faire plusieurs choses :
- <u>Acheter et vendre des actions</u> : Via le bouton "Stock market" puis l'onglet "Market" (pour acheter des actions), ou "Purchased" (pour vendre des actions).
- <u>Consulter notre portefeuille</u> : La liste des actions achetées est affichée sur l'onglet "Purchased" (et pour pouvoir les vendre).
- <u>Voir les variations de valeur des actions</u> : Ces variations sont visibles en cliquant sur le bouton "Stock market" (des flèches montantes et descendantes sont présentes pour vsualiser les variations des prix).
- <u>Ajouter de l'argent sur le compte</u> : Via le bouton "Add funds", un montant peut être saisi (en nombre entier), puis une carte peut être enregistrée ou sélectionnée via une liste déroulante.
- <u>Gérer les cartes utilisées pour ajouter de l'argent</u> : Les cartes ajoutées peuvent être supprimée facilement lors de l'ajout d'argent.

### Axes d'amélioration

Pour améliorer l'application, voici quelques axes d'amélioration importants à considérer :

- <u>Meilleure Gestion de l'API</u> : Il serait bénéfique d'améliorer la gestion de l'API pour permettre l'inclusion de davantage d'entreprises, élargissant ainsi la gamme d'options pour les utilisateurs.
- <u>Optimisation de la Gestion Asynchrone</u> : Une amélioration de la gestion de l'asynchrone est essentielle pour garantir une expérience utilisateur sans accrocs. Les opérations asynchrones peuvent parfois entraîner des conflits de données ou des retards dans le traitement. En renforçant la gestion de l'asynchrone, l'application gagnera en robustesse et en fiabilité, assurant ainsi une expérience utilisateur plus fluide et cohérente. Cela peut inclure une gestion plus fine des erreurs, une optimisation des délais d'attente et une meilleure synchronisation des opérations asynchrones pour éviter tout impact négatif sur les performances.
- <u>Retrait d'argent (réel)</u> : Actuellement, l'application permet aux utilisateurs d'ajouter de l'argent, mais ne propose pas de mécanisme de retrait. L'ajout d'une fonctionnalité de retrait offrirait aux utilisateurs une expérience plus complète et pratique. Cela impliquerait la mise en place d'un processus sécurisé de conversion des gains virtuels en argent réel, ainsi que la possibilité pour les utilisateurs de retirer leurs fonds vers un compte bancaire ou une autre méthode de paiement. Cette fonctionnalité serait un atout majeur pour les utilisateurs qui souhaitent non seulement investir virtuellement, mais aussi retirer les gains réels qu'ils ont accumulés grâce à l'application (de l'application vers le compte bancaire).
- <u>Ajout d'autres moyens de paiement</u> : La diversification des méthodes de paiement permettrait aux utilisateurs de choisir des options de paiement adaptées à leurs préférences (Paypal, par exemple).
- <u>Graphique d'historique du portefeuille virtuel</u> : La création d'un graphique présentant l'historique de l'argent virtuel en fonction du temps et des fluctuations des prix serait un atout pour les utilisateurs souhaitant suivre l'évolution de leur portefeuille virtuel.
- <u>Mémorisation du prix d'Achat des actions</u> : Garder en mémoire le prix d'achat des actions permettrait aux utilisateurs de suivre et de comparer leurs performances au fil du temps (et donc de choisir par la suite le meilleur moment pour vendre, ou acheter, une (des) action(s)).
- <u>Affichage des plus grandes hausses et baisses</u> : Mettre en page d'accueil les actions affichant les plus grandes hausses et baisses permettrait aux utilisateurs de repérer rapidement les opportunités.
- <u>Thème sombre (Dark Theme)</u> : Offrir la possibilité de passer en mode sombre serait apprécié par de nombreux utilisateurs souhaitant personnaliser l'apparence de l'application.
- <u>Multi-Utilisateurs</u> : Ajouter la possibilité de gérer plusieurs comptes utilisateurs sur une même application serait utile pour les utilisateurs ayant des profils distincts (avec un système d'authentification, entre autres).

Ces améliorations contribueraient à enrichir l'expérience des utilisateurs tout en renforçant la polyvalence et les fonctionnalités de l'application.

### Emplacement des sources

Vous pouvez trouver les sources du projet ici : https://github.com/Wanadian/stock_market_app

La base de données est accessible ici : https://console.firebase.google.com/project/stock-market-db-b5abf/firestore/data