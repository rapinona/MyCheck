
import UIKit
import TabPageViewController

class LimitedTabPageViewController: TabPageViewController {

    override init() {
        super.init()
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor(named: "Background")
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor(named: "Background")
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor(named: "Background")
        
        let vc4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EstatusViewController")
        
        
        tabItems = [(vc1, "Enviadas"), (vc2, "Recibidas"), (vc3, "En Proceso"), (vc4, "Completadas")]
        option.tabWidth = view.frame.width / CGFloat(tabItems.count)
        option.hidesTopViewOnSwipeType = .all
        option.tabBackgroundColor = UIColor(named: "Background")!
        option.pageBackgoundColor = UIColor(red: 0.45, green: 0.95, blue: 0.44, alpha: 1.00)
        option.currentColor = UIColor(red: 0.45, green: 0.95, blue: 0.44, alpha: 1.00)
        option.fontSize = 20.0
        option.tabMargin = 10.0
        option.tabWidth = 140.0
        option.isTranslucent = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
