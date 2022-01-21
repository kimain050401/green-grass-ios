//
//  GradeView.swift
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

struct GradeView: View {
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
                    ScrollViewReader { proxy in
                        VStack{
                            HStack{
                                Text("등급 책정 기간")
                                    .bold()
                                Spacer()
                                Text(mainInfoText1.dropLast(6).replacingOccurrences(of: "-", with: "/"))
                            }
                            .padding()
                            .background(Color.ContentBoxBackground)
                            .cornerRadius(15)
                            .textFieldStyle(.roundedBorder)
                            .padding(.bottom, 4)
                            .padding(.horizontal)
                            VStack{
                                HStack{
                                    Text(rankText[0])
                                        .bold()
                                        .foregroundColor(rankTextColor[0])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("~10 커밋")
                                    }
                                }
                                .id(0)
                                .padding()
                                .background(rankBackgroundColor[0])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 4)
                                .padding(.horizontal)
                                HStack{
                                    Text(rankText[1])
                                        .bold()
                                        .foregroundColor(rankTextColor[1])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("11~99 커밋")
                                    }
                                }
                                .id(1)
                                .padding()
                                .background(rankBackgroundColor[1])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 4)
                                .padding(.horizontal)
                                HStack{
                                    Text(rankText[2])
                                        .bold()
                                        .foregroundColor(rankTextColor[2])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("100~299 커밋")
                                    }
                                }
                                .id(2)
                                .padding()
                                .background(rankBackgroundColor[2])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 4)
                                .padding(.horizontal)
                                HStack{
                                    Text(rankText[3])
                                        .bold()
                                        .foregroundColor(rankTextColor[3])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("300~499 커밋")
                                    }
                                }
                                .id(3)
                                .padding()
                                .background(rankBackgroundColor[3])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 4)
                                .padding(.horizontal)
                                HStack{
                                    Text(rankText[4])
                                        .bold()
                                        .foregroundColor(rankTextColor[4])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("500~999 커밋")
                                    }
                                }
                                .id(4)
                                .padding()
                                .background(rankBackgroundColor[4])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 4)
                                .padding(.horizontal)
                                HStack{
                                    Text(rankText[5])
                                        .bold()
                                        .foregroundColor(rankTextColor[5])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("1,000~2,999 커밋")
                                    }
                                }
                                .id(5)
                                .padding()
                                .background(rankBackgroundColor[5])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 4)
                                .padding(.horizontal)
                                HStack{
                                    Text(rankText[6])
                                        .bold()
                                        .foregroundColor(rankTextColor[6])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("3,000~4,999 커밋")
                                    }
                                }
                                .id(6)
                                .padding()
                                .background(rankBackgroundColor[6])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 4)
                                .padding(.horizontal)
                                HStack{
                                    Text(rankText[7])
                                        .bold()
                                        .foregroundColor(rankTextColor[7])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("5,000~9,999 커밋")
                                    }
                                }
                                .id(7)
                                .padding()
                                .background(rankBackgroundColor[7])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 4)
                                .padding(.horizontal)
                                HStack{
                                    Text(rankText[8])
                                        .bold()
                                        .foregroundColor(rankTextColor[8])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("10,000~29,999 커밋")
                                    }
                                }
                                .id(8)
                                .padding()
                                .background(rankBackgroundColor[8])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom, 4)
                                .padding(.horizontal)
                                HStack{
                                    Text(rankText[9])
                                        .bold()
                                        .foregroundColor(rankTextColor[9])
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("등급 책정 기간 동안")
                                            .foregroundColor(Color.gray)
                                            .font(Font.caption.weight(.regular))
                                        Text("30,000~ 커밋")
                                    }
                                }
                                .id(9)
                                .padding()
                                .background(rankBackgroundColor[9])
                                .cornerRadius(15)
                                .textFieldStyle(.roundedBorder)
                                .padding(.bottom)
                                .padding(.horizontal)
                            }
                        }
                        .onChange(of: position) { value in
                            withAnimation {
                                proxy.scrollTo(value, anchor: .center)
                            }
                        }
                    }
                }
            }
        }

    }
}
//
//struct GradeView_Previews: PreviewProvider {
//    static var previews: some View {
//        GradeView()
//    }
//}
