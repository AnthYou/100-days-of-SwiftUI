//
//  AboutUsingEnumsViewStates.swift
//  BucketList
//
//  Created by Anthony You on 13/03/2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct AboutUsingEnumsViewStates: View {
    enum LoadingState {
        case loading, success, failed
    }

    var loadingState = LoadingState.loading
    
    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct AboutUsingEnumsViewStates_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsingEnumsViewStates()
    }
}
