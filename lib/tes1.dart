import PassKit
import Flutter

private func showPassInWallet(result: FlutterResult) {
    let passLibrary = PKPassLibrary()
    
    // Check if you have a keysManager and that listWalletPasses is non-empty
    if let keysManager = keysManager {
        for pass: PKPass in keysManager.listWalletPasses() as? [PKPass] ?? [] {
            if let passToPresent = pass.secureElementPass {
                // Present the pass using PKAddPassesViewController
                if let addPassVC = PKAddPassesViewController(pass: passToPresent) {
                    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                        viewController.present(addPassVC, animated: true, completion: nil)
                    }
                    result(true)  // Return success to Flutter
                    return
                }
            }
        }
    }
    
    result(false)  // Return failure if no pass is found
}
