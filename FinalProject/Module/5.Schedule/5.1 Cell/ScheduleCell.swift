//
//  ScheduleCell.swift
//  FinalProject
//
//  Created by Abcd on 10/11/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
protocol ScheduleCellDelegate: class {
    func cancelReserver(at: ScheduleCell, idResever: Int )
}
class ScheduleCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet var nameOfPitch: UILabel!
    @IBOutlet var addressOfPitch: UILabel!
    @IBOutlet var priceOfPitch: UILabel!
    @IBOutlet var timeOfPitch: UILabel!
    @IBOutlet var dateofPitch: UILabel!
    // MARK: - Properties
    weak var delegate: ScheduleCellDelegate?
    var viewModel: ScheduleCellModel? {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Function
    private func updateView() {
        nameOfPitch.text = viewModel?.resever.pitch.name
        addressOfPitch.text = viewModel?.resever.pitch.type?.owner?.address
        priceOfPitch.text = "\(viewModel?.resever.price.price ?? 0) VND"
        timeOfPitch.text = "\(viewModel?.resever.time.startTime ?? "") - \(viewModel?.resever.time.endTime ?? "")"
        dateofPitch.text = viewModel?.resever.date
        delegate?.cancelReserver(at: self, idResever: viewModel?.resever.id ?? 0)
        viewContainer.layer.cornerRadius = 15
    }
    
}
