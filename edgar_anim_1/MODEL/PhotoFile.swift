//
//  PhotoFile.swift
//  edgar_anim_1
//
//  Created by Ludovic Jardiné on 26/01/2021.
//

import Photos
import UIKit


struct Assets {
    
    
    // TO GET ASSETS FROM LOCAL IDENTIFIER
    func getAssetsFromURL(_ localID: [String]) -> PHFetchResult<PHAsset> {
        return PHAsset.fetchAssets(withLocalIdentifiers: localID, options: .none)
    }
    
    
    // TO CONVERT PHASSET TO UIIMAGE
    func convertFromAssetToImage(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var image = UIImage()
        option.isSynchronous = true
        manager.requestImage(
            for: asset,
            targetSize: PHImageManagerMaximumSize,
            contentMode: .aspectFit,
            options: option,
            resultHandler: {(result, _) -> Void in
                image = result!
            })
        return image
    }
    
}
