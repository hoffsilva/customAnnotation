//
//  ViewController.swift
//  CustomMap
//
//  Created by Hoff Silva on 08/05/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import UIKit
//importe o mapkit
import MapKit
//importe o CoreLocation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //Crie um atributo do tipo mapa
    @IBOutlet weak var mapView: MKMapView!
    
    //view usada pra mostrar as informacoes.
    @IBOutlet weak var customView: UIView!
    
    // usado pra pegar a localizacao do app. Voce precisa solicitar a permissao de usar localizacao do device.
    // Adicione isso ao plist - Privacy - Location When In Use Usage Description  com  qualquer mensagem na string
    var locationManager = CLLocationManager()
    
    //array de annotations
    var annotations = [MKPointAnnotation]()
    
    // Array de pontos
    let pins = [CLLocationCoordinate2D(latitude: -16.7762816, longitude: -48.887204), CLLocationCoordinate2D(latitude: -15.7762816, longitude: -47.887204), CLLocationCoordinate2D(latitude: -17.7762816, longitude: -48.887204)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Definindo os delegates
        mapView.delegate = self
        locationManager.delegate = self
        
        //solicitando a permissao de utilizacao da localizacao
        locationManager.requestWhenInUseAuthorization()
        
        //adicionando os pins ao mapa.
        drawPinsOnMap()
    }
    
    func drawPinsOnMap(){
        // limpando as annotations do mapa
        self.mapView.removeAnnotations(self.mapView.annotations)
        for pin in pins {
            // criando o mkpintannotation
            let annotation = MKPointAnnotation()
            // Definindo as coordenadas nele
            annotation.coordinate = pin
            // adicionando ele ao array de pontos
            annotations.append(annotation)
        }
        // adicionando o array de annotations aos annotations do mapview
        mapView.addAnnotations(annotations)
        // recarregando o mapview
        mapView.reloadInputViews()
    }
}

extension ViewController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        // Criando UIView para a annotation
        let customViewForAnnotation = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        // Criando UIImageView para colocarmos a foto do objeto
        let imageViewForAnnotation = UIImageView(frame: CGRect(x: 0, y: -45, width: 40, height: 40))
        
        // Definindo o ajuste para a imagem se encaixar dentro da delimitação do tamanho da view.
        imageViewForAnnotation.contentMode = .scaleAspectFit
        
        // Definindo que o conteúdo da view será recortado pelas bordas dela
        imageViewForAnnotation.clipsToBounds = true
        
        // Definindo a expessura da borda da view
        imageViewForAnnotation.layer.borderWidth = 1.5
        
        // Definindo a cor da borda da view
        imageViewForAnnotation.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        
        // Definindo o raio dos cantos da view para ficar arredondado.
        imageViewForAnnotation.layer.cornerRadius = 20
        
        // Definindo a imagem do objeto atual
        imageViewForAnnotation.image = #imageLiteral(resourceName: "perfil")
        
        // adicionando a imageview à view customizad
        // após este ponto nós teremos uma view com uma imageview dentro dela.
        customViewForAnnotation.addSubview(imageViewForAnnotation)
        
        // Constante para ser reutilizada na criacao da MKAnnotationView
        let reusedPin = "pin"
        
        // Usando o delegate pra pegar a annotationview da classe ou criar uma view da classe alocada ao invés de alocar uma nova classe.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reusedPin)
        
        // Verificando se o delegate não devolveu uma annotation
        if annotationView == nil {
            // Como o delegate nao devolveu nada, vamos criar uma annotation na classe alocada.
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reusedPin)
        } else {
            // Adicionando a annotation do metodo à annotation da view que acabos de criar.
            annotationView?.annotation = annotation
        }
        
        // adicionando a view customizada à annotation view.
        annotationView?.addSubview(customViewForAnnotation)
        
        // adicionando a imagem de seta à MKAnnotationView
        annotationView?.image = #imageLiteral(resourceName: "sa")
        
        // Definindo o ajuste para a imagem se encaixar dentro da delimitação do tamanho da view.
        annotationView?.contentMode = .scaleAspectFit
        
    
        return annotationView
    }
}

