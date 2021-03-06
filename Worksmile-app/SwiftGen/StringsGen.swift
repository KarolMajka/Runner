// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// Not found
  internal static let locErrorNotFound = L10n.tr("Localizable", "loc_error_not_found")
  /// Show/Hide anomalies
  internal static let locPathAnomalyButtonTitle = L10n.tr("Localizable", "loc_path_anomaly_button_title")
  /// THE POINT HAS BEEN CLASSIFIED AS INVALID.
  internal static let locPathAnomalyInfo = L10n.tr("Localizable", "loc_path_anomaly_info")
  /// Coordinates
  internal static let locPathCoordinateTitle = L10n.tr("Localizable", "loc_path_coordinate_title")
  /// Distance
  internal static let locPathDistanceTitle = L10n.tr("Localizable", "loc_path_distance_title")
  /// Your path
  internal static let locPathTitle = L10n.tr("Localizable", "loc_path_title")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
