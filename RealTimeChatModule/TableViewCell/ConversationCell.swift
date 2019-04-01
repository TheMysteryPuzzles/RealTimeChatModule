
//  RealTimeChatModule

//  Copyright © 2019 TheMysteryPuzzles. All rights Given.


import UIKit

class ConversationCell: UITableViewCell {
    @IBOutlet weak var Username: UILabel!
    
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var profilePIc: RoundedImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
