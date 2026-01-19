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
  String get onboardingQuestion1 => 'Quelle phrasevous décrit le mieux?';

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
  String get achievements => 'Réussites';

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
      'Quand souhaitez-vous vous enregistrer quotidiennement?';

  @override
  String get reminderHabitText =>
      'Un rappel doux vous aide à créer une habitude.';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get tellUsMoreTitle => 'Parlez-nous de vous';

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
  String get email => 'Email';

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
  String get preferNotToSay => 'Préfère ne pas dire';

  @override
  String get goToFinalCheckIn => 'Aller au contrôle final';

  @override
  String get iAmA => 'Je suis un...';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get fieldRequired => 'Ce champ est obligatoire';

  @override
  String get invalidEmail => 'Veuillez entrer un email valide';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get invalidPhoneNumber =>
      'Veuillez entrer un numéro de téléphone valide';

  @override
  String get registrationSuccess => 'Inscription réussie!';

  @override
  String get registrationFailed =>
      'L\'inscription a échoué. Veuillez réessayer.';

  @override
  String get emailAlreadyInUse => 'Cet email est déjà utilisé';

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
  String get breathingExercisesTitle => 'Exercices de Respiration';

  @override
  String get goldenBreathTitle => 'Respiration Dorée';

  @override
  String get goldenBreathDesc => 'Exercice court (6s) pour l\'énergie.';

  @override
  String get butterflyBreathTitle => 'Respiration Papillon';

  @override
  String get butterflyBreathDesc =>
      'Exercice calme (10s) pour relaxation profonde.';

  @override
  String get oceanBreathTitle => 'Respiration Océan';

  @override
  String get oceanBreathDesc => 'Exercice (8s) imitant les vagues de l\'océan.';

  @override
  String get forestBreathTitle => 'Respiration Forêt';

  @override
  String get forestBreathDesc => 'Exercice doux (7s) pour l\'équilibre.';

  @override
  String get seconds => 'secondes';

  @override
  String startExercise(String exercise) {
    return 'Démarrer $exercise...';
  }

  @override
  String get whyBreatheTitle => 'Pourquoi respirer consciemment?';

  @override
  String get whyBreatheDesc =>
      'Les exercices de respiration aident à calmer l\'esprit, réduire le stress et améliorer la concentration. C\'est une façon magique de se ressourcer ou de se détendre.';

  @override
  String get whyMusicTitle => 'Pourquoi écouter de la musique calme?';

  @override
  String get whyMusicDesc =>
      'La musique calme aide à créer un environnement paisible, réduit l\'anxiété et améliore la relaxation. C\'est parfait pour la méditation, l\'étude ou l\'heure du coucher.';

  @override
  String get whyStoriesTitle => 'Pourquoi lire des histoires?';

  @override
  String get whyStoriesDesc =>
      'Les histoires stimulent l\'imagination, enseignent des leçons précieuses et aident les enfants à se détendre. C\'est une merveilleuse façon de se relaxer et de rêver grand!';

  @override
  String get breatheIn => 'Inspirez';

  @override
  String get breatheOut => 'Expirez';

  @override
  String get cycle => 'Cycle';

  @override
  String get complete => 'Terminé!';

  @override
  String breathingComplete(String exercise) {
    return '🎉 $exercise Terminé! ✨';
  }

  @override
  String get focusGamesTitle => 'Jeux de Concentration';

  @override
  String get memoryFlipTitle => 'Retournement de Mémoire';

  @override
  String get memoryFlipDesc =>
      'Associez des paires de cartes pour améliorer la mémoire et la concentration';

  @override
  String get moves => 'Mouvements';

  @override
  String get time => 'Temps';

  @override
  String get gameComplete => 'Jeu Terminé!';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get wellDone => 'Bien Joué!';

  @override
  String get calmMusicTitle => 'Musique Calme';

  @override
  String get rainSounds => 'Sons de Pluie';

  @override
  String get rainSoundsDesc => 'Pluie douce pour calmer votre esprit';

  @override
  String get natureAmbience => 'Ambiance Nature';

  @override
  String get natureAmbienceDesc => 'Sons paisibles de la nature';

  @override
  String get oceanWaves => 'Vagues de l\'Océan';

  @override
  String get oceanWavesDesc => 'Vagues apaisantes de l\'océan';

  @override
  String get calmMusicTrack => 'Musique Calme';

  @override
  String get calmMusicTrackDesc => 'Mélodies relaxantes pour la paix';

  @override
  String get storiesTitle => 'Histoires';

  @override
  String get braveStarTitle => 'La Petite Étoile Courageuse';

  @override
  String get braveStarDesc => 'Un conte sur le courage et la confiance en soi';

  @override
  String get magicGardenTitle => 'Le Jardin Magique';

  @override
  String get magicGardenDesc => 'Découvrez la magie de la gentillesse';

  @override
  String get friendlyDragonTitle => 'Le Dragon Amical';

  @override
  String get friendlyDragonDesc => 'Une histoire touchante sur l\'amitié';

  @override
  String get braveStarPage1 =>
      'Il était une fois, dans le vaste ciel nocturne, une petite étoile nommée Stella. Elle était la plus petite étoile de sa constellation, mais elle avait les plus grands rêves.';

  @override
  String get braveStarPage2 =>
      'Chaque nuit, Stella regardait les autres étoiles briller intensément. \"J\'aimerais briller aussi fort qu\'elles\", murmurait-elle à la lune.';

  @override
  String get braveStarPage3 =>
      'Une nuit, un nuage sombre couvrit le ciel. Toutes les grandes étoiles se cachèrent derrière, effrayées de briller. Mais Stella pensa: \"Quelqu\'un doit éclairer le chemin pour les enfants en bas.\"';

  @override
  String get braveStarPage4 =>
      'Avec tout son courage, Stella traversa le nuage. C\'était difficile et effrayant, mais elle continua. Sa lumière commença à briller de plus en plus fort!';

  @override
  String get braveStarPage5 =>
      'Les enfants sur Terre levèrent les yeux et virent la lumière courageuse de Stella. \"Regardez! Une étoile filante!\" s\'écrièrent-ils. Stella réalisa qu\'elle n\'avait pas besoin d\'être la plus grande pour faire une différence.';

  @override
  String get braveStarPage6 =>
      'À partir de cette nuit, Stella brilla avec confiance. Elle apprit qu\'être courageux ne signifie pas ne pas avoir peur - cela signifie briller quand même. Fin. ⭐';

  @override
  String get magicGardenPage1 =>
      'Dans un coin tranquille du monde, il y avait un jardin magique qui n\'apparaissait qu\'à ceux qui croyaient vraiment en la magie.';

  @override
  String get magicGardenPage2 =>
      'Une fille curieuse nommée Maya adorait explorer. Un jour ensoleillé, elle suivit un papillon doré et découvrit une porte cachée couverte de vignes.';

  @override
  String get magicGardenPage3 =>
      'Quand Maya toucha la porte, elle s\'ouvrit avec une douce lueur. À l\'intérieur se trouvait le plus beau jardin qu\'elle ait jamais vu - des fleurs qui chantaient, des arbres qui dansaient et des ruisseaux qui scintillaient comme des diamants.';

  @override
  String get magicGardenPage4 =>
      'Au centre du jardin se tenait un vieil arbre sage. \"Bienvenue, Maya\", dit-il d\'une voix chaleureuse. \"Ce jardin grandit grâce à la gentillesse et aux soins. M\'aideras-tu à le faire fleurir?\"';

  @override
  String get magicGardenPage5 =>
      'Maya arrosa les fleurs, chanta aux arbres et aida les petites créatures. À chaque acte de gentillesse, le jardin devenait plus vibrant et magique.';

  @override
  String get magicGardenPage6 =>
      'Quand il fut temps de partir, l\'arbre donna à Maya une graine spéciale. \"Plante-la dans ton cœur\", dit-il. \"La gentillesse est la vraie magie.\" Maya sourit, sachant qu\'elle pouvait créer de la magie n\'importe où. Fin. 🌸';

  @override
  String get friendlyDragonPage1 =>
      'Haut dans les montagnes brumeuses vivait un dragon nommé Ember. Contrairement aux autres dragons, Ember ne voulait pas garder de trésor ni cracher du feu sur les chevaliers.';

  @override
  String get friendlyDragonPage2 =>
      'Ember voulait juste un ami. Mais chaque fois qu\'il descendait au village, les gens s\'enfuyaient en criant. \"Je ne suis pas effrayant!\" criait Ember, mais personne ne restait pour écouter.';

  @override
  String get friendlyDragonPage3 =>
      'Un jour, un petit garçon courageux nommé Leo se perdit dans les montagnes. Alors que la nuit tombait et que le vent froid soufflait, Leo commença à pleurer. C\'est alors qu\'il vit une lueur orange et chaude.';

  @override
  String get friendlyDragonPage4 =>
      'C\'était Ember! Le dragon souffla doucement de l\'air chaud pour garder Leo au chaud. \"N\'aie pas peur\", dit Ember doucement. \"Je vais t\'aider à rentrer chez toi.\"';

  @override
  String get friendlyDragonPage5 =>
      'Ember ramena Leo en toute sécurité au village. Quand les gens virent à quel point le dragon était gentil et doux, ils réalisèrent qu\'ils avaient eu tort de le juger sur son apparence.';

  @override
  String get friendlyDragonPage6 =>
      'À partir de ce jour, Ember eut de nombreux amis au village. Il apprit que la vraie amitié vient à ceux qui sont gentils et patients. Et Leo apprit que les plus grands cœurs viennent parfois sous les formes les plus inattendues. Fin. 🐉';
}
