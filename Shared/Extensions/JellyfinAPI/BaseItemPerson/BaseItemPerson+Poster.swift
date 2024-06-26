//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2024 Jellyfin & Jellyfin Contributors
//

import Factory
import Foundation
import JellyfinAPI
import UIKit

extension BaseItemPerson: Poster {

    var subtitle: String? {
        firstRole
    }

    var systemImage: String {
        "person.fill"
    }

    func portraitImageSources(maxWidth: CGFloat? = nil) -> [ImageSource] {

        // TODO: figure out what to do about screen scaling with .main being deprecated
        //       - maxWidth assume already scaled?
        let scaleWidth: Int? = maxWidth == nil ? nil : UIScreen.main.scale(maxWidth!)

        let client = Container.userSession().client
        let imageRequestParameters = Paths.GetItemImageParameters(
            maxWidth: scaleWidth ?? Int(maxWidth),
            tag: primaryImageTag
        )

        let imageRequest = Paths.getItemImage(
            itemID: id ?? "",
            imageType: ImageType.primary.rawValue,
            parameters: imageRequestParameters
        )

        let url = client.fullURL(with: imageRequest)
        let blurHash: String? = imageBlurHashes?.primary?[primaryImageTag]

        return [ImageSource(
            url: url,
            blurHash: blurHash
        )]
    }
}
