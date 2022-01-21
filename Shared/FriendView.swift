//
//  FriendView.swift
//  greengrass
//
//  Created by 김아인 on 2022/01/20.
//

import SwiftUI
import Alamofire
import Charts
import URLImage
import SafariServices
import UserNotifications

struct FriendView: View {
    @Binding var selection: Int
    @Binding var userName: String
    @Binding var userFriendName: String
    @Binding var userUserName: String
    @Binding var userUserNameSearch: String
    @Binding var userGoal: String
    @Binding var userGoalInput: String
    @Binding var contributionDateStart: String
    @Binding var contributionDateStop: String
    @Binding var contributionUserDateStart: String
    @Binding var contributionUserDateStop: String
    @Binding var contributionCount: String
    @Binding var contributionCountDay: String
    @Binding var contributionUserCountDay: String
    @Binding var contributionFriendCount: String
    @Binding var contributionUserCount: String
    @Binding var githubProfilePhotoURL: String
    @Binding var githubFriendProfilePhotoURL: String
    @Binding var githubUserProfilePhotoURL: String
    @Binding var contents: String
    @Binding var refreshTime: String
    @Binding var timeDifference: String
    @Binding var timeDifferenceInfo: Bool
    @Binding var mainInfoText1: String
    @Binding var mainInfoText2: String
    @Binding var commitCountArr : [Double]
    @Binding var commitUserCountArr : [Double]
    @Binding var commitCountMaxValue: Int
    @Binding var commitCountMinValue: Int
    @Binding var commitUserCountMaxValue: Int
    @Binding var commitUserCountMinValue: Int
    @Binding var progressCommitDayValue: Float
    @Binding var todayCommit: Int
    @Binding var todayFriendCommit: Int
    @Binding var todayUserCommit: Int
    @Binding var withGithubDay: Int
    @Binding var withGithubFriendDay: Int
    @Binding var withGithubUserDay: Int
    @Binding var followers: Int
    @Binding var following: Int
    @Binding var Friendfollowers: Int
    @Binding var Friendfollowing: Int
    @Binding var Userfollowers: Int
    @Binding var Userfollowing: Int
    @Binding var githubStartDate: String
    @Binding var githubFriendStartDate: String
    @Binding var githubNameEdit: Bool
    @Binding var githubGoalEdit: Bool
    @Binding var githubFriendNameEdit: Bool
    @Binding var showingPopover: Bool
    @Binding var showSaveButton1: Bool
    @Binding var showSaveButton2: Bool
    @Binding var showSaveButton3: Bool
    @Binding var showSaveButton4: Bool
    @Binding var showSaveButton5: Bool
    @Binding var showingAlert: Bool
    @Binding var alertTitle: String
    @Binding var alertBody: String
    @Binding var internetConnected: Bool
    @Binding var selectPushAlertTimeHour: String
    @Binding var selectPushAlertTimeMinute: String
    @Binding var flipCard: Bool
    @Binding var commitAlert: Bool
    @Binding var showSafari: Bool
    @Binding var urlString: String
    @Binding var userToken: String
    @Binding var lastGetApiTime: String
    @Binding var rankCount: Int
    @Binding var rankText : [String]
    @Binding var rankTextColor : [Color]
    @Binding var rankBackgroundColor : [Color]
    @Binding var loading: Bool
    @Binding var position: Int
    @Binding var randomNumber: Int
    @Binding var pushAlertShow: Bool
    @Binding var commitMaintain: Int
    @Binding var progressCommitMaintainValue: Float
    @Binding var commitMaintainCheerTextRandomNumber: Int
    @Binding var commitMaintainCheerText: [String]
    var body: some View {
        ZStack{
            Color.Background
                .ignoresSafeArea()
            VStack{
                HStack(spacing: 3){
                    Spacer()
                    Text(refreshTime.replacingOccurrences(of: "-", with: "/"))
                        .font(Font.caption.weight(.regular))
                        .foregroundColor(Color.gray)
                    if loading{
                        ProgressView()
                            .scaleEffect(0.6, anchor: .center)
                            .frame(width: 12, height: 12)
                    }
                    Spacer()
                }
                ScrollView{
                    VStack(alignment: .leading){
                        HStack{
                            Text("친구와 겨루기")
                                .bold()
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            VStack{
                                VStack{
                                    if #available(iOS 15.0, *) {
                                        AsyncImage(
                                            url: URL(string: githubProfilePhotoURL),
                                            content: { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                            },
                                            placeholder: {
                                                ProgressView()
                                            }
                                        )
                                    } else {
                                        let url: URL = URL(string: githubProfilePhotoURL)!
                                        URLImage(url) { image in
                                            image
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(10)
                                                
                                        }
                                    }
                                }
                                .frame(width: 100, height: 100)
                                Text(userName)
                                    .bold()
                                Text("팔로워 \(ContentView().addComma(value: followers))명")
                                Text("팔로우 \(ContentView().addComma(value: following))명")
                                Text("일일 커밋 : " + ContentView().addComma(value: todayCommit) + "개")
                                Text("1년 커밋 : " + ContentView().addComma(value: Int(contributionCount)!) + "개")
                            }
                            Spacer()
                            VStack{
                                VStack{
                                    if #available(iOS 15.0, *) {
                                        AsyncImage(
                                            url: URL(string: githubFriendProfilePhotoURL),
                                            content: { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(10)
                                            },
                                            placeholder: {
                                                ProgressView()
                                            }
                                        )
                                    } else {
                                        let url: URL = URL(string: githubFriendProfilePhotoURL)!
                                        URLImage(url) { image in
                                            image
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(10)
                                                
                                        }
                                    }
                                }
                                .frame(width: 100, height: 100)
                                Text(userFriendName)
                                    .bold()
                                Text("팔로워 \(ContentView().addComma(value: Friendfollowers))명")
                                Text("팔로우 \(ContentView().addComma(value: Friendfollowing))명")
                                Text("일일 커밋 : " + ContentView().addComma(value: todayFriendCommit) + "개")
                                Text("1년 커밋 : " + ContentView().addComma(value: Int(contributionFriendCount)!) + "개")
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.ContentBoxBackground)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }

    }
}
//
//struct FriendView_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendView()
//    }
//}
