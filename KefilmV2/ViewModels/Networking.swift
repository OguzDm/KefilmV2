////
////  Networking.swift
////  KefilmV2
////
////  Created by Oğuz Demirhan on 30.12.2021.
////
//
//import Foundation
//
//public typealias HTTPHeaders = [String:String]
//
//protocol AsyncGenericAPI {
//    var session: URLSession { get }
//    func fetch<T: Decodable>(
//        type: T.Type,
//        with request: URLRequest) async throws -> T
//}
//
//extension AsyncGenericAPI {
//
//    func fetch<T: Decodable>(
//        type: T.Type,
//        with request: URLRequest) async throws -> T { // 1
//      
//        // 2
//        let (data, response) = try await session.data(for: request)
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw KefilmError.responseError
//        }
//        guard httpResponse.statusCode == 200 else {
//            throw KefilmError.serverError(description: "status code \(httpResponse.statusCode)")
//        }
//        do {
//            let decoder = JSONDecoder()
//            // 3
//            return try decoder.decode(type, from: data)
//        } catch {
//            // 4
//            throw KefilmError.decodingError
//        }
//    }
//}
//
//class Networking {
//    static let shared = Networking()
//}
