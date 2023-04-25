import UIKit
import Web3Wallet

final class WalletRouter {
    weak var viewController: UIViewController!

    private let app: Application

    init(app: Application) {
        self.app = app
    }

    func present(request: AuthRequest, context: AuthContext?) {
        AuthRequestModule.create(app: app, request: request, context: context)
            .presentFullScreen(from: viewController, transparentBackground: true)
    }

    func present(sessionRequest: Request, sessionContext: Session.Context?) {
        SessionRequestModule.create(app: app, sessionRequest: sessionRequest, sessionContext: sessionContext)
            .presentFullScreen(from: viewController, transparentBackground: true)
    }
    
    func presentPaste(onValue: @escaping (String) -> Void, onError: @escaping (Error) -> Void) {
        PasteUriModule.create(app: app, onValue: onValue, onError: onError)
            .presentFullScreen(from: viewController, transparentBackground: true)
    }
    
    func presentConnectionDetails(session: Session) {
        ConnectionDetailsModule.create(app: app, session: session)
            .push(from: viewController)
    }

    func presentScan(onValue: @escaping (String) -> Void, onError: @escaping (Error) -> Void) {
        ScanModule.create(app: app, onValue: onValue, onError: onError)
            .wrapToNavigationController()
            .present(from: viewController)
    }

    func dismiss() {
        viewController.navigationController?.dismiss()
    }
}
