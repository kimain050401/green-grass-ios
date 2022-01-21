//
//  HomeView.swift
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

struct HomeView: View {
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
                ScrollView() {
                    if timeDifferenceInfo{
                        Button(action: {
                            alertTitle = "커밋 시차 적용 안내"
                            alertBody = "GitHub에서 제공하는 API의 시차로 인해 오전 9시까지 어제의 커밋이 표시됩니다."
                            showingAlert = true
                        }, label: {
                            HStack(spacing: 5){
                                Spacer()
                                Image(systemName: "info.circle")
                                    .foregroundColor(Color.gray)
                                Text("오전 9시까지 어제의 커밋이 표시됨")
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            .padding()
                            .background(Color.ContentBoxBackground)
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .padding(.bottom)
                        })
                    }
                    
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            VStack{
                                if #available(iOS 15.0, *) {
                                    AsyncImage(
                                        url: URL(string: githubProfilePhotoURL),
                                        content: { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 70, height: 70)
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
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(10)
                                            
                                    }
                                }
                            }
                            .frame(width: 70, height: 70)
                            .padding(.trailing, 6)
                            VStack(alignment: .leading, spacing: 0){
                                HStack(spacing: 4){
                                    Text(rankText[rankCount])
                                        .font(Font.subheadline.weight(.semibold))
                                        .foregroundColor(rankTextColor[rankCount])
                                    Image("rank" + String(rankCount))
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                }
                                Text(userName)
                                    .font(Font.title3.weight(.bold))
                                    .padding(.bottom, 6)
                                Text("팔로워 \(ContentView().addComma(value: followers))명 · 팔로우 \(ContentView().addComma(value: following))명")
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.ContentBoxBackground)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .onTapGesture(perform: {
                        selection = 3
                    })
                    
                    VStack{
                        HStack{
                            Text(timeDifference + "의 커밋")
                                .bold()
                            Spacer()
                        }
                        HStack{
                            Text(ContentView().addComma(value: todayCommit) + "개")
                            ProgressBar(value: $progressCommitDayValue).frame(height: 10)
                            Text(ContentView().addComma(value: Int(userGoal)!) + "개")
                        }
                        HStack{
                            Spacer()
                            Button(action: {
                                alertTitle = "커밋이 보이지 않나요?"
                                alertBody = "\n비공개 레포에 커밋하신 경우, 커밋 관련 설정이 되어있지 않다면 커밋 정보를 읽어올 수 없습니다.\n\n이 경우, github.com/" + userName + "에 접속하신 후 잔디 위의 'Contribution settings'를 누르고 'Private contributions'를 체크해주시면 됩니다.\n\n그래도 보이지 않는다면 조금 기다려보시고, 그래도 안된다면 설정 탭의 문의하기를 통해 문의주시기 바랍니다."
                                showingAlert = true
                            }, label: {
                                HStack(spacing: 5){
                                    Image(systemName: "questionmark.circle")
                                        .font(Font.callout.weight(.regular))
                                        .foregroundColor(Color.gray)
                                    Text("커밋이 보이지 않나요?")
                                        .font(Font.callout.weight(.regular))
                                        .foregroundColor(Color.gray)
                                }
                            })
                        }
                    }
                    .padding()
                    .background(Color.ContentBoxBackground)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("1일 1커밋")
                                .bold()
                                .padding(.bottom, 2)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            VStack{
                                HStack(spacing: 0){
                                    Text(ContentView().addComma(value: commitMaintain) + "일")
                                        .foregroundColor(Color(red: 82 / 255, green: 164 / 255, blue: 80 / 255))
                                        .bold()
                                    Text(" 동안 1일 1커밋 연속 달성 중!")
                                        .bold()
                                }
                                Text(commitMaintainCheerText[commitMaintainCheerTextRandomNumber])
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.ContentBoxBackground)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    VStack(alignment: .leading){
                        Text("커밋 통계")
                            .bold()
                            .padding(.bottom, 2)
                        HStack{
                            Spacer()
                            VStack{
                                if loading == true && mainInfoText2 == "GitHub에서 커밋 정보를 읽어오는 중"{
                                    ProgressView()
                                }
                                Text(mainInfoText1.replacingOccurrences(of: "-", with: "/"))
                                Text(mainInfoText2)
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.ContentBoxBackground)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    VStack(alignment: .leading){
                        Text("커밋 그래프")
                            .bold()
                        HStack{
                            VStack{
                                Chart(data: commitCountArr)
                                    .chartStyle(
                                            AreaChartStyle(fill:
                                                LinearGradient(gradient: .init(colors: [Color(red: 54 / 255, green: 109 / 255, blue: 52 / 255), Color(red: 157 / 255, green: 229 / 255, blue: 163 / 255)]), startPoint: .top, endPoint: .bottom)
                                            )
                                        )
                                HStack{
                                    Text(String(contributionDateStart).dropLast(13).replacingOccurrences(of: "-", with: "/"))
                                    Spacer()
                                    Text(String(contributionDateStop).dropLast(13).replacingOccurrences(of: "-", with: "/"))
                                }
                            }
                            VStack{
                                Text(ContentView().addComma(value: commitCountMaxValue))
                                Spacer()
                                Text(ContentView().addComma(value: commitCountMinValue))
                                    .padding(.bottom, 20)
                            }
                        }
                        .frame(height: 200)
                    }
                    .padding()
                    .background(Color.ContentBoxBackground)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .background(Color.Background)
            }
        }
    }
}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
