// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `This list is password protected`
  String get thisListIsPasswordProtected {
    return Intl.message(
      'This list is password protected',
      name: 'thisListIsPasswordProtected',
      desc: '',
      args: [],
    );
  }

  /// `Open settigns`
  String get openSettigns {
    return Intl.message(
      'Open settigns',
      name: 'openSettigns',
      desc: '',
      args: [],
    );
  }

  /// `Create new list`
  String get createNewList {
    return Intl.message(
      'Create new list',
      name: 'createNewList',
      desc: '',
      args: [],
    );
  }

  /// `Search lists...`
  String get searchLists {
    return Intl.message(
      'Search lists...',
      name: 'searchLists',
      desc: '',
      args: [],
    );
  }

  /// `Select theme`
  String get selectTheme {
    return Intl.message(
      'Select theme',
      name: 'selectTheme',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Error reading system accent color!`
  String get errorReadingSystemAccentColor {
    return Intl.message(
      'Error reading system accent color!',
      name: 'errorReadingSystemAccentColor',
      desc: '',
      args: [],
    );
  }

  /// `There was an error while reading the accent color you have set for your System. Lists will continue to try reading the system accent color and will use default accent color while trying.`
  String get errorReadingSystemAccentColorDescription {
    return Intl.message(
      'There was an error while reading the accent color you have set for your System. Lists will continue to try reading the system accent color and will use default accent color while trying.',
      name: 'errorReadingSystemAccentColorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Show details`
  String get showDetails {
    return Intl.message(
      'Show details',
      name: 'showDetails',
      desc: '',
      args: [],
    );
  }

  /// `Adaptive accent (unstable)`
  String get adaptiveAccentUnstable {
    return Intl.message(
      'Adaptive accent (unstable)',
      name: 'adaptiveAccentUnstable',
      desc: '',
      args: [],
    );
  }

  /// `Adaptive accent is only available when using system theme`
  String get adaptiveAccentIsOnlyAvailableWhenUsingSystemTheme {
    return Intl.message(
      'Adaptive accent is only available when using system theme',
      name: 'adaptiveAccentIsOnlyAvailableWhenUsingSystemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Error checking for updates`
  String get errorCheckingForUpdates {
    return Intl.message(
      'Error checking for updates',
      name: 'errorCheckingForUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again later.`
  String get errorCheckingForUpdatesDescription {
    return Intl.message(
      'Please check your internet connection and try again later.',
      name: 'errorCheckingForUpdatesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Update available`
  String get updateAvailable {
    return Intl.message(
      'Update available',
      name: 'updateAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get updateAvailableUpdate {
    return Intl.message(
      'Update',
      name: 'updateAvailableUpdate',
      desc: '',
      args: [],
    );
  }

  /// `You are on the latest version!`
  String get youAreOnTheLatestVersion {
    return Intl.message(
      'You are on the latest version!',
      name: 'youAreOnTheLatestVersion',
      desc: '',
      args: [],
    );
  }

  /// `Checking for updates...`
  String get checkingForUpdates {
    return Intl.message(
      'Checking for updates...',
      name: 'checkingForUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Sync is not implemented yet`
  String get syncIsNotImplementedYet {
    return Intl.message(
      'Sync is not implemented yet',
      name: 'syncIsNotImplementedYet',
      desc: '',
      args: [],
    );
  }

  /// `Sync`
  String get sync {
    return Intl.message(
      'Sync',
      name: 'sync',
      desc: '',
      args: [],
    );
  }

  /// `Sync enables you to sync your lists across other devices.`
  String get syncDescription {
    return Intl.message(
      'Sync enables you to sync your lists across other devices.',
      name: 'syncDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enable sync`
  String get enableSync {
    return Intl.message(
      'Enable sync',
      name: 'enableSync',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get off {
    return Intl.message(
      'Off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Check for updates`
  String get checkForUpdates {
    return Intl.message(
      'Check for updates',
      name: 'checkForUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Importing is not implemented yet`
  String get importingIsNotImplementedYet {
    return Intl.message(
      'Importing is not implemented yet',
      name: 'importingIsNotImplementedYet',
      desc: '',
      args: [],
    );
  }

  /// `Import lists from older versions`
  String get importListsFromOlderVersions {
    return Intl.message(
      'Import lists from older versions',
      name: 'importListsFromOlderVersions',
      desc: '',
      args: [],
    );
  }

  /// `Import list from file`
  String get importListFromFile {
    return Intl.message(
      'Import list from file',
      name: 'importListFromFile',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message(
      'Import',
      name: 'import',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
