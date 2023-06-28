//
//  AppDelegate.swift
//  Timesy
//
//  Created by Tomas D. De Andrade Gomes on 6/21/23.
//


import UIKit
import CoreData
import Firebase
import FBSDKLoginKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        //GIDSignIn.sharedInstance.clientID = "745246872491-13vo6rnbikh9vvj4ef4frgopq1h0q8jj.apps.googleusercontent.com"
        //GIDSignIn.sharedInstance.delegate = self
        //GIDSignIn.sharedInstance.restorePreviousSignIn()
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app,
                                               open: url,
                                               sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                               annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Chat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            if let error = error {
                print("Failed to sign in with Google: \(error)")
            }
            return
        }
        
        guard let user = user else {
            return
        }
        
        print ("Did sign in with Google: \(user)")
        
        guard let email = user.profile?.email,
              let firstName = user.profile?.givenName,
              let lastName = user.profile?.familyName else {
            return
        }
        
        //let email = user.profile!.email
        
        DatabaseManager.shared.userExists(with: email, completion: {exists in
            if !exists {
                //Insert to database
                DatabaseManager.shared.insertUser(with: TimesyAppUser(firstName: firstName,
                                                                      lastName: lastName,
                                                                      emailAddress: email))
            }
        })
            
 //      guard let authentication = user.authentication else {
 //          print("missing auth object off of google user")
 //          return
 //      }

 //              let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
 //                                                             accessToken: authentication.accessToken)
 //      FirebaseAuth.Auth.auth().signIn(with: credential, completion: { authResult, error in
 //          guard authResult != nil, error == nil else {
 //              print("Failed to Log In with google credential")
 //              return
 //          }
 //
 //          print("Successfully signed in with Google Credential")
 //          NotificationCenter.default.post(name: .didLogInNotification, object: nil)
 //      })
  }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Google User was disconnected")
    }
}



