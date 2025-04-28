import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bs.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bs'),
    Locale('en')
  ];

  /// No description provided for @language_name.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_name;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @authors.
  ///
  /// In en, this message translates to:
  /// **'Authors'**
  String get authors;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @admins.
  ///
  /// In en, this message translates to:
  /// **'Administrators'**
  String get admins;

  /// No description provided for @genres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get genres;

  /// No description provided for @quizes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get quizes;

  /// No description provided for @profile_settings.
  ///
  /// In en, this message translates to:
  /// **'Profile settings'**
  String get profile_settings;

  /// No description provided for @train_recommend.
  ///
  /// In en, this message translates to:
  /// **'Train recommendation'**
  String get train_recommend;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @wrote.
  ///
  /// In en, this message translates to:
  /// **'Wrote in'**
  String get wrote;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_out;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @birth_year.
  ///
  /// In en, this message translates to:
  /// **'Birth year'**
  String get birth_year;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @no_quizzes.
  ///
  /// In en, this message translates to:
  /// **'No added quizzes'**
  String get no_quizzes;

  /// No description provided for @lname.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lname;

  /// No description provided for @telphone.
  ///
  /// In en, this message translates to:
  /// **'Telephone'**
  String get telphone;

  /// No description provided for @change_email.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get change_email;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get change_password;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get biography;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @mfield.
  ///
  /// In en, this message translates to:
  /// **'Mandatory field'**
  String get mfield;

  /// No description provided for @su_mod_profie.
  ///
  /// In en, this message translates to:
  /// **'Profile is successfully updated.'**
  String get su_mod_profie;

  /// No description provided for @choose_image.
  ///
  /// In en, this message translates to:
  /// **'Choose image'**
  String get choose_image;

  /// No description provided for @change_image.
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get change_image;

  /// No description provided for @mvalue.
  ///
  /// In en, this message translates to:
  /// **'You have to input value'**
  String get mvalue;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalid_email;

  /// No description provided for @reg_password.
  ///
  /// In en, this message translates to:
  /// **'Password has to contain at least 8 characters, lowercase and uppercase letters and numbers.'**
  String get reg_password;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @short_desc.
  ///
  /// In en, this message translates to:
  /// **'Short description'**
  String get short_desc;

  /// No description provided for @publishing_year.
  ///
  /// In en, this message translates to:
  /// **'Publishing year'**
  String get publishing_year;

  /// No description provided for @mod_b_genres.
  ///
  /// In en, this message translates to:
  /// **'Modify book\'s genres'**
  String get mod_b_genres;

  /// No description provided for @mod_b_quotes.
  ///
  /// In en, this message translates to:
  /// **'Modify book\'s quotes'**
  String get mod_b_quotes;

  /// No description provided for @mod_b_rates.
  ///
  /// In en, this message translates to:
  /// **'Book\'s rates'**
  String get mod_b_rates;

  /// No description provided for @change_doc.
  ///
  /// In en, this message translates to:
  /// **'Change document'**
  String get change_doc;

  /// No description provided for @choose_doc.
  ///
  /// In en, this message translates to:
  /// **'Choose document'**
  String get choose_doc;

  /// No description provided for @no_doc.
  ///
  /// In en, this message translates to:
  /// **'Pdf document isn\'t added'**
  String get no_doc;

  /// No description provided for @added_doc.
  ///
  /// In en, this message translates to:
  /// **'This book has pdf document'**
  String get added_doc;

  /// No description provided for @book_id.
  ///
  /// In en, this message translates to:
  /// **'Book id'**
  String get book_id;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @new_book.
  ///
  /// In en, this message translates to:
  /// **'New book'**
  String get new_book;

  /// No description provided for @su_add_book.
  ///
  /// In en, this message translates to:
  /// **'Book is successfully added'**
  String get su_add_book;

  /// No description provided for @su_mod_book.
  ///
  /// In en, this message translates to:
  /// **'Book is successfully updated'**
  String get su_mod_book;

  /// No description provided for @no_genres.
  ///
  /// In en, this message translates to:
  /// **'No genres'**
  String get no_genres;

  /// No description provided for @chosen_doc.
  ///
  /// In en, this message translates to:
  /// **'Pdf document is chosen'**
  String get chosen_doc;

  /// No description provided for @su_ch_doc.
  ///
  /// In en, this message translates to:
  /// **'Pdf document is successfully chosen.'**
  String get su_ch_doc;

  /// No description provided for @doc_rule.
  ///
  /// In en, this message translates to:
  /// **'Only pdf files are allowed.'**
  String get doc_rule;

  /// No description provided for @logout_mess.
  ///
  /// In en, this message translates to:
  /// **'Do you want to log out from app?'**
  String get logout_mess;

  /// No description provided for @author_id.
  ///
  /// In en, this message translates to:
  /// **'Author id:'**
  String get author_id;

  /// No description provided for @new_author.
  ///
  /// In en, this message translates to:
  /// **'New author'**
  String get new_author;

  /// No description provided for @su_add_author.
  ///
  /// In en, this message translates to:
  /// **'Author is successfully added'**
  String get su_add_author;

  /// No description provided for @su_mod_author.
  ///
  /// In en, this message translates to:
  /// **'Author is successfully updated'**
  String get su_mod_author;

  /// No description provided for @su_del_author.
  ///
  /// In en, this message translates to:
  /// **'Author is successfully deleted'**
  String get su_del_author;

  /// No description provided for @del_author_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting author'**
  String get del_author_title;

  /// No description provided for @del_author_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this author?'**
  String get del_author_mes;

  /// No description provided for @author_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete author'**
  String get author_del_lbl;

  /// No description provided for @mortal_year.
  ///
  /// In en, this message translates to:
  /// **'Mortal year'**
  String get mortal_year;

  /// No description provided for @user_add_su.
  ///
  /// In en, this message translates to:
  /// **'User is successfully added'**
  String get user_add_su;

  /// No description provided for @user_mod_su.
  ///
  /// In en, this message translates to:
  /// **'User is successfully updated'**
  String get user_mod_su;

  /// No description provided for @user_del_su.
  ///
  /// In en, this message translates to:
  /// **'User is successfully deleted'**
  String get user_del_su;

  /// No description provided for @user_id.
  ///
  /// In en, this message translates to:
  /// **'User id:'**
  String get user_id;

  /// No description provided for @user_new.
  ///
  /// In en, this message translates to:
  /// **'New user'**
  String get user_new;

  /// No description provided for @user_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting user'**
  String get user_del_title;

  /// No description provided for @user_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this user?'**
  String get user_del_mes;

  /// No description provided for @user_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete user'**
  String get user_del_lbl;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get admin;

  /// No description provided for @user_lower.
  ///
  /// In en, this message translates to:
  /// **'user'**
  String get user_lower;

  /// No description provided for @admin_lower.
  ///
  /// In en, this message translates to:
  /// **'administrator'**
  String get admin_lower;

  /// No description provided for @new_lbl.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get new_lbl;

  /// No description provided for @name_2.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name_2;

  /// No description provided for @genre.
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get genre;

  /// No description provided for @genre_add_su.
  ///
  /// In en, this message translates to:
  /// **'Genre is successfully added'**
  String get genre_add_su;

  /// No description provided for @genre_mod_su.
  ///
  /// In en, this message translates to:
  /// **'Genre is successfully updated'**
  String get genre_mod_su;

  /// No description provided for @genre_del_su.
  ///
  /// In en, this message translates to:
  /// **'Genre is successfully deleted'**
  String get genre_del_su;

  /// No description provided for @genre_id.
  ///
  /// In en, this message translates to:
  /// **'Genre id:'**
  String get genre_id;

  /// No description provided for @genre_new.
  ///
  /// In en, this message translates to:
  /// **'New genre'**
  String get genre_new;

  /// No description provided for @genre_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting genre'**
  String get genre_del_title;

  /// No description provided for @genre_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this genre?'**
  String get genre_del_mes;

  /// No description provided for @genre_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete genre'**
  String get genre_del_lbl;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// No description provided for @quiz_add_su.
  ///
  /// In en, this message translates to:
  /// **'Quiz is successfully added'**
  String get quiz_add_su;

  /// No description provided for @quiz_mod_su.
  ///
  /// In en, this message translates to:
  /// **'Quiz is successfully updated'**
  String get quiz_mod_su;

  /// No description provided for @quiz_del_su.
  ///
  /// In en, this message translates to:
  /// **'Quiz is successfully deleted'**
  String get quiz_del_su;

  /// No description provided for @quiz_id.
  ///
  /// In en, this message translates to:
  /// **'Quiz id:'**
  String get quiz_id;

  /// No description provided for @quiz_new.
  ///
  /// In en, this message translates to:
  /// **'New quiz'**
  String get quiz_new;

  /// No description provided for @quiz_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting quiz'**
  String get quiz_del_title;

  /// No description provided for @quiz_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this quiz?'**
  String get quiz_del_mes;

  /// No description provided for @quiz_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete quiz'**
  String get quiz_del_lbl;

  /// No description provided for @quiz_questions.
  ///
  /// In en, this message translates to:
  /// **'Modify quiz questions'**
  String get quiz_questions;

  /// No description provided for @quiz_rule.
  ///
  /// In en, this message translates to:
  /// **'Remark: For a quiz  to be active it must have at least one question, and all questions must me active.'**
  String get quiz_rule;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @question_answers.
  ///
  /// In en, this message translates to:
  /// **'Modify question\'s answers'**
  String get question_answers;

  /// No description provided for @quiestion_rule.
  ///
  /// In en, this message translates to:
  /// **'Remark: For a question to be active it must have one\nand only one true answer and one or more false answers.'**
  String get quiestion_rule;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @questions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get questions;

  /// No description provided for @question_add_su.
  ///
  /// In en, this message translates to:
  /// **'Question is successfully added'**
  String get question_add_su;

  /// No description provided for @question_mod_su.
  ///
  /// In en, this message translates to:
  /// **'Question is successfully updated'**
  String get question_mod_su;

  /// No description provided for @question_del_su.
  ///
  /// In en, this message translates to:
  /// **'Question is successfully deleted'**
  String get question_del_su;

  /// No description provided for @question_id.
  ///
  /// In en, this message translates to:
  /// **'Question id:'**
  String get question_id;

  /// No description provided for @question_new.
  ///
  /// In en, this message translates to:
  /// **'New question'**
  String get question_new;

  /// No description provided for @question_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting question'**
  String get question_del_title;

  /// No description provided for @question_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this question?'**
  String get question_del_mes;

  /// No description provided for @question_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete question'**
  String get question_del_lbl;

  /// No description provided for @numeric_field.
  ///
  /// In en, this message translates to:
  /// **'Value must be numeric'**
  String get numeric_field;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @true_val.
  ///
  /// In en, this message translates to:
  /// **'True'**
  String get true_val;

  /// No description provided for @false_val.
  ///
  /// In en, this message translates to:
  /// **'False'**
  String get false_val;

  /// No description provided for @is_true.
  ///
  /// In en, this message translates to:
  /// **'Is true'**
  String get is_true;

  /// No description provided for @answers.
  ///
  /// In en, this message translates to:
  /// **'Answers'**
  String get answers;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @answer_add_su.
  ///
  /// In en, this message translates to:
  /// **'Answer is successfully added'**
  String get answer_add_su;

  /// No description provided for @answer_mod_su.
  ///
  /// In en, this message translates to:
  /// **'Answer is successfully updated'**
  String get answer_mod_su;

  /// No description provided for @answer_del_su.
  ///
  /// In en, this message translates to:
  /// **'Answer is successfully deleted'**
  String get answer_del_su;

  /// No description provided for @answer_id.
  ///
  /// In en, this message translates to:
  /// **'Answer id:'**
  String get answer_id;

  /// No description provided for @answer_new.
  ///
  /// In en, this message translates to:
  /// **'New answer'**
  String get answer_new;

  /// No description provided for @answer_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting answer'**
  String get answer_del_title;

  /// No description provided for @answer_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this answer?'**
  String get answer_del_mes;

  /// No description provided for @answer_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete answer'**
  String get answer_del_lbl;

  /// No description provided for @quotes.
  ///
  /// In en, this message translates to:
  /// **'Quotes'**
  String get quotes;

  /// No description provided for @quote.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get quote;

  /// No description provided for @quote_add_su.
  ///
  /// In en, this message translates to:
  /// **'Quote is successfully added'**
  String get quote_add_su;

  /// No description provided for @quote_mod_su.
  ///
  /// In en, this message translates to:
  /// **'Quote is successfully updated'**
  String get quote_mod_su;

  /// No description provided for @quote_del_su.
  ///
  /// In en, this message translates to:
  /// **'Quote is successfully deleted'**
  String get quote_del_su;

  /// No description provided for @quote_id.
  ///
  /// In en, this message translates to:
  /// **'Quote id:'**
  String get quote_id;

  /// No description provided for @quote_new.
  ///
  /// In en, this message translates to:
  /// **'New quote'**
  String get quote_new;

  /// No description provided for @quote_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting quote'**
  String get quote_del_title;

  /// No description provided for @quote_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this quote?'**
  String get quote_del_mes;

  /// No description provided for @quote_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete quote'**
  String get quote_del_lbl;

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get user_name;

  /// No description provided for @rates.
  ///
  /// In en, this message translates to:
  /// **'Book ratings'**
  String get rates;

  /// No description provided for @rate_del_su.
  ///
  /// In en, this message translates to:
  /// **'Rating is successfully deleted'**
  String get rate_del_su;

  /// No description provided for @rate_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting rating'**
  String get rate_del_title;

  /// No description provided for @rate_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this rating?'**
  String get rate_del_mes;

  /// No description provided for @no_rates.
  ///
  /// In en, this message translates to:
  /// **'No ratings for this book'**
  String get no_rates;

  /// No description provided for @bookgenre_title.
  ///
  /// In en, this message translates to:
  /// **'Genres od book'**
  String get bookgenre_title;

  /// No description provided for @bookgenre_insert.
  ///
  /// In en, this message translates to:
  /// **'Adding book\'s genres'**
  String get bookgenre_insert;

  /// No description provided for @bookgenre.
  ///
  /// In en, this message translates to:
  /// **'Book\'s genre'**
  String get bookgenre;

  /// No description provided for @bookgenre_add_su.
  ///
  /// In en, this message translates to:
  /// **'Book\'s genre is successfully added'**
  String get bookgenre_add_su;

  /// No description provided for @bookgenre_mod_su.
  ///
  /// In en, this message translates to:
  /// **'Book\'s genre is successfully updated'**
  String get bookgenre_mod_su;

  /// No description provided for @bookgenre_del_su.
  ///
  /// In en, this message translates to:
  /// **'Book\'s genre is deleted'**
  String get bookgenre_del_su;

  /// No description provided for @bookgenre_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting book\'s genre'**
  String get bookgenre_del_title;

  /// No description provided for @bookgenre_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this book\'s genre?'**
  String get bookgenre_del_mes;

  /// No description provided for @bookgenre_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete book\'s genre'**
  String get bookgenre_del_lbl;

  /// No description provided for @su_trained.
  ///
  /// In en, this message translates to:
  /// **'Recommednation is successfully trained.'**
  String get su_trained;

  /// No description provided for @forbid_users.
  ///
  /// In en, this message translates to:
  /// **'Customers are not allowd to use desktop application'**
  String get forbid_users;

  /// No description provided for @cur_email.
  ///
  /// In en, this message translates to:
  /// **'Current email'**
  String get cur_email;

  /// No description provided for @new_email.
  ///
  /// In en, this message translates to:
  /// **'New email'**
  String get new_email;

  /// No description provided for @changing_email.
  ///
  /// In en, this message translates to:
  /// **'Changing email'**
  String get changing_email;

  /// No description provided for @su_cha_email.
  ///
  /// In en, this message translates to:
  /// **'Email is successfully changed'**
  String get su_cha_email;

  /// No description provided for @su_mod_password.
  ///
  /// In en, this message translates to:
  /// **'Password is successfully changed'**
  String get su_mod_password;

  /// No description provided for @pass_no_matc.
  ///
  /// In en, this message translates to:
  /// **'New password and confirm password don\'t match.'**
  String get pass_no_matc;

  /// No description provided for @pass_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get pass_confirm;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get new_password;

  /// No description provided for @changign_password.
  ///
  /// In en, this message translates to:
  /// **'Changing password'**
  String get changign_password;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @overall.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get overall;

  /// No description provided for @one_star.
  ///
  /// In en, this message translates to:
  /// **'One star'**
  String get one_star;

  /// No description provided for @five_stars.
  ///
  /// In en, this message translates to:
  /// **'Five stars'**
  String get five_stars;

  /// No description provided for @active_m.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active_m;

  /// No description provided for @inactive_m.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive_m;
   String get cancel_payment;

    /// No description provided for @su_payed.
  ///
  /// In en, this message translates to:
  /// **'Membership is successsfully purchased.\n Your membership last for a year.'**
String get purchase;
  String get su_payed;
   String get payment;

  /// No description provided for @active_n.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active_n;

  /// No description provided for @inactive_n.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive_n;

  /// No description provided for @trues.
  ///
  /// In en, this message translates to:
  /// **'True'**
  String get trues;

  /// No description provided for @falses.
  ///
  /// In en, this message translates to:
  /// **'False'**
  String get falses;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @is_read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get is_read;

  /// No description provided for @is_unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get is_unread;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @notif_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting notification'**
  String get notif_del_title;

  /// No description provided for @notif_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this notification'**
  String get notif_del_mes;

  /// No description provided for @notif_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete notification'**
  String get notif_del_lbl;

  /// No description provided for @notif_del_su.
  ///
  /// In en, this message translates to:
  /// **'Notification is successfully deleted'**
  String get notif_del_su;

  /// No description provided for @book_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting book'**
  String get book_del_title;

  /// No description provided for @book_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this book?'**
  String get book_del_mes;

  /// No description provided for @book_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete book'**
  String get book_del_lbl;

  /// No description provided for @book_su_del.
  ///
  /// In en, this message translates to:
  /// **'Book is successfully deleted'**
  String get book_su_del;

  /// No description provided for @recommend_su_del.
  ///
  /// In en, this message translates to:
  /// **'Recommednation is successfully deleted'**
  String get recommend_su_del;

  /// No description provided for @recommend_del_mes.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete recommendation?'**
  String get recommend_del_mes;

  /// No description provided for @recommend_del_lbl.
  ///
  /// In en, this message translates to:
  /// **'Delete recommendation'**
  String get recommend_del_lbl;

  /// No description provided for @recommend_del_title.
  ///
  /// In en, this message translates to:
  /// **'Deleting recommendation'**
  String get recommend_del_title;

  /// No description provided for @notif_id.
  ///
  /// In en, this message translates to:
  /// **'Notification Id: '**
  String get notif_id;

  /// No description provided for @dec_account.
  ///
  /// In en, this message translates to:
  /// **'You cann\'t log in because your account is deactivated'**
  String get dec_account;

  /// No description provided for @invalid_points.
  ///
  /// In en, this message translates to:
  /// **'Points must be between 1 and 10'**
  String get invalid_points;

  /// No description provided for @birth_date.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birth_date;

  /// No description provided for @no_book_genres.
  ///
  /// In en, this message translates to:
  /// **'There are no added genres for this book'**
  String get no_book_genres;

  /// No description provided for @no_quotes.
  ///
  /// In en, this message translates to:
  /// **'No quotes for this book'**
  String get no_quotes;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['bs', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bs': return AppLocalizationsBs();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
