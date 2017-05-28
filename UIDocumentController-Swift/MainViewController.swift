//
//  ViewController.swift
//  UiDocumentController-Swift
//
//  Created by Ingrid Silapan on 3/05/17.
//  Copyright © 2017 All rights reserved.
//

import UIKit

enum Extension: String {
    case docx = "docx"
    case png = "png"
    case pdf = "pdf"
}

struct Sample {
    var name: String
    var ext: Extension
    var url: URL {
        get {
            return Bundle.main.url(forResource: name, withExtension: ext.rawValue)!
        }
    }
}

class MainViewController: UITableViewController {
    
    let samples = [Sample(name: "SampleDocx", ext: .docx),
                   Sample(name: "SampleImage", ext: .png),
                   Sample(name: "SamplePDF", ext: .pdf)]
    
    var documentController = UIDocumentInteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        documentController.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return samples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        let sample = samples[indexPath.row]
        cell.textLabel?.text = sample.name
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sample = samples[indexPath.row]
        
        selectOption(for: sample)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func selectOption(for sample:Sample) {
        let alertController = UIAlertController.init(title: "Select Option",
                                                     message: "", preferredStyle: .actionSheet)
        let previewAction = UIAlertAction.init(title: "Preview", style: .default) { (UIAlertAction) in
            self.previewDocument(sample)
        }
        
        let openInMenuAction = UIAlertAction.init(title: "Open In Menu", style: .default) { (UIAlertAction) in
            self.openInMenu(sample)
        }
        
        alertController.addAction(previewAction)
        alertController.addAction(openInMenuAction)
        
        alertController.show(, sender: self)
    }
    
    func previewDocument(_ sample: Sample) {
        
        documentController.url = sample.url
        documentController.presentPreview(animated: true)
        
    }
    
    func openInMenu(_ sample: Sample) {
        
        documentController.url = sample.url
        documentController.presentOpenInMenu(from: self.view.frame, in: self.view, animated: true)
        
    }

}

extension MainViewController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self;
    }

}

