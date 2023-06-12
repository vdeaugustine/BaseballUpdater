//
//  PlayerImage.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/14/23.
//

import SwiftUI

struct PlayerImage: View {
    let url: URL
        
        var body: some View {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "exclamationmark.icloud.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }
        }
}

struct PlayerImage_Previews: PreviewProvider {
    static var previews: some View {
        PlayerImage(url: URL(string: Links.playerImage(id: 545361))!)
    }
}
