//
//  PhoneView.swift
//  TextTalk
//
//  Created by Crystal Sun on 2/7/23.
//

import SwiftUI
import WAL
import UIKit
import WebRTC
import SIPKeyboardManager
import AVFoundation
import Speech
import AgoraRtcKit


struct PhoneView: View {
    @StateObject private var isActiveCall = CallManager.shared.isActiveCall
    @State private var inputNumber = ""
    var body: some View {
        NavigationView{
            Home()
        }
    }
}



struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .cornerRadius(20)
            .border(Color.blue, width: 2)
            .shadow(color: .gray, radius: 10)

    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneView()
    }
}

struct Home : View {
    @State var presentUnlockedNotif = true
       
       var body: some View{
           
           ZStack{
               VStack {
                   if presentUnlockedNotif {
                       Text("Phone")
                           .font(.title2)
                           .fontWeight(.heavy)
                           .onAppear() {
                               Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                                   withAnimation(.easeInOut(duration: 2)) {
                                       self.presentUnlockedNotif.toggle()
                                   }
                               }
                           }
                   }
                   
                   DialPad()
                   PageViewController()
               }
           }
           //.preferredColorScheme(unLocked ? .light : .dark)
       }
}

struct DialPad : View {
    @StateObject private var isActiveCall = CallManager.shared.isActiveCall
    @State private var inputNumber = ""
    let rows = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["*", "0", "#"]
    ]
    
    var body: some View {
        VStack {
            if isActiveCall.isActive {
                Button(action: {
                    CallManager.shared.end()
                }) {
                    Image(systemName: "phone.down")
                }
            }
            else {
                VStack {
                    Spacer()
                    Text(inputNumber)
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                    VStack(spacing: 0) {
                        ForEach(rows, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(row, id: \.self) { digit in
                                    Button(action: {
                                        inputNumber += digit
                                    }, label: {
                                        Text(digit)
                                            .font(.title2)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(Color.white)
                                            .foregroundColor(.black)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(Color.gray, lineWidth: 0.5)
                                            )
                                    })
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .frame(maxHeight: 200)
                    HStack {
                        Button(action: {
                            if inputNumber.count > 0 {
                                inputNumber.removeLast()
                            }
                        }, label: {
                            Image(systemName: "delete.left")
                                .foregroundColor(.red)
                        })
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        
                        Button(action: {
                            CallManager.shared.initiate(call: Call(
                            partnerID: "Unknown",
                            handle: inputNumber,
                            callMembers: [""],
                            lengthInMinutes: 0,
                            theme: Theme.bubblegum))
                        }) {
                            Image(systemName: "phone.arrow.up.right")
                        }
                    }
                }.padding()
                
            }
        }
    }
}


struct PageViewController: UIViewControllerRepresentable {


    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [CallViewController()], direction: .forward, animated: true)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource {
        var parent: PageViewController
        var controllers = [UIViewController]()

        init(_ pageViewController: PageViewController) {
            parent = pageViewController
//            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
    }
}


class CallViewController: UIViewController {
    
    // The main entry point for Video SDK
    var agoraEngine: AgoraRtcEngineKit!
    // By default, set the current user role to broadcaster to both send and receive streams.
    var userRole: AgoraClientRole = .broadcaster

    // Update with the App ID of your project generated on Agora Console.
    let appID = "282cdb7b0fd348c990a49eb693366d50"
    // Update with the temporary token generated in Agora Console.
    // Token expires on April 19, 2023 9:21 PM UTC (5:21 PM ET)
    var token = "007eJxTYChKW/BDukFVb3bqxsUPF8zexyl+86JMqfiMNRc5anZLhRgrMBhZGCWnJJknGaSlGJtYJFtaGiSaWKYmmVkaG5uZpZgavOO0T2kIZGSwY1dhYWSAQBCfiyE/NzU9UTclNTefgQEAtw4fYw=="
    // Update with the channel name you used to generate the token in Agora Console.
    var channelName = "omega-demo"
    
    // Click to join or leave a call

    var joinButton: UIButton!
    // Track if the local user is in a call
    var joined: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.joinButton.setTitle( self.joined ? "Leave" : "Join", for: .normal)
            }
        }
    }
    
    // FOR AUDIO TRACH INPUT Audio file parameters
//    var SAMPLE_RATE: Int = 44100
//    var NUM_OF_CHANNELS: Int = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Initializes the video view
        initViews()
        // The following functions are used when calling Agora APIs
        initializeAgoraEngine()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        leaveChannel()
//        DispatchQueue.global(qos: .userInitiated).async {AgoraRtcEngineKit.destroy()}
    }


    func joinChannel() async {
        if await !self.checkForPermissions() {
            showMessage(title: "Error", text: "Permissions were not granted")
            return
        }

        let option = AgoraRtcChannelMediaOptions()

        // Set the client role option as broadcaster or audience.
        if self.userRole == .broadcaster {
            option.clientRoleType = .broadcaster
            
            // FOR AUDIO TRACK INPUT
//            option.channelProfile = .communication
//            option.publishCameraTrack = false
//            option.publishMicrophoneTrack = false
//            option.publishCustomAudioTrack = true
//            agoraEngine.setExternalAudioSource(true, sampleRate: SAMPLE_RATE, channels: NUM_OF_CHANNELS, sourceNumber: 1, localPlayback: true, publish: true)

        } else {
            option.clientRoleType = .audience
        }

        // For an audio call scenario, set the channel profile as communication.
        option.channelProfile = .communication

        // Join the channel with a temp token and channel name
        let result = agoraEngine.joinChannel(
            byToken: token, channelId: channelName, uid: 0, mediaOptions: option,
            joinSuccess: { (channel, uid, elapsed) in }
        )

        // Check if joining the channel was successful and set joined Bool accordingly
        if (result == 0) {
            joined = true
            
//            // TODO: ADD AUDIO FILE HERE
//            let url = Bundle.main.url(forResource: "utteranceOut", withExtension: "caf")
//            //
//
//            guard var data = try? Data(contentsOf: url!) else { return }
//            let dataPointer = UnsafeMutableRawPointer(mutating: &data)
//            agoraEngine.pushExternalAudioFrameRawData(dataPointer, samples: 0, sourceId: 0, timestamp: 0)

            showMessage(title: "Success", text: "Successfully joined the channel as \(self.userRole)")
        }
    }

    func leaveChannel() {
        let result = agoraEngine.leaveChannel(nil)
        // Check if leaving the channel was successful and set joined Bool accordingly
        if result == 0 { joined = false }
    }

    
    func initializeAgoraEngine() {
        let config = AgoraRtcEngineConfig()
        // Pass in your App ID here.
        config.appId = appID
        // Use AgoraRtcEngineDelegate for the following delegate parameter.
        agoraEngine = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
    }

    func initViews() {
        joinButton = UIButton(type: .system)
        joinButton.frame = CGRect(x: 140, y: 150, width: 100, height: 50)
        joinButton.setTitle("Join", for: .normal)

        joinButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(joinButton)
    }

    @objc func buttonAction(sender: UIButton!) {
        if !joined {
            sender.isEnabled = false
            Task {
                await joinChannel()
                sender.isEnabled = true
            }
        } else {
            leaveChannel()
        }
    }
    
    func checkForPermissions() async -> Bool {
        let hasPermissions = await self.avAuthorization(mediaType: .audio)
        return hasPermissions
    }

    func avAuthorization(mediaType: AVMediaType) async -> Bool {
        let mediaAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        switch mediaAuthorizationStatus {
        case .denied, .restricted: return false
        case .authorized: return true
        case .notDetermined:
            return await withCheckedContinuation { continuation in
                AVCaptureDevice.requestAccess(for: mediaType) { granted in
                    continuation.resume(returning: granted)
                }
            }
        @unknown default: return false
        }
    }
    
    func showMessage(title: String, text: String, delay: Int = 2) -> Void {
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
            self.present(alert, animated: true)
            alert.dismiss(animated: true, completion: nil)
        })
    }


}

extension CallViewController: AgoraRtcEngineDelegate {
    // Callback called when a new host joins the channel
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {

    }
}
