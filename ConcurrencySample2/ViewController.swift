//
//  ViewController.swift
//  ConcurrencySample2
//
//  Created by Eduardo on 2/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

let imageURL01 = "https://image.tmdb.org/t/p/original/cezWGskPY5x7GaglTTRN4Fugfb8.jpg"
let imageURL02 = "https://image.tmdb.org/t/p/original/t90Y3G8UGQp0f0DrP60wRu9gfrH.jpg"
let imageURL03 = "https://image.tmdb.org/t/p/original/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg"
let imageURL04 = "https://image.tmdb.org/t/p/original/uxzzxijgPIY7slzFvMotPv8wjKA.jpg"
let imageURL05 = "https://image.tmdb.org/t/p/original/rv1AWImgx386ULjcf62VYaW8zSt.jpg"
let imageURL06 = "https://image.tmdb.org/t/p/original/uB1k7XsHvjjJXSAwur37wttrzpJ.jpg"



class ViewController: UIViewController {

    @IBOutlet weak var image01: UIImageView!
    @IBOutlet weak var image02: UIImageView!
    @IBOutlet weak var image03: UIImageView!
    @IBOutlet weak var image04: UIImageView!
    @IBOutlet weak var image05: UIImageView!
    @IBOutlet weak var image06: UIImageView!
 
    
    @IBOutlet weak var syncFilterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            syncFilterButton.isEnabled = false
       
        
    }
    
    @IBAction func resetImages(_ sender: Any) {
         image01.image = UIImage(named: "Placeholder")
         image02.image = UIImage(named: "Placeholder")
         image03.image = UIImage(named: "Placeholder")
         image04.image = UIImage(named: "Placeholder")
         image05.image = UIImage(named: "Placeholder")
         image06.image = UIImage(named: "Placeholder")
        
    }
    
    
    @IBAction func privateQueueDownload(_ sender: Any) {
        
        //Definimos el Queue SERIAL QUEUE  ---->>
        // La cola del cine del verano , una ventanilla de uno en uno
        
        let mySerialQueue = DispatchQueue(label: "io.keepcoding")
        
        mySerialQueue.async {
            let data1 = try! Data(contentsOf: URL(string: imageURL01)!)
            DispatchQueue.main.async { [weak self] in // opcion weak puede que tenga valor o no por ejemplo
                self?.image01.image = UIImage(data: data1)
            }
        }
        
        // Al rato carga la segunda imagen seguidamente de la primera

        mySerialQueue.async {
           let data2 = try! Data(contentsOf: URL(string: imageURL02)!)
             DispatchQueue.main.async {
            self.image02.image = UIImage(data: data2)
            
        }
}
        
        mySerialQueue.async {
            let data3 = try! Data(contentsOf: URL(string: imageURL03)!)
            DispatchQueue.main.async {
                self.image03.image = UIImage(data: data3)
                
            }
        }
        
        mySerialQueue.async {
            let data4 = try! Data(contentsOf: URL(string: imageURL04)!)
            DispatchQueue.main.async {
                self.image04.image = UIImage(data: data4)
                
            }
        }
        
        mySerialQueue.async {
            let data5 = try! Data(contentsOf: URL(string: imageURL05)!)
            DispatchQueue.main.async {
                self.image05.image = UIImage(data: data5)
                
            }
        }
      
        mySerialQueue.async {
            let data6 = try! Data(contentsOf: URL(string: imageURL06)!)
            DispatchQueue.main.async {
                self.image06.image = UIImage(data: data6)
                
            }
        }
    
    }
    
    @IBAction func privateQueueConcurrence(_ sender: Any) {
        
        //QUEUE  CONCURRENTE
        // VAn simultaneamente cada uno por su carril
        
  //      let myConcurrentQueue = DispatchQueue(label: "io.keepcooding concurrente",  attributes: .concurrent)
        
        // este hace exactamente igual que el caso anterior comentado
        let myConcurrentQueue = DispatchQueue.global(qos: .userInitiated)
        
        
        
     //Anexo para ejecutar secuencia de Dispatch Group, cuando carge todo hailitado para realizar otra tarea
        let group = DispatchGroup()
       
        
        // Mismos datos que el el QUEUE Serial
        // anexo group para entrar
        group.enter()
        myConcurrentQueue.async {
            let data1 = try! Data(contentsOf: URL(string: imageURL01)!)
            DispatchQueue.main.async { [weak self] in // opcion weak puede que tenga valor o no por ejemplo
                self?.image01.image = UIImage(data: data1)

        // Anexo de group para salir del grupo
                group.leave()

            }
        }
        
    
         group.enter()
        myConcurrentQueue.async {
            let data2 = try! Data(contentsOf: URL(string: imageURL02)!)
            DispatchQueue.main.async {
                self.image02.image = UIImage(data: data2)
              group.leave()
            }
        }
         group.enter()
        myConcurrentQueue.async {
            let data3 = try! Data(contentsOf: URL(string: imageURL03)!)
            DispatchQueue.main.async {
                self.image03.image = UIImage(data: data3)
              group.leave()
            }
        }
         group.enter()
        myConcurrentQueue.async {
            let data4 = try! Data(contentsOf: URL(string: imageURL04)!)
            DispatchQueue.main.async {
                self.image04.image = UIImage(data: data4)
              group.leave()
            }
        }
         group.enter()
        myConcurrentQueue.async {
            let data5 = try! Data(contentsOf: URL(string: imageURL05)!)
            DispatchQueue.main.async {
                self.image05.image = UIImage(data: data5)
              group.leave()
            }
        }
         group.enter()
        myConcurrentQueue.async {
            let data6 = try! Data(contentsOf: URL(string: imageURL06)!)
            DispatchQueue.main.async {
                self.image06.image = UIImage(data: data6)
               group.leave()
            }
        }
        // Notificacion de group
        group.notify(queue: DispatchQueue.main) { [weak self] in
        self?.syncFilterButton.isEnabled = true
        }
    }
    
    
    
    @IBAction func asyncDataDownload(_ sender: Any) {
    }
    
    
    @IBAction func synfilter(_ sender: Any) {
        
        print (" Deberia aplicar el filtro")
        
        let sepia0p1 = SepiaFilterOperation()
        sepia0p1.inputImage = self.image01.image
        let sepia0p2 = SepiaFilterOperation()
        sepia0p2.inputImage = self.image02.image
        let sepia0p3 = SepiaFilterOperation()
        sepia0p3.inputImage = self.image03.image
        let sepia0p4 = SepiaFilterOperation()
        sepia0p4.inputImage = self.image04.image
        let sepia0p5 = SepiaFilterOperation()
        sepia0p5.inputImage = self.image05.image
        let sepia0p6 = SepiaFilterOperation()
        sepia0p6.inputImage = self.image06.image
        
        let serialFilterQueue = OperationQueue()
        serialFilterQueue.maxConcurrentOperationCount = 2
        
        sepia0p1.completionBlock = { [weak self] in
            guard let output = sepia0p1.outputImage else
            {return}
            DispatchQueue.main.async {
                self?.image01.image = output
            }
        }
        sepia0p2.completionBlock = { [weak self] in
            guard let output = sepia0p2.outputImage else
            {return}
            DispatchQueue.main.async {
                self?.image02.image = output
            }
        }
        sepia0p3.completionBlock = { [weak self] in
            guard let output = sepia0p3.outputImage else
            {return}
            DispatchQueue.main.async {
                self?.image03.image = output
            }
        }
        sepia0p4.completionBlock = { [weak self] in
            guard let output = sepia0p4.outputImage else
            {return}
            DispatchQueue.main.async {
                self?.image04.image = output
            }
        }
        sepia0p5.completionBlock = { [weak self] in
            guard let output = sepia0p5.outputImage else
            {return}
            DispatchQueue.main.async {
                self?.image05.image = output
            }
        }
        sepia0p6.completionBlock = { [weak self] in
            guard let output = sepia0p6.outputImage else
            {return}
            DispatchQueue.main.async {
                self?.image06.image = output
            }
        }
        serialFilterQueue.addOperation(sepia0p1)
        serialFilterQueue.addOperation(sepia0p2)
        serialFilterQueue.addOperation(sepia0p3)
        serialFilterQueue.addOperation(sepia0p4)
        serialFilterQueue.addOperation(sepia0p5)
        serialFilterQueue.addOperation(sepia0p6)
        }
    }
    
    


