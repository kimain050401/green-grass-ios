//
//  ProfileView.swift
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

struct ProfileView: View {
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
                Spacer()
                HStack{
                    Spacer()
                    if flipCard == false{
                        VStack{
                            Spacer()
                            VStack{
                                Button(action: {
                                    selection = 2
                                }, label: {
                                    HStack(spacing: 4){
                                        Text(rankText[rankCount])
                                            .font(Font.title3.weight(.semibold))
                                            .foregroundColor(rankTextColor[rankCount])
                                        Image("rank" + String(rankCount))
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                    }
                                })
                                .padding(.bottom)
                                VStack{
                                    if #available(iOS 15.0, *) {
                                        AsyncImage(
                                            url: URL(string: githubProfilePhotoURL),
                                            content: { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 150, height: 150)
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
                                                .frame(width: 150, height: 150)
                                                .cornerRadius(10)
                                                
                                        }
                                    }
                                }
                                .frame(width: 150, height: 150)
                                .padding(.bottom)
                                Text("github.com/")
                                Text(userName)
                                    .font(Font.title3.weight(.bold))
                                    .padding(.bottom, 30)
                                HStack(spacing: 0){
                                    Image("Logo")
                                        .resizable()
                                        .frame(width: 30, height: 26)
                                        .padding(.trailing, 4)
                                    Text("초")
                                        .foregroundColor(Color(red: 104 / 255, green: 205 / 255, blue: 103 / 255))
                                        .font(Font.title.weight(.bold))
                                        .padding(0)
                                    Text("록")
                                        .foregroundColor(Color(red: 93 / 255, green: 184 / 255, blue: 91 / 255))
                                        .font(Font.title.weight(.bold))
                                        .padding(0)
                                    Text("잔")
                                        .foregroundColor(Color(red: 82 / 255, green: 164 / 255, blue: 80 / 255))
                                        .font(Font.title.weight(.bold))
                                        .padding(0)
                                    Text("디")
                                        .foregroundColor(Color(red: 79 / 255, green: 156 / 255, blue: 77 / 255))
                                        .font(Font.title.weight(.bold))
                                        .padding(0)
                                }
                            }
                            .offset(y: 20)
                            Spacer()
                            Image("UnderGrass")
                                .resizable()
                                .frame(width: 285, height: 68)
                                .offset(y: 15)
                        }
                    } else{
                        VStack{
                            Spacer()
                            VStack{
                                Text("팔로워 \(ContentView().addComma(value: followers))명 · 팔로우 \(ContentView().addComma(value: following))명")
                                Text("GitHub와 함께한 지 " + ContentView().addComma(value: withGithubDay) + "일째")
                                    .padding(.bottom)
                                Text("하루 동안 커밋 " + ContentView().addComma(value: todayCommit) + "개")
                                Text(ContentView().addComma(value: Int(contributionCountDay)!) + "일 동안 커밋 " + ContentView().addComma(value: Int(contributionCount)!) + "개")
                            }
                            .offset(y: 25)
                            Spacer()
                            Image("UnderGrass")
                                .resizable()
                                .frame(width: 285, height: 68)
                                .offset(y: 15)
                        }
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                    }
                    Spacer()
                }
                .frame(width: 285, height: 450)
                .background(Color.ContentBoxBackground)
                .cornerRadius(15)
                .padding(.horizontal)
                .textFieldStyle(.roundedBorder)
                .rotation3DEffect(self.flipCard ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                .animation(.default)
                .onTapGesture {
                    self.flipCard.toggle()
                }
                HStack(spacing: 5){
                    Image(systemName: "info.circle")
                        .font(Font.callout.weight(.regular))
                        .foregroundColor(Color.gray)
                    Text("카드를 터치하면 더 많은 정보를 볼 수 있어요")
                        .font(Font.callout.weight(.regular))
                        .foregroundColor(Color.gray)
                }
                .padding(.top, 4)
                Spacer()
            }
        }

    }
}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
