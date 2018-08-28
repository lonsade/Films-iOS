// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {
  /// 18+
  internal static let adult = L10n.tr("Localizable", "adult")
  /// 7e768e8012161bc9c4ca59f1e4f5979e
  internal static let apiKey = L10n.tr("Localizable", "api_key")
  /// https://api.themoviedb.org/3
  internal static let baseURL = L10n.tr("Localizable", "base_URL")
  /// https://image.tmdb.org/t/p/w500
  internal static let baseURLForImages = L10n.tr("Localizable", "base_URL_for_images")
  /// TMDb
  internal static let markSystem = L10n.tr("Localizable", "mark_system")
  /// 0+
  internal static let notAdult = L10n.tr("Localizable", "not_adult")
  /// Not information
  internal static let notInformation = L10n.tr("Localizable", "not_information")

  internal enum AboutArtist {
    /// Artist
    internal static let navigationTitle = L10n.tr("Localizable", "about_artist.navigation_title")
    /// bio
    internal static let page1 = L10n.tr("Localizable", "about_artist.page1")
    /// films
    internal static let page2 = L10n.tr("Localizable", "about_artist.page2")
    /// artist
    internal static let storybordName = L10n.tr("Localizable", "about_artist.storybord_name")
  }

  internal enum AboutFilm {
    /// Film
    internal static let navigationTitle = L10n.tr("Localizable", "about_film.navigation_title")
    /// page0
    internal static let page1 = L10n.tr("Localizable", "about_film.page1")
    /// page1
    internal static let page2 = L10n.tr("Localizable", "about_film.page2")
    /// page2
    internal static let page3 = L10n.tr("Localizable", "about_film.page3")
    /// film
    internal static let storybordName = L10n.tr("Localizable", "about_film.storybord_name")

    internal enum Info {
      /// Gallery
      internal static let galleryLabel = L10n.tr("Localizable", "about_film.info.gallery_label")
      /// See also
      internal static let seeAlsoLabel = L10n.tr("Localizable", "about_film.info.see_also_label")
    }
  }

  internal enum AboutTv {
    /// TV Show
    internal static let navigationTitle = L10n.tr("Localizable", "about_tv.navigation_title")
  }

  internal enum Menu {
    /// FAVORITES
    internal static let favorites = L10n.tr("Localizable", "menu.favorites")
    /// HOME
    internal static let home = L10n.tr("Localizable", "menu.home")
    /// MOVIES
    internal static let movies = L10n.tr("Localizable", "menu.movies")
    /// TV SHOWS
    internal static let tvShow = L10n.tr("Localizable", "menu.tv_show")
  }

  internal enum Module {
    /// AboutArtist
    internal static let aboutArtist = L10n.tr("Localizable", "module.about_artist")
    /// AboutArtistFilm
    internal static let aboutArtistFilm = L10n.tr("Localizable", "module.about_artist_film")
    /// AboutFilm
    internal static let aboutFilm = L10n.tr("Localizable", "module.about_film")
    /// Movies
    internal static let movies = L10n.tr("Localizable", "module.movies")
    /// search
    internal static let search = L10n.tr("Localizable", "module.search")
  }

  internal enum Movies {
    /// Films iOS
    internal static let navigationTitle = L10n.tr("Localizable", "movies.navigation_title")
    /// MainViewController
    internal static let storybordName = L10n.tr("Localizable", "movies.storybord_name")

    internal enum Tabs {
      /// In cinema
      internal static let inCinema = L10n.tr("Localizable", "movies.tabs.in_cinema")
      /// Popular
      internal static let popular = L10n.tr("Localizable", "movies.tabs.popular")
    }
  }

  internal enum Tv {
    /// TV iOS
    internal static let navigationTitle = L10n.tr("Localizable", "tv.navigation_title")

    internal enum Tabs {
      /// On the air
      internal static let onTheAir = L10n.tr("Localizable", "tv.tabs.on_the_air")
    }
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
