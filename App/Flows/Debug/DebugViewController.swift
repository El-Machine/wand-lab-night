//
//  DebugViewController.swift
//  Heap
//
//  Created by Alex Kozin on 15.04.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

class DebugViewController: UITableViewController {

    static override var flow: Flow {
        .Debug
    }

    enum Sensetive: Int {
        case wipeCache, logOut
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Sensetive(rawValue: indexPath.row) {
            case .wipeCache:
                wipeCache()
            case .logOut:
                logOut()
            default:
                break
        }
    }

    func wipeCache() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            exit(0)
        }
    }

    func logOut() {
        dismiss()

    }
    
}
