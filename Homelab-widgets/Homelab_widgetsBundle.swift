//
//  Homelab_widgetsBundle.swift
//  Homelab-widgets
//
//  Created by Mathieu Dubart on 19/03/2026.
//

import WidgetKit
import SwiftUI

@main
struct Homelab_widgetsBundle: WidgetBundle {
    var body: some Widget {
        Homelab_widgets()
        TorBoxStorageWidgets()
        Homelab_widgetsControl()
        Homelab_widgetsLiveActivity()
    }
}
