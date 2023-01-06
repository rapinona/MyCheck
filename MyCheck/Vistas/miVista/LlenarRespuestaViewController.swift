//
//  LlenarRespuestaViewController.swift
//  MyCheck
//
//  Created by Piñón Ayala Rodrigo  on 05/11/22.
//

import UIKit

class LlenarRespuestaViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet var imageFoto: UIImageView!
    @IBOutlet var btnFoto: UIButton!
    @IBOutlet var cancelFoto: UIButton!
    @IBOutlet var verFoto: UIButton!
    
    
    var ipc : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageFoto.isHidden = true
        cancelFoto.isHidden = true
        verFoto.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageResponse(_ sender: Any) {
        ipc = UIImagePickerController()
        //asignamos el delegado para controlar los eventos de eleccion y edicion de foto
        ipc.delegate = self
        
        let alert = UIAlertController(title: "My Team", message: "De de donde quieres tomar la foto.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Libreria", comment: "Default action"), style: .default, handler: { _ in
            self.ipc.sourceType = .photoLibrary
            self.present(self.ipc, animated: true)

        }))
                                      
        alert.addAction(UIAlertAction(title: NSLocalizedString("Camara", comment: "Default action"), style: .default, handler: { _ in
            self.ipc.sourceType = .camera
            self.present(self.ipc, animated: true)
        }))
            
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //si configuramos que se permite la edicion entonces la imagen llega en la llave .editedImage
        
        if let imagen = info[.originalImage] as? UIImage{
            imageFoto.image = imagen
            imageFoto.isHidden=false
            cancelFoto.isHidden=false
            verFoto.isHidden=false
        }
        
        ipc.dismiss(animated: true)
    }
    
    @IBAction func cancelFoto(_ sender: Any) {
        imageFoto.isHidden = true
        cancelFoto.isHidden = true
        verFoto.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleFoto" {
            
            
            let destination = segue.destination as! VerMasFotoViewController
            destination.currentFoto = imageFoto.image
            
        }
    }
    
    @IBAction func verFotoDetalle(_ sender: Any) {
        self.performSegue(withIdentifier: "detalleFoto", sender: Self.self)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //el usuario cancela
    }
}
