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
}
