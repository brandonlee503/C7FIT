import Foundation

enum AppError: Error {
    case network(errorString: String?)
    case audioPlayback(errorString: String?)
}
