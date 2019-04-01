
//  RealTimeChatModule

//  Copyright © 2019 TheMysteryPuzzles. All rights Given.

import UIKit

class TotalUserCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePic: RoundedImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
