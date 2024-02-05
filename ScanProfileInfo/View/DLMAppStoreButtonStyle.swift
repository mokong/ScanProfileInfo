//
//  DLMAppStoreButtonStyle.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/5.
//

import SwiftUI

struct DLMAppStoreButtonStyle: ButtonStyle {    
    var primary: Bool
    var highlighted: Bool
    
    private struct DLMAppStoreButton: View {
        @SwiftUI.Environment(\.isEnabled) var isEnabled
        
        var configuration: ButtonStyleConfiguration
        var primary: Bool
        var highlighted: Bool
        
        var textColor: Color {
            if isEnabled {
                if primary {
                    if highlighted {
                        return Color.red
                    } else {
                        return Color.white
                    }
                } else {
                    return Color.accentColor
                }
            } else {
                if primary {
                    if highlighted {
                        return Color(.disabledControlTextColor)
                    } else {
                        return Color.white
                    }
                } else {
                    if highlighted {
                        return Color.white
                    } else {
                        return Color(.disabledControlTextColor)
                    }
                }
            }
        }
        
        func background(isPressed: Bool) -> some View {
            Group {
                if isEnabled {
                    if primary {
                        Capsule()
                            .fill(highlighted ? Color.white : Color.accentColor)
                            .brightness(isPressed ? -0.25 : 0)
                    } else {
                        Capsule()
                            .fill(Color(NSColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)))
                            .brightness(isPressed ? -0.25 : 0)
                    }
                } else {
                    if primary {
                        Capsule()
                            .fill(highlighted ? Color.white : Color(.disabledControlTextColor))
                            .brightness(isPressed ? -0.25 : 0)
                    } else {
                        EmptyView()
                    }
                }
            }
        }
        
        var body: some View {
            configuration.label
                .font(Font.caption.weight(.bold))
                .foregroundColor(textColor)
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .frame(minWidth: 65)
                .background(background(isPressed: configuration.isPressed))
                .padding(1)
        }
    }
    
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        DLMAppStoreButton(configuration: configuration, primary: primary, highlighted: highlighted)
    }
}
