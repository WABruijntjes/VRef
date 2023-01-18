import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let user: User
}
