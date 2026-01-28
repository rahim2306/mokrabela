// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'MokraBela';

  @override
  String get welcome => 'Bienvenue';

  @override
  String hello(String name) {
    return 'Bonjour, $name!';
  }

  @override
  String get languageSelector => 'Sélectionner la langue';

  @override
  String get english => 'Anglais';

  @override
  String get french => 'Français';

  @override
  String get arabic => 'Arabe';

  @override
  String get changeLanguage => 'Changer de langue';

  @override
  String currentLanguage(String language) {
    return 'Langue actuelle: $language';
  }

  @override
  String get welcomeToMokrabela => 'Bienvenue sur MokraBela';

  @override
  String get welcomeSubtitle =>
      'Aider les enfants à se sentir plus calmes, plus concentrés et mieux accompagnés, ensemble.';

  @override
  String get getStarted => 'Commencer';

  @override
  String get logIn => 'Se connecter';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get loginSubtitle => 'Connectez-vous pour continuer votre parcours.';

  @override
  String get loginFailed =>
      'Échec de la connexion. Veuillez vérifier vos identifiants.';

  @override
  String get dontHaveAccount => 'Vous n\'avez pas de compte?';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte?';

  @override
  String get onboardingQuestion1 => 'Quelle phrase vous décrit le mieux?';

  @override
  String get optionParent =>
      'Je suis un parent qui souhaite suivre les progrès de mon enfant.';

  @override
  String get optionTeacher =>
      'Je suis un enseignant qui travaille avec des élèves.';

  @override
  String get next => 'Suivant';

  @override
  String get back => 'Retour';

  @override
  String get skip => 'Passer';

  @override
  String get intro1Title => 'Le soutien avant tout';

  @override
  String get intro1Description =>
      'Les enfants ne s\'autorégulent pas seuls. Avec l\'accompagnement des parents et des enseignants, le calme devient une habitude.';

  @override
  String get intro2Title => 'Construire le calme intérieur';

  @override
  String get intro2Description =>
      'Pas à pas, les enfants apprennent à se calmer, à mieux se concentrer et à se sentir en contrôle.';

  @override
  String welcomeChild(String name) {
    return 'Bienvenue, $name!';
  }

  @override
  String get watchConnected => 'Connecté';

  @override
  String get watchDisconnected => 'Déconnecté';

  @override
  String get dailyProgress => 'Progrès quotidien';

  @override
  String get todaysCalmTime => 'Temps calme aujourd\'hui';

  @override
  String get minutes => 'minutes';

  @override
  String get dailyCalmGoal => 'Objectif quotidien de calme';

  @override
  String get goalReached => 'Objectif atteint!';

  @override
  String tasksRemaining(int count) {
    return '$count tâches restantes';
  }

  @override
  String get breathingExercise => 'Respiration';

  @override
  String get focusGames => 'Jeux de concentration';

  @override
  String get calmMusic => 'Musique calme';

  @override
  String get stories => 'Histoires';

  @override
  String get missingSquare => 'Le carré manquant';

  @override
  String get protocol => 'Protocole';

  @override
  String get focusTimer => 'Minuteur de concentration';

  @override
  String get addTask => 'Ajouter une tâche';

  @override
  String get myTasks => 'Mes tâches';

  @override
  String get start => 'Démarrer';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Reprendre';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get taskTitle => 'Titre de la tâche';

  @override
  String get duration => 'Durée (min)';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get helloLabel => 'Bonjour';

  @override
  String get letsStartProtocol => 'Commençons ton protocole';

  @override
  String get missingSquareProtocol => 'Pourquoi ce protocole ?';

  @override
  String protocolWelcome(String userName) {
    return 'Bonjour $userName, commençons ton protocole';
  }

  @override
  String get protocolExplanation =>
      'Ces 4 carrés t\'aident à comprendre tes émotions, contrôler ton énergie et trouver la paix.';

  @override
  String get square1Title => 'Conscience de Soi';

  @override
  String get square1Desc => 'Comprends tes émotions';

  @override
  String get square2Title => 'Autorégulation';

  @override
  String get square2Desc => 'Contrôle ton énergie';

  @override
  String get square3Title => 'Tâches Quotidiennes';

  @override
  String get square3Desc => 'Organise ton temps';

  @override
  String get square4Title => 'Apaisement Psychologique';

  @override
  String get square4Desc => 'Trouve ta paix';

  @override
  String get achievements => 'Réussites';

  @override
  String get trophiesTab => 'Trophies';

  @override
  String get mailboxTab => 'Mailbox';

  @override
  String get tapToStart => 'Appuyez pour commencer';

  @override
  String get goodMorning => 'Bonjour';

  @override
  String get language => 'Langue';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get tasks => 'Tâches';

  @override
  String get manageYourTimeWell => 'Gérez bien\nvotre temps';

  @override
  String get onboardingQuestion2 =>
      'À quelle heure souhaiteriez-vous faire votre bilan quotidien ?';

  @override
  String get reminderHabitText =>
      'Un rappel doux vous aide à instaurer une habitude.';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get tellUsMoreTitle => 'Dites-nous en plus sur vous';

  @override
  String get tellUsMoreSubtitle =>
      'Choisissez quelques mots qui vous correspondent';

  @override
  String get profileImage => 'Image de profil';

  @override
  String get fullName => 'Nom complet';

  @override
  String get firstName => 'Prénom';

  @override
  String get familyName => 'Nom de famille';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get dateOfBirth => 'Date de naissance';

  @override
  String get gender => 'Genre';

  @override
  String get male => 'Homme';

  @override
  String get female => 'Femme';

  @override
  String get other => 'Autre';

  @override
  String get preferNotToSay => 'Préfère ne pas répondre';

  @override
  String get goToFinalCheckIn => 'Aller au bilan final';

  @override
  String get iAmA => 'Je suis...';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get fieldRequired => 'Ce champ est obligatoire';

  @override
  String get invalidEmail => 'Veuillez entrer un e-mail valide';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit comporter au moins 6 caractères';

  @override
  String get invalidPhoneNumber =>
      'Veuillez entrer un numéro de téléphone valide';

  @override
  String get registrationSuccess => 'Inscription réussie !';

  @override
  String get registrationFailed =>
      'L\'inscription a échoué. Veuillez réessayer.';

  @override
  String get emailAlreadyInUse => 'Cet e-mail est déjà utilisé';

  @override
  String get weakPassword => 'Le mot de passe est trop faible';

  @override
  String get networkError =>
      'Erreur réseau. Veuillez vérifier votre connexion.';

  @override
  String get selectGender => 'Sélectionner le genre';

  @override
  String get selectDate => 'Sélectionner la date';

  @override
  String get languageShort => 'Fra';

  @override
  String get breathingExercisesTitle => 'Exercices de respiration';

  @override
  String get goldenBreathTitle => 'Respiration dorée';

  @override
  String get goldenBreathDesc =>
      'Exercice court (6s) pour redonner de l\'énergie.';

  @override
  String get butterflyBreathTitle => 'Respiration papillon';

  @override
  String get butterflyBreathDesc =>
      'Exercice calme (10s) pour une relaxation profonde.';

  @override
  String get oceanBreathTitle => 'Respiration de l\'océan';

  @override
  String get oceanBreathDesc => 'Exercice (8s) imitant les vagues de l\'océan.';

  @override
  String get forestBreathTitle => 'Respiration de la forêt';

  @override
  String get forestBreathDesc => 'Exercice doux (7s) pour l\'équilibre.';

  @override
  String get seconds => 'secondes';

  @override
  String startExercise(String exercise) {
    return 'Démarrer $exercise...';
  }

  @override
  String get whyBreatheTitle => 'Pourquoi respirer consciemment ?';

  @override
  String get whyBreatheDesc =>
      'Les exercices de respiration aident à calmer l\'esprit, réduire le stress et améliorer la concentration. C\'est une façon magique de se ressourcer ou de se détendre.';

  @override
  String get whyMusicTitle => 'Pourquoi écouter de la musique calme ?';

  @override
  String get whyMusicDesc =>
      'La musique calme aide à créer un environnement paisible, réduit l\'anxiété et favorise la relaxation. Elle est parfaite pour la méditation, l\'étude ou le coucher.';

  @override
  String get whyStoriesTitle => 'Pourquoi lire des histoires ?';

  @override
  String get whyStoriesDesc =>
      'Les histoires stimulent l\'imagination, enseignent des leçons précieuses et aident les enfants à se détendre. C\'est une merveilleuse façon de décompresser et de rêver grand !';

  @override
  String get whyFocusGamesTitle =>
      'Pourquoi jouer à des jeux de concentration ?';

  @override
  String get whyFocusGamesDesc =>
      'Les jeux de concentration aident à améliorer la concentration, la mémoire et les capacités cognitives. C\'est une façon amusante d\'entraîner votre cerveau et de booster votre agilité mentale !';

  @override
  String get breatheIn => 'Inspirez';

  @override
  String get breatheOut => 'Expirez';

  @override
  String get cycle => 'Cycle';

  @override
  String get complete => 'Terminé !';

  @override
  String breathingComplete(String exercise) {
    return '🎉 $exercise terminé ! ✨';
  }

  @override
  String get focusGamesTitle => 'Jeux de concentration';

  @override
  String get memoryFlipTitle => 'Mémoire Flip';

  @override
  String get memoryFlipDesc =>
      'Associez les paires de cartes pour améliorer la mémoire et la concentration';

  @override
  String get moves => 'Coups';

  @override
  String get time => 'Temps';

  @override
  String get gameComplete => 'Jeu terminé !';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get wellDone => 'Bien joué !';

  @override
  String get calmMusicTitle => 'Musique calme';

  @override
  String get rainSounds => 'Sons de pluie';

  @override
  String get rainSoundsDesc => 'Une pluie douce pour calmer votre esprit';

  @override
  String get natureAmbience => 'Ambiance nature';

  @override
  String get natureAmbienceDesc => 'Sons paisibles de la nature';

  @override
  String get oceanWaves => 'Vagues de l\'océan';

  @override
  String get oceanWavesDesc => 'Vagues apaisantes de l\'océan';

  @override
  String get calmMusicTrack => 'Musique calme';

  @override
  String get calmMusicTrackDesc => 'Mélodies relaxantes pour la paix';

  @override
  String get storiesTitle => 'Histoires';

  @override
  String get braveStarTitle => 'La petite étoile courageuse';

  @override
  String get braveStarDesc => 'Un conte de courage et de confiance en soi';

  @override
  String get magicGardenTitle => 'Le jardin magique';

  @override
  String get magicGardenDesc => 'Découvrez la magie de la gentillesse';

  @override
  String get friendlyDragonTitle => 'Le dragon amical';

  @override
  String get friendlyDragonDesc => 'Une histoire réconfortante sur l\'amitié';

  @override
  String get braveStarPage1 =>
      'Il était une fois, dans le vaste ciel nocturne, une petite étoile nommée Stella. Elle était la plus petite étoile de sa constellation, mais elle avait les plus grands rêves.';

  @override
  String get braveStarPage2 =>
      'Chaque nuit, Stella regardait les autres étoiles briller intensément. « J\'aimerais pouvoir briller aussi fort qu\'elles », chuchotait-elle à la lune.';

  @override
  String get braveStarPage3 =>
      'Une nuit, un nuage sombre couvrit le ciel. Toutes les grandes étoiles se cachèrent derrière lui, craignant de briller. Mais Stella pensa : « Quelqu\'un doit éclairer le chemin pour les enfants en bas. »';

  @override
  String get braveStarPage4 =>
      'Avec tout son courage, Stella traversa le nuage. C\'était difficile et effrayant, mais elle continua. Sa lumière commença à briller de plus en plus fort !';

  @override
  String get braveStarPage5 =>
      'Les enfants sur Terre levèrent les yeux et virent la lumière courageuse de Stella. « Regardez ! Une étoile filante ! » s\'écrièrent-ils. Stella comprit qu\'elle n\'avait pas besoin d\'être la plus grande pour faire une différence.';

  @override
  String get braveStarPage6 =>
      'Depuis cette nuit-là, Stella brilla avec confiance. Elle apprit qu\'être courageux ne signifie pas ne pas avoir peur, mais briller malgré tout. Fin. ⭐';

  @override
  String get magicGardenPage1 =>
      'Dans un coin tranquille du monde, il y avait un jardin magique qui n\'apparaissait qu\'à ceux qui croyaient vraiment à la magie.';

  @override
  String get magicGardenPage2 =>
      'Une fille curieuse nommée Maya adorait explorer. Un jour ensoleillé, elle suivit un papillon doré et découvrit une porte cachée couverte de vignes.';

  @override
  String get magicGardenPage3 =>
      'Lorsque Maya toucha la porte, elle s\'ouvrit avec une lueur douce. À l\'intérieur se trouvait le plus beau jardin qu\'elle ait jamais vu : des fleurs qui chantaient, des arbres qui dansaient et des ruisseaux qui scintillaient comme des diamants.';

  @override
  String get magicGardenPage4 =>
      'Au centre du jardin se tenait un vieil arbre sage. « Bienvenue, Maya », dit-il d\'une voix chaleureuse. « Ce jardin grandit grâce à la gentillesse et aux soins. Veux-tu l\'aider à s\'épanouir ? »';

  @override
  String get magicGardenPage5 =>
      'Maya arrosa les fleurs, chanta aux arbres et aida les petites créatures. À chaque acte de gentillesse, le jardin devenait plus vibrant et magique.';

  @override
  String get magicGardenPage6 =>
      'Au moment de partir, l\'arbre donna à Maya une graine spéciale. « Plante ceci dans ton cœur », dit-il. « La gentillesse est la vraie magie. » Maya sourit, sachant qu\'elle pouvait créer de la magie n\'importe où. Fin. 🌸';

  @override
  String get friendlyDragonPage1 =>
      'Haut dans les montagnes brumeuses vivait un dragon nommé Ember. Contrairement aux autres dragons, Ember ne voulait pas garder de trésors ni cracher du feu sur les chevaliers.';

  @override
  String get friendlyDragonPage2 =>
      'Ember voulait simplement un ami. Mais chaque fois qu\'il volait vers le village, les gens s\'enfuyaient en criant. « Je ne suis pas effrayant ! » criait Ember, mais personne ne restait pour écouter.';

  @override
  String get friendlyDragonPage3 =>
      'Un jour, un petit garçon courageux nommé Léo se perdit dans les montagnes. Alors que la nuit tombait et que le vent froid soufflait, Léo commença à pleurer. C\'est alors qu\'il vit une lueur orange chaleureuse.';

  @override
  String get friendlyDragonPage4 =>
      'C\'était Ember ! Le dragon souffla doucement de l\'air chaud pour garder Léo au chaud. « N\'aie pas peur », dit doucement Ember. « Je vais t\'aider à rentrer chez toi. »';

  @override
  String get friendlyDragonPage5 =>
      'Ember ramena Léo en toute sécurité au village. Quand les gens virent à quel point le dragon était gentil et doux, ils comprirent qu\'ils avaient eu tort de le juger sur son apparence.';

  @override
  String get friendlyDragonPage6 =>
      'Depuis ce jour, Ember eut de nombreux amis dans le village. Il apprit que la véritable amitié vient à ceux qui sont gentils et patients. Et Léo apprit que les plus grands cœurs se cachent parfois sous les formes les plus inattendues. Fin. 🐉';

  @override
  String get dtNewTask => 'Nouvelle tâche';

  @override
  String get dtTaskTitlePlaceholder => 'Sur quoi veux-tu te concentrer ?';

  @override
  String get dtTaskDurationLabel => 'Durée (minutes)';

  @override
  String get dtAddButton => 'Ajouter';

  @override
  String get dtCancelButton => 'Annuler';

  @override
  String get howAreYouFeeling => 'Comment te sens-tu ?';

  @override
  String get activityLevel => 'Niveau d\'activité (1-10)';

  @override
  String get quiet => 'Calme';

  @override
  String get hyper => 'Hyper';

  @override
  String get guidedBodyScan => 'Scan corporel guidé';

  @override
  String get bodyScanDesc => 'Fais un bilan de chaque partie de ton corps.';

  @override
  String get saveSession => 'Enregistrer ma séance';

  @override
  String get connectWatch => 'Connecte ta montre';

  @override
  String get watchScanning => 'Recherche de ta montre...';

  @override
  String get watchFound => 'Montre trouvée !';

  @override
  String get watchConnecting => 'Connexion à ta montre...';

  @override
  String get watchError =>
      'Impossible de trouver ta montre. Est-elle allumée ?';

  @override
  String get pairNow => 'Jumeler maintenant';

  @override
  String get availableDevices => 'Appareils disponibles';

  @override
  String get noDevicesFound => 'Aucun appareil trouvé à proximité.';

  @override
  String get retryScan => 'Relancer le scan';

  @override
  String get stopTechnique => 'Technique STOP';

  @override
  String get stopStep1Title => 'S - Stop';

  @override
  String get stopStep1Desc => 'Arrête ce que tu fais. Prends un instant.';

  @override
  String get stopStep2Title => 'T - Respire';

  @override
  String get stopStep2Desc =>
      'Prends une respiration lente et profonde. Ressens-la.';

  @override
  String get stopStep3Title => 'O - Observe';

  @override
  String get stopStep3Desc => 'Remarque tes pensées et tes émotions.';

  @override
  String get stopStep4Title => 'P - Continue';

  @override
  String get stopStep4Desc =>
      'Continue avec plus de calme et de concentration.';

  @override
  String get breatheWithMe => 'Respire avec moi';

  @override
  String get feelingCooler => 'Je me sens plus calme maintenant !';

  @override
  String get expressYourself => 'Exprime-toi';

  @override
  String get mindfulnessPrompts => 'Conseils de pleine conscience';

  @override
  String get drawingCanvas => 'Tableau de dessin';

  @override
  String get clearCanvas => 'Effacer';

  @override
  String get saveDrawing => 'Enregistrer';

  @override
  String get calmingSounds => 'Sons apaisants';

  @override
  String get bedtimeStories => 'Histoires du soir';

  @override
  String get mindfulness => 'Pleine conscience';

  @override
  String get friend => 'Ami';

  @override
  String get emotionHappy => 'Heureux';

  @override
  String get emotionSad => 'Triste';

  @override
  String get emotionAngry => 'En colère';

  @override
  String get emotionAnxious => 'Anxieux';

  @override
  String get emotionCalm => 'Calme';

  @override
  String get emotionTired => 'Fatigué';

  @override
  String get reportSaved => 'Rapport enregistré ! Tu t\'en sors très bien.';

  @override
  String errorOccurred(String error) {
    return 'Oups ! Erreur : $error';
  }

  @override
  String get bsStartFeetTitle => 'Commence avec les pieds';

  @override
  String get bsStartFeetDesc =>
      'Remue tes orteils. Sens-les toucher le sol. Détends-les maintenant.';

  @override
  String get bsMovingLegsTitle => 'Passe aux jambes';

  @override
  String get bsMovingLegsDesc =>
      'Contracte les muscles de tes jambes pendant une seconde... et relâche-les.';

  @override
  String get bsRelaxTummyTitle => 'Détends ton ventre';

  @override
  String get bsRelaxTummyDesc =>
      'Pose ta main sur ton ventre. Sens-le monter et descendre en respirant.';

  @override
  String get bsSoftShouldersTitle => 'Épaules souples';

  @override
  String get bsSoftShouldersDesc =>
      'Monte tes épaules jusqu\'à tes oreilles... puis laisse-les retomber lourdement.';

  @override
  String get bsPeacefulFaceTitle => 'Visage apaisé';

  @override
  String get bsPeacefulFaceDesc =>
      'Fais un grand sourire... puis détends complètement ton visage. Tu te débrouilles super bien !';

  @override
  String get bsPeacefulButton => 'Je me sens apaisé';

  @override
  String get dtGreatJob => 'Bien joué !';

  @override
  String get dtSessionFinished => 'Tu as terminé ta séance de concentration !';

  @override
  String get dtAwesome => 'Génial !';

  @override
  String dtProgress(String completed, String total) {
    return '$completed sur $total terminés';
  }

  @override
  String get dtTaskList => 'Liste des tâches';

  @override
  String get dtNoTasks => 'Aucune tâche pour aujourd\'hui';

  @override
  String get dtNoTasksDesc => 'Ajoute une tâche pour commencer ta journée !';

  @override
  String get galleryPermissionRequired =>
      'L\'autorisation d\'accès à la galerie est requise pour enregistrer les dessins.';

  @override
  String get savedToGallery => 'Enregistré dans la galerie ! 🎨';

  @override
  String galleryError(String error) {
    return 'Erreur de galerie : $error';
  }

  @override
  String saveError(String error) {
    return 'Erreur d\'enregistrement : $error';
  }

  @override
  String get errorLoadingStories => 'Erreur lors du chargement des histoires';

  @override
  String get noStoriesAvailable => 'Aucune histoire disponible';

  @override
  String pagesCount(int count) {
    return '$count pages';
  }

  @override
  String pageIndicator(int current, int total) {
    return 'Page $current sur $total';
  }

  @override
  String get swipeToTurnPage => 'Balaye pour tourner la page';

  @override
  String get theEnd => 'Fin';

  @override
  String get liveHeartbeatMotion => 'Rythme Cardiaque et Mouvement en Direct';

  @override
  String get motionZ => 'Mouvement (Z)';

  @override
  String get energy => 'Énergie';

  @override
  String get liveTag => 'DIRECT';

  @override
  String get statsAndReports => 'Statistiques et Rapports';

  @override
  String get errorLoadingStats => 'Erreur lors du chargement des statistiques';

  @override
  String get activityTrends => 'Tendances d\'activité';

  @override
  String get activityTrendsDesc => 'Sessions totales et temps quotidien';

  @override
  String get stressRegulation => 'Régulation du stress';

  @override
  String get stressRegulationDesc => 'Niveaux de stress avant et après';

  @override
  String get protocolProgressTitle => 'Progrès du protocole';

  @override
  String get protocolProgressDesc => 'Statut du parcours de 5 semaines';

  @override
  String get exportReports => 'Exporter des rapports';

  @override
  String get pdfReport => 'Rapport PDF';

  @override
  String get csvData => 'Données CSV';

  @override
  String get sessions => 'Séances';

  @override
  String get calmTime => 'Temps de calme';

  @override
  String get avgStressReduction => 'Réduction moyenne du stress';

  @override
  String get timeRangeWeek => 'Semaine';

  @override
  String get timeRangeMonth => 'Mois';

  @override
  String get timeRangeFiveWeeks => '5 Semaines';

  @override
  String get noProtocolData => 'Pas encore de données de protocole';

  @override
  String errorExporting(String type, String error) {
    return 'Erreur d\'exportation $type: $error';
  }

  @override
  String get achFirstBreathing => 'Premier Souffle';

  @override
  String get achFirstBreathingDesc =>
      'Terminez votre premier exercice de respiration.';

  @override
  String get achBreathing5 => 'Respiration Constante';

  @override
  String get achBreathing5Desc => 'Terminez 5 exercices de respiration.';

  @override
  String get achBreathing10 => 'Expert en Respiration';

  @override
  String get achBreathing10Desc => 'Terminez 10 exercices de respiration.';

  @override
  String get achBreathingMaster => 'Maître de la Respiration';

  @override
  String get achBreathingMasterDesc => 'Terminez 30 exercices de respiration.';

  @override
  String get achFirstFocus => 'Esprit Focalisé';

  @override
  String get achFirstFocusDesc =>
      'Terminez votre premier exercice de concentration.';

  @override
  String get achFocusChampion => 'Champion de la Concentration';

  @override
  String get achFocusChampionDesc => 'Terminez 20 exercices de concentration.';

  @override
  String get achMusicBeginner => 'Âme Musicale';

  @override
  String get achMusicBeginnerDesc => 'Écoutez 5 pistes apaisantes.';

  @override
  String get achMusicExpert => 'Enthousiaste de Musique';

  @override
  String get achMusicExpertDesc => 'Écoutez 25 pistes apaisantes.';

  @override
  String get achStoryStarter => 'Auditeur d\'Histoires';

  @override
  String get achStoryStarterDesc => 'Écoutez 3 histoires.';

  @override
  String get achStoryMaster => 'Fanatique de Fables';

  @override
  String weekLabel(int weekNum) {
    return 'Semaine $weekNum';
  }

  @override
  String get weekPrefix => 'SEMAINE';

  @override
  String get continueTraining => 'Continue les habitudes d\'entraînement';

  @override
  String get focusQuest => 'Quête de concentration';

  @override
  String get mindfulStories => 'Histoires de pleine conscience';

  @override
  String get calmingRhythms => 'Rythmes apaisants';

  @override
  String get finalDiscoveryDashboard => 'Tableau de bord de découverte final';

  @override
  String get protocolAnalytics => 'Analytique du protocole';

  @override
  String get avgStressLevel => 'Niveau de stress moyen';

  @override
  String get avgActivityLevel => 'Niveau d\'activité moyen';

  @override
  String get weeklyBreakdown => 'Répartition hebdomadaire';

  @override
  String get noProtocolDataDesc =>
      'Les statistiques apparaîtront au fur et à mesure de l\'achèvement des activités.';

  @override
  String weekDetail(int index) {
    return 'Semaine $index';
  }

  @override
  String sessionsCount(int count) {
    return '$count sessions';
  }

  @override
  String stressPercentage(int percentage) {
    return '$percentage% Stress';
  }

  @override
  String get achStoryMasterDesc => 'Écoutez 15 histoires.';

  @override
  String get achStreak3 => 'Série de 3 Jours';

  @override
  String get achStreak3Desc => 'Maintenez une série d\'activité de 3 jours.';

  @override
  String get achStreak7 => 'Guerrier de la Semaine';

  @override
  String get achStreak7Desc => 'Maintenez une série d\'activité de 7 jours.';

  @override
  String get achStreak14 => 'Triomphe de Deux Semaines';

  @override
  String get achStreak14Desc => 'Maintenez une série d\'activité de 14 jours.';

  @override
  String get achStreak30 => 'Maître Mensuel';

  @override
  String get achStreak30Desc => 'Maintenez une série d\'activité de 30 jours.';

  @override
  String get achEarlyBird => 'Lève-tôt';

  @override
  String get achEarlyBirdDesc => 'Terminez 5 sessions avant 9h du matin.';

  @override
  String get achCalm10 => '10 Minutes de Calme';

  @override
  String get achCalm10Desc => 'Restez dans un état calme pendant 10 minutes.';

  @override
  String get achCalm30 => '30 Minutes de Calme';

  @override
  String get achCalm30Desc => 'Restez dans un état calme pendant 30 minutes.';

  @override
  String get achCalm60 => 'Heure de Paix';

  @override
  String get achCalm60Desc => 'Restez dans un état calme pendant 1 heure.';

  @override
  String get achReduceHyper20 => 'Réducteur d\'Hyperactivité';

  @override
  String get achReduceHyper20Desc =>
      'Réduisez l\'hyperactivité de 20% lors d\'une session.';

  @override
  String get achReduceHyper50 => 'Roi du Calme';

  @override
  String get achReduceHyper50Desc =>
      'Réduisez l\'hyperactivité de 50% lors d\'une session.';

  @override
  String get achPerfectPosture => 'Équilibre Parfait';

  @override
  String get achPerfectPostureDesc =>
      'Maintenez une posture parfaite pendant 15 minutes.';

  @override
  String get achFirstDay => 'Premier Jour';

  @override
  String get achFirstDayDesc =>
      'Terminez votre premier jour avec le protocole.';

  @override
  String get achFirstWeek => 'Succès de Sept Jours';

  @override
  String get achFirstWeekDesc => 'Terminez votre première semaine complète.';

  @override
  String get achFirstMonth => 'Pro du Protocole';

  @override
  String get achFirstMonthDesc => 'Terminez votre premier mois complet.';

  @override
  String get achTasks100 => 'Centurion';

  @override
  String get achTasks100Desc => 'Terminez 100 tâches du protocole.';

  @override
  String get achTasks500 => 'À Moitié Chemin de Mille';

  @override
  String get achTasks500Desc => 'Terminez 500 tâches du protocole.';

  @override
  String get achTasks1000 => 'Titan des Tâches';

  @override
  String get achTasks1000Desc => 'Terminez 1000 tâches du protocole.';

  @override
  String get achQuickLearner => 'Apprenti Rapide';

  @override
  String get achQuickLearnerDesc =>
      'Terminez 5 nouveaux exercices en une journée.';

  @override
  String get achOverachiever => 'Surdoué';

  @override
  String get achOverachieverDesc =>
      'Terminez toutes les tâches du protocole 7 jours de suite.';

  @override
  String get achCalmMaster => 'Maître Zen';

  @override
  String get achCalmMasterDesc =>
      'Maintenez un calme maximal lors d\'une tâche difficile.';

  @override
  String get achExplorer => 'Explorateur Curieux';

  @override
  String get achExplorerDesc =>
      'Essayez chaque type d\'exercice au moins une fois.';

  @override
  String get rarityCommon => 'Commun';

  @override
  String get rarityRare => 'Rare';

  @override
  String get rarityEpic => 'Épique';

  @override
  String get rarityLegendary => 'Légendaire';

  @override
  String get howToUnlock => 'Comment débloquer';

  @override
  String get achievementUnlocked => 'Débloqué';

  @override
  String get achievementLocked => 'Verrouillé';

  @override
  String get achProgress => 'Progrès';

  @override
  String achPointsCount(int count) {
    return '+$count Points';
  }

  @override
  String get achUnlockedTitle => 'Débloqué !';

  @override
  String get loginToViewAchievements =>
      'Veuillez vous connecter pour voir vos trophées';

  @override
  String get errorLoadingAchievements =>
      'Erreur lors du chargement des trophées';

  @override
  String get totalPointsLabel => 'Points Totaux';

  @override
  String levelIndicator(int level) {
    return 'Niveau $level';
  }

  @override
  String achievementsCount(int unlocked, int total) {
    return '$unlocked/$total Trophées';
  }

  @override
  String get categoryAll => 'Tout';

  @override
  String get categoryExercise => 'Exercice';

  @override
  String get categoryStreaks => 'Séries';

  @override
  String get categoryCalm => 'Calme';

  @override
  String get categoryMilestones => 'Étapes';

  @override
  String get categorySpecial => 'Spécial';

  @override
  String get showOnlyUnlocked => 'Voir uniquement débloqués';

  @override
  String get noAchievementsFound => 'Aucun trophée trouvé';

  @override
  String get parentOverview => 'Vue d\'ensemble';

  @override
  String get protocolRoadmap => 'Feuille de route du protocole';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get streak => 'Série';

  @override
  String get recentActivity => 'Activité récente';

  @override
  String get noRecentActivity => 'Aucune activité récente';

  @override
  String get weekTitleRegulationSafety => 'Régulation et\\nsécurité';

  @override
  String get weekTitleFocusControl => 'Focus et\\ncontrôle';

  @override
  String get weekTitleDailyStructure => 'Structure\\nquotidienne';

  @override
  String get weekTitleCreativeCalm => 'Calme\\ncréatif';

  @override
  String get weekTitleIntegrationReview => 'Intégration et\\nrévision';

  @override
  String get selectChildToView =>
      'Sélectionnez un enfant pour voir ses progrès';

  @override
  String get childProfile => 'Profil de l\'enfant';

  @override
  String get noChildSelected => 'Aucun enfant sélectionné';

  @override
  String get createChildToStart => 'Créez un compte enfant pour commencer';

  @override
  String get createChildAccountLabel => 'Créer un compte enfant';

  @override
  String get manageChild => 'Gérer l\'enfant';

  @override
  String get rewardsAndEncouragement => 'Récompenses et Encouragements';

  @override
  String get sendMessage => 'Envoyer un message';

  @override
  String get sendMessageDesc => 'Envoyer un message à votre enfant';

  @override
  String get recentAchievements => 'Réalisations récentes';

  @override
  String get noAchievementsYet => 'Pas encore de réalisations. Continuez!';

  @override
  String get sendSticker => 'Envoyer un sticker';

  @override
  String get sendStickerDesc => 'Envoyer un badge de motivation';

  @override
  String get accountSafety => 'Sécurité du compte';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordDesc =>
      'Envoyer un e-mail de récupération à l\'enfant';

  @override
  String get removeChild => 'Supprimer l\'enfant';

  @override
  String get removeChildDesc => 'Dissocier le compte du parent';

  @override
  String get watchStatus => 'Statut de la montre';

  @override
  String get online => 'En ligne';

  @override
  String get offline => 'Hors ligne';

  @override
  String get device => 'Appareil';

  @override
  String get battery => 'Batterie';

  @override
  String lastSyncedAt(String timestamp) {
    return 'Dernière synchro : $timestamp';
  }

  @override
  String ageYearsOld(String age) {
    return '$age ans';
  }
}
