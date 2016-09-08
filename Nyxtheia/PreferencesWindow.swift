//
//  PreferencesWindow.swift
//  Nyxtheia
//
//  Created by Jacob Gaffney on 8/09/2016.
//  Copyright © 2016 Jacob Gaffney. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    var delegate: PreferencesWindowDelegate?
    
    
    @IBOutlet weak var tokenTextField: NSTextField!
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activateIgnoringOtherApps(true)
        self.window?.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let token = defaults.stringForKey("token") ?? DEFAULT_TOKEN
        tokenTextField.stringValue = token
    }
    
    func windowWillClose(notification: NSNotification) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(tokenTextField.stringValue, forKey: "token")
        
        delegate?.preferencesDidUpdate()
    }
}
