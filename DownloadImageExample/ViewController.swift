//
//  ViewController.swift
//  DownloadImageExample
//
//  Created by John Codeos on 2/17/20.
//  Copyright © 2020 John Codeos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var downloadButton: UIButton!

    let image = "https://i.imgur.com/yc3CbKN.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: image)
        let data = try? Data(contentsOf: url!)
        myImageView.image = UIImage(data: data!)
    }

    @IBAction func downloadButtonAction(_ sender: UIButton) {
        downloadImage(url: image)
    }

    func downloadImage(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        getDataFromUrl(url: imageUrl) { data, _, _ in
            DispatchQueue.main.async() {
                let activityViewController = UIActivityViewController(activityItems: [data ?? ""], applicationActivities: nil)
                activityViewController.modalPresentationStyle = .fullScreen
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
    }

    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
}
