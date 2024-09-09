/// The [EnrollEnvironment] enum represents the possible environments
/// where the eNROLL plugin can operate.
///
/// This can be used to specify whether the plugin is running in a staging
/// or production environment.
enum EnrollEnvironment {
  /// The staging environment, typically used for testing purposes.
  staging,

  /// The production environment, where the live system operates.
  production
}
