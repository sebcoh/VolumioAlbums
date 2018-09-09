//
//  VolumioClient.swift
//  VolumioAlbums
//
//  Created by Sebastian Cohausz on 24.07.18.
//  Copyright © 2018 scgmbh. All rights reserved.
//

import Foundation
import SocketIO
import RxSwift

enum PlaybackState: String {
    case paused = "pause"
    case playing = "play"
    case stopped
}

class VolumioClient {
    
    let manager: SocketManager
    
    let bag = DisposeBag()
    
    let playBackState = PublishSubject<PlaybackState>()
    
    
  
//    let artists = PublishSubject<Artist>()
//    let genres = PublishSubject<[Genre]>()
//    let subjects: [Type: PublishSubject] = [Album.self: , Artist.self: , Genre.self: ]
    
    let connected = Variable<Bool>(false)
    
    var baseURL: URL {
        get {
            return manager.socketURL
        }
    }
    
    init(url: URL = URL(string: "http://raspi:3000")!) {
        manager = SocketManager(socketURL: url)
        manager.defaultSocket.on(clientEvent: .connect, callback: { (data, ack) in
            print("--- onConnect ---")
            self.connected.value = true
            //self.manager?.defaultSocket.emit("getState", with: [])
            //self.manager?.defaultSocket.emit("search", with: [["value": "who"]])
            //self.manager.defaultSocket.emit("browseLibrary", with: [["uri": "albums://"]])
            //self.manager.defaultSocket.emit("browseLibrary", with: [["uri": "genres://"]])
            self.manager.defaultSocket.emit("browseLibrary", with: [["uri": "albums://The%20Shins/Oh%2C%20Inverted%20World"]])
//            self.manager.defaultSocket.emit("getBrowseSources", with: [])
            
            //self.manager.defaultSocket.emit("getBrowseSources", with: [])
            //play(on: self.manager!.defaultSocket)
        })
        manager.defaultSocket.on(clientEvent: .disconnect, callback: { (data, ack) in
            print("--- onDisconnect ---")
            self.connected.value = false
        })
        manager.defaultSocket.onAny({ event in
            print("\(event)")
        })
        
//        manager.defaultSocket.on("pushState") { data, ack in
//            print("--- pushstate ---")
//            if let data = data as? [NSDictionary] {
//                print(data[0]["status"]!)
//                self.playBackState.onNext(PlaybackState.init(rawValue: data[0]["status"] as! String) ?? .paused)
//            }
//        }
//        manager.defaultSocket.on("pushBrowseLibrary") { (data, ack) in
//
//
//            let albums: [Genre] = ParseHelper.decodeItems(input: data)
//
//
//            /*let albums = items.compactMap({ (item) -> Album? in
//                return Album(sourceDict: item)
//            })*/
//
//            //self.albumsSubject.onNext(albums)
//        }
        registerConnected()
        
        manager.connect()
    }
    
    func registerConnected() {
        manager.defaultSocket.on("statusChange") { (anyArray, _) in
            guard let connectionStatus = anyArray[0] as? String else { return }
            if connectionStatus == "connected" {
                self.connected.value = true
            } else if connectionStatus == "disconnected" {
                self.connected.value = false
            }
        }
    }

    
    func fetchCategoryItems<T: Category>() -> Observable<[T]> {
        let subject = PublishSubject<[T]>()
        self.connected.asObservable().filter { connected -> Bool in
            connected
            }.subscribe(onNext: {[weak self] _ in
                self?.manager.defaultSocket.emit("browseLibrary", with: [["uri": T.categoryType.request]])
                self?.manager.defaultSocket.once("pushBrowseLibrary") {(data, _) in
                    let items: [T] = ParseHelper.decodeItems(input: data)
                    subject.onNext(items)
                    subject.onCompleted()
                }
            }).disposed(by: bag)
        return subject.asObservable()
    }
    
    func clearQueue(callback: @escaping (() -> ())) {
        manager.defaultSocket.emit("clearQueue")
        manager.defaultSocket.once("pushQueue") { (any, ack) in
            callback()
        }
    }
    
    func enqueue(album: Album) {
        clearQueue {
            let dict = ["uri": /*self.manager.socketURL.absoluteString +*/ album.uri]
            self.manager.defaultSocket.emit("addToQueue", with: [dict])
            self.manager.defaultSocket.once("pushQueue", callback: { _,_  in
                self.play(on: self.manager.defaultSocket)
            })
        }
    }
    
    func play(on client: SocketIOClient) {
        client.emit("play", with: [])
    }
}
