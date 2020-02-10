//
//  ListTableViewControllerRepresentable.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 10/02/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//
import SwiftUI

extension ListTableViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ListTableViewController
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ListTableViewController>) -> ListTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: ListTableViewController.self)) as ListTableViewController
    }

    public func updateUIViewController(_ uiViewController: ListTableViewController, context: UIViewControllerRepresentableContext<ListTableViewController>) {
        
    }
}
