//
//  MainView.swift
//  Remarco
//
//  Created by Nikolay Khort on 04.01.2024.
//

import SwiftUI

struct MainView: View {
    @State private var selectedPeer: Peer?

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Clients")) {
                    ForEach(peers.filter { $0.category == .clients }) { peer in
                        NavigationLink(destination: PeerCardView(peer: peer)) {
                            Text(peer.name)
                                .onTapGesture {
                                    selectedPeer = peer
                                }
                        }
                    }
                }

                Section(header: Text("Wallets")) {
                    ForEach(peers.filter { $0.category == .wallets }) { peer in
                        NavigationLink(destination: PeerCardView(peer: peer)) {
                            Text(peer.name)
                                .onTapGesture {
                                    selectedPeer = peer
                                }
                        }
                    }
                }

                // Add similar sections for other categories
            }
            .listStyle(SidebarListStyle())
            

            if let selectedPeer = selectedPeer {
                PeerCardView(peer: selectedPeer)
                    .frame(minWidth: 500, idealWidth: 600, maxWidth: .infinity, minHeight: 500, idealHeight: 600, maxHeight: .infinity)
            } else {
                Text("Select a peer from the list")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("Peers")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct Peer: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var nickname: String?
    var contactName: String
    var email: String
    var telegramLink: String?
    var category: PeerCategory
    // ... other properties

    enum PeerCategory {
        case clients
        case wallets
        // ... add other categories as needed
    }
}

let peers: [Peer] = [
    Peer(name: "Client A", nickname: "NicknameA", contactName: "ContactA", email: "clientA@example.com", telegramLink: "@clientA", category: .clients),
    Peer(name: "Client B", nickname: "NicknameB", contactName: "ContactB", email: "clientB@example.com", telegramLink: "@clientB", category: .clients),
    Peer(name: "Wallet X", nickname: "NicknameX", contactName: "ContactX", email: "walletX@example.com", telegramLink: "@walletX", category: .wallets),
    Peer(name: "Wallet Y", nickname: "NicknameY", contactName: "ContactY", email: "walletY@example.com", telegramLink: "@walletY", category: .wallets),
    // ... add more peers with different categories
]
