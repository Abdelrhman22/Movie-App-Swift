import UIKit
import CoreData
import Alamofire
import SDWebImage
class MovieDetailsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var trailerTable: UITableView!
    
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    var fullReviews : String = "Intial Value"
    var movies : [NSManagedObject]!;
    var reviews : [Review]!
    var trailers : [Trailer]!
    let dataLayer : DataLayer = DataLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var myMovie : Movie = Movie ()
    var detailsPresenter : DetailsPresenter = DetailsPresenter()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        reviewTable.delegate = self
        reviewTable.dataSource = self
        
        trailerTable.delegate = self
        trailerTable.dataSource = self
       

        
        self.reviews = []
        self.trailers = []
        titleLabel.text = myMovie.title
        yearLabel.text = myMovie.releaseDate
        rateLabel.text = String( myMovie.voteAverage ) + " / 10"
        posterImageView.sd_setImage(with: URL(string: myMovie.fullUrl), placeholderImage: UIImage(named: "placeholder.jpg"))
        overviewLabel.text = myMovie.overview
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 1
        switch tableView {
        case reviewTable:
            numberOfRows = reviews.count
        case trailerTable :
            numberOfRows = trailers.count
        default:
            print("Error in numberOfRowsInSection")
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell()
        switch tableView {
        case reviewTable:
            let cell = tableView.dequeueReusableCell(withIdentifier:"reviewCell" , for: indexPath) as! ReviewTableViewCell
            cell.authorLabel.text = reviews[indexPath.row].author
            cell.contentLabel.text = reviews[indexPath.row].content
        case trailerTable:
            let cell = tableView.dequeueReusableCell(withIdentifier:"trailerCell" , for: indexPath) as! TrailerTableViewCell
            let image : UIImage = UIImage(named: "youtube.png")!
            cell.trailerLabel.text = trailers[indexPath.row].name
            cell.trailerImageView.image = image
        default:
            print("")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case trailerTable:
            do {
                let key = self.trailers[indexPath.row].key
                var url = NSURL(string:"youtube://\(key)")!
                if UIApplication.shared.canOpenURL(url as URL)
                {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
                else
                {
                    url = NSURL(string:"http://www.youtube.com/watch?v=\(key)")!
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }
        default:
            print("Error Occuered")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case reviewTable:
            return 200.0
        case trailerTable:
            return 100.0
        default:
            return 50.0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async{

            self.view.reloadInputViews()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setMovie(movieObj : Movie)
    {
        myMovie = movieObj
        self.detailsPresenter.setDelegate(delegate: self , dataLayer: dataLayer)
        self.detailsPresenter.getReviews(url: self.myMovie.reviewURL)
        self.detailsPresenter.getTrailers(url: self.myMovie.trailerURL)
    
        
    }
    @IBAction func addToFavourite(_ sender: UIButton) {
        let ismovieExist = self.detailsPresenter.isMovieExists(id: myMovie.id)
        if ismovieExist
        {
           

            let alertController = UIAlertController(title: "\(myMovie.title)", message: "This Movie Already Exists , Do you Want to remove it ?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let deleteStatus = self.dataLayer.deleteMovie(id: self.myMovie.id)
                print("\(deleteStatus)")
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            let addStatus = dataLayer.insertMovie(movie: myMovie)
            print("Movie added Status \(addStatus)")
            let alertController = UIAlertController(title: "\(myMovie.title)", message: "Added Successfully", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func setre(reviewArr: Array<Review>) {
        self.reviews = reviewArr
        reviewTable.reloadData()
    }
    func setTrai(trailerArr: Array<Trailer>) {
        self.trailers = trailerArr
        trailerTable.reloadData()
    }
}
