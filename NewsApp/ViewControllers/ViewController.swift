//
//  ViewController.swift
//  NewsApp
//
//  Created by Emre Alpago on 15.02.2022.
//
import UIKit

class ViewController: UIViewController{
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var newsSearchBar: UISearchBar!
    
    var newsArray = [Article]()
    var filteredArray = [Article]()
    var totalResults = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 120.0
        tableView.dataSource = self
        tableView.delegate = self
        newsSearchBar.delegate = self
        tableView.register(UINib(nibName: K.cellNibName , bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        title = "News"
        managingData(search: "bitcoin")
    }
    
    func managingData(search: String) {
        NetworkManager.service.request(requestRoute: .everything(search: search), responseModel: APIResponse.self) { [weak self]
            details in
            DispatchQueue.main.async {
                self?.newsArray = details.articles ?? []
                self?.filteredArray = details.articles ?? []
                self?.tableView.reloadData()
            }
        }
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! NewsTableViewCell
        let model = filteredArray[indexPath.row]
        cell.initiliaze(cellModel: model)
        cell.delegate = self
        cell.layoutIfNeeded()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            destination.details = newsArray[tableView.indexPathForSelectedRow!.row]
        }
    }
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            self.filteredArray = self.newsArray.filter({ article in
                if let description = article.description {
                    return description.contains(searchText)
                }
                return false
            })
        } else {
            self.filteredArray = self.newsArray
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        managingData(search: "Bitcoin")
    }
}

extension ViewController:TableViewCellDelegate{
    func didselectItem(model: Article) {
        print("\(model.title ?? "")")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.initialize(details: model)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}








