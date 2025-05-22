/// The [EnrollForcedDocumentType] enum represents the different modes in which the eNROLL plugin can operate.
///
/// It defines whether the plugin is being used for onboarding a new user or for authentication.
enum EnrollForcedDocumentType {
  /// The nationalIdOnly mode, used when force the system to open national id only.
  nationalIdOnly,

  /// The passportOnly mode, used when force the system to open passport only.
  passportOnly,

  /// The nationalIdOrPassport mode, used when make the user choose between national id or passport.
  nationalIdOrPassport
}
