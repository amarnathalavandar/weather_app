private func showPassInWallet(result: FlutterResult) {
    let passLibrary = PKPassLibrary()
    
    if let keysManager {
        let passes = keysManager.listWalletPasses() as? [PKPass] ?? []
        
        if !passes.isEmpty {
            // Option 1: Try direct presentation even with the entitlement
            for pass in passes {
                if let secureElementPass = pass.secureElementPass {
                    // This might not work if the suppression entitlement is active
                    passLibrary.present(secureElementPass)
                }
            }
            result(true)
            
            // Option 2: Alternative approach using PKAddPassesViewController
            // if let pass = passes.first {
            //     DispatchQueue.main.async {
            //         let addPassViewController = PKAddPassesViewController(pass: pass)
            //         if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            //             rootVC.present(addPassViewController!, animated: true)
            //         }
            //     }
            //     result(true)
            // } else {
            //     result(false)
            // }
        } else {
            result(false)
        }
    } else {
        result(false)
    }
}
