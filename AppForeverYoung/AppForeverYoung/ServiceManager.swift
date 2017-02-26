
import Foundation
import MultipeerConnectivity // Permette la comunicazione tra dispositici vicini

// Il protocollo da seguire per la connettività e la comunicazione
protocol ServiceManagerDelegate {

    func connectedDevicesChanged(manager :ServiceManager, connectedDevices: [String])
    func communicatesMessage(manager :ServiceManager, message: String)

}


// Classe per comicare tra i device
class ServiceManager : NSObject {

    // Nome che diamo al servizio
    private let ServiceType = "example-color"

    // IL nome del dispositivo che sarà visibile dagli altri
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)

    // L'istanza utilizzata per il servizio
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser

    // Registra i vari eventi del servizio
    var delegate : ServiceManagerDelegate?
    
    // Creao una sessione per la comuicazione
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()

    // Inizializza i vari valori
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ServiceType)
        super.init()

        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()

        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
    }

    // Funzione per comunicare un valore da un dispositivo ad un altro
    func send(msg : String, usernameRequest: String) {
        NSLog("%@", "message: \(msg) by \(usernameRequest) to \(session.connectedPeers.count) peers")

        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(msg.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }

    }

    //  Deiniziatore che stppa i servizi alla fine della comunicazione
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }

}

// Estendo i servizi dell'advertiser
extension ServiceManager: MCNearbyServiceAdvertiserDelegate {

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }

}

// Estendo i servizi del browser
extension ServiceManager: MCNearbyServiceBrowserDelegate {

    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
}

// Estendo i servizi del delegato
extension ServiceManager: MCSessionDelegate {

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state)")
        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
            session.connectedPeers.map{$0.displayName})
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")
        let str = String(data: data, encoding: .utf8)!
        self.delegate?.communicatesMessage(manager: self, message: str)
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }

}
