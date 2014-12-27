//
//  FilterViewController.swift
//  ExChangAGram
//
//  Created by BenLacroix on 25/12/2014.
//  Copyright (c) 2014 Benobab. All rights reserved.
//
import CoreData
import UIKit

class FiltreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var thisFeedItem:FeedItem! //permet de récupérer l'Item selectionné dans le premier FeedViewController
    
    var mainVC:FeedViewController!
    @IBOutlet var collectionView: UICollectionView!

    let placeHolderImage = UIImage(named: "Placeholder")

    let kIntensity = 0.7
    
    var context = CIContext(options: nil)
    
    var filters:[CIFilter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding the collection view in code
        filters = photoFilters()
        //The resposible for determinng the ways the elements are organised inside the collection
        
        
        // filterView
        //add the colelction view to the VC's view
        //self.view.addSubview(self.collectionView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:FilterCell = collectionView.dequeueReusableCellWithReuseIdentifier("FiltreCell", forIndexPath: indexPath) as FilterCell
        //ici on commence par placeholder (rapide, et ensuite ça charge les autres en arriere plan)
        //Et on optimise en regardant à la remplir seulement si elle est vide, et on a déjà loader placeHolder en constante tout en haut du VC
        if(cell.imageView.image == nil){
         cell.imageView.image = placeHolderImage
            
            //Multithreading enfin backgroundthread
            let filterQueue:dispatch_queue_t = dispatch_queue_create("Filtre Queue", nil)
            
            dispatch_async(filterQueue, { () -> Void in
                //TODO
                let filteredImage = self.filteredImageFromImage(self.thisFeedItem.thumbNail, filter: self.filters[indexPath.row])
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    cell.imageView.image = filteredImage
                })
            })
        }
        
        
        
        return cell
    }
    
    
    //Fonction pour renvoyer un tableau de filtre, qui seront ensuite display dans le viewController
    func photoFilters () -> [CIFilter] {
        let blur = CIFilter(name: "CIGaussianBlur")
        
        let instant = CIFilter(name: "CIPhotoEffectInstant")
        
        let noir = CIFilter(name: "CIPhotoEffectNoir")
        
        let transfer = CIFilter(name: "CIPhotoEffectTransfer")
        
        let unsharpen = CIFilter(name: "CIUnsharpMask")
        
        let monochrome = CIFilter(name: "CIColorMonochrome")
        
        let sepia = CIFilter(name:"CISepiaTone")
        sepia.setValue(self.kIntensity, forKey:kCIInputIntensityKey)
        
        let colorControls = CIFilter(name:"CIColorControls")
        colorControls.setValue(0.5, forKey: kCIInputSaturationKey)
        
        let colorClamp = CIFilter(name: "CIColorClamp")
        colorClamp.setValue(CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9), forKey: "inputMaxComponents")
        colorClamp.setValue(CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0.2), forKey: "inputMinComponents")
        
        let composite = CIFilter(name: "CIHardLightBlendMode")
        composite.setValue(sepia.outputImage, forKey: kCIInputImageKey)
        
        let vignette = CIFilter(name: "CIVignette")
        vignette.setValue(composite.outputImage, forKey: kCIInputImageKey)
        
        vignette.setValue(kIntensity * 2, forKey: kCIInputIntensityKey)
        vignette.setValue(kIntensity * 30, forKey: kCIInputRadiusKey)
        
        return [blur, instant, noir, transfer, unsharpen, monochrome, sepia, colorControls, colorClamp, composite, vignette]
    }
    
    //fontionc qui renvoit la photo avec le filtre par rapport à l'originale
    func filteredImageFromImage (imageData: NSData, filter: CIFilter) -> UIImage {
        
        let unfilteredImage = CIImage(data: imageData)
        filter.setValue(unfilteredImage, forKey: kCIInputImageKey)
        let filteredImage:CIImage = filter.outputImage
        
        let extent = filteredImage.extent()
        let cgImage:CGImageRef = context.createCGImage(filteredImage, fromRect: extent)
        
        let finalImage = UIImage(CGImage: cgImage)
        //let finalImage = UIImage(CIImage: filteredImage)
        return finalImage!
    }
    
    //on retourne à l'ancienne View
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        
        //ToDo
        //Changer le feedArray du premier View Controller puis popView pour revenir
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //On change de vu et on update l'image
        let cell:FilterCell = collectionView.dequeueReusableCellWithReuseIdentifier("FiltreCell", forIndexPath: indexPath) as FilterCell
        var filteredItem: FeedItem = FeedItem()
        filteredItem.image =  UIImageJPEGRepresentation(cell.imageView.image, 1.0)
        
        mainVC.feedArray[0] = filteredItem
        self.navigationController?.popViewControllerAnimated(true)
    }
}
