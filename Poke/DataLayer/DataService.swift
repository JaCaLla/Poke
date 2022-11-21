//
//  DataService.swift
//  Poke
//
//  Created by Javier Calatrava on 18/11/22.
//

import Foundation

protocol DataServiceProtocol {
    func fetch(completion: @escaping (Result<ResultContainerAPI, Error>) -> Void)
    func fetch() async -> Result<ResultContainerAPI, Error>
    func fetch(link: String, completion: @escaping (Result<PokemonAPI, Error>) -> Void)
    func fetch(link: String) async -> Result<PokemonAPI, Error> 
}

final class DataService: DataServiceProtocol {
    
    func fetch(completion: @escaping (Result<ResultContainerAPI, Error>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let resultContainer = try JSONDecoder().decode(ResultContainerAPI.self, from: data!)
                completion(.success(resultContainer))
            } catch {
                completion(.failure(error))
                print("error: ", error)
            }
        }.resume()
    }
    
    func fetch() async -> Result<ResultContainerAPI, Error> {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon")!
        do {
            let (data, response) = await try URLSession.shared.data(from: url)
            let resultContainer = try JSONDecoder().decode(ResultContainerAPI.self, from: data)
            return .success(resultContainer)
        } catch {
            return .failure(error)
            print("error: ", error)
        }
    }
    
    func fetch(link: String, completion: @escaping (Result<PokemonAPI, Error>) -> Void) {
        let url = URL(string:link)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let resultContainer = try JSONDecoder().decode(PokemonAPI.self, from: data!)
                completion(.success(resultContainer))
            } catch {
                completion(.failure(error))
                print("error: ", error)
            }
        }.resume()
    }
    
    func fetch(link: String) async -> Result<PokemonAPI, Error> {
        let url = URL(string: link)!
        do {
            let (data, response) = try await  URLSession.shared.data(from: url)
            let pokemonAPI = try JSONDecoder().decode(PokemonAPI.self, from: data)
            return .success(pokemonAPI)
        } catch {
            return .failure(error)
            print("error: ", error)
        }
       
    }
}


