//
//  MoodieWidgetLiveActivity.swift
//  MoodieWidget
//
//  Created by Virginia Zheng on 2025-02-20.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MoodieWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MoodieWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MoodieWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MoodieWidgetAttributes {
    fileprivate static var preview: MoodieWidgetAttributes {
        MoodieWidgetAttributes(name: "World")
    }
}

extension MoodieWidgetAttributes.ContentState {
    fileprivate static var smiley: MoodieWidgetAttributes.ContentState {
        MoodieWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MoodieWidgetAttributes.ContentState {
         MoodieWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MoodieWidgetAttributes.preview) {
   MoodieWidgetLiveActivity()
} contentStates: {
    MoodieWidgetAttributes.ContentState.smiley
    MoodieWidgetAttributes.ContentState.starEyes
}
