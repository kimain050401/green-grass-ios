//
//  ContentView.swift
//  Shared
//
//  Created by 김아인 on 2022/01/16.
//

import SwiftUI
import Alamofire
import Charts
import URLImage
import SafariServices
import UserNotifications

// Assets에서 정의한 색상 코드를 편리하게 사용하게 해주는 익스텐션
extension Color{
    static let ContentBoxBackground = Color("ContentBoxBackground")
    static let Background = Color("Background")
    static let DarkmodeText = Color("DarkmodeText")
    static let DarkmodeKeyboard = Color("DarkmodeKeyboard")
    static let DarkmodeBackground = Color("DarkmodeBackground")
    static let Footer = Color("Footer")
}

// 메인 View의 일일 커밋 목표 현황을 보여줌
struct ProgressBar: View {
    @Binding var value: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(red: 104 / 255, green: 205 / 255, blue: 103 / 255))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

struct ContentView: View {
    // 사용되지 않는 변수들이 있어 정리가 필요함
    // 조만간 리-코딩할 예정
    @State var selection: Int = 0
    @State var userName: String = String(UserDefaults.standard.string(forKey: "userName") ?? "Not Registered")
    @State var userFriendName: String = String(UserDefaults.standard.string(forKey: "userFriendName") ?? "Not Registered")
    @State var userUserName: String = "Not Registered"
    @State var userUserNameSearch: String = ""
    @State var userGoal: String = String(UserDefaults.standard.string(forKey: "userGoal") ?? "10")
    @State var userGoalInput: String = String(UserDefaults.standard.string(forKey: "userGoal") ?? "10")
    @State var contributionDateStart: String = "0000-00-00-------------"
    @State var contributionDateStop: String = "0000-00-00-------------"
    @State var contributionUserDateStart: String = "0000-00-00-------------"
    @State var contributionUserDateStop: String = "0000-00-00-------------"
    @State var contributionCount: String = "0"
    @State var contributionCountDay: String = "0"
    @State var contributionUserCountDay: String = "0"
    @State var contributionFriendCount: String = "0"
    @State var contributionUserCount: String = "0"
    @State var githubProfilePhotoURL: String = String(UserDefaults.standard.string(forKey: "githubProfilePhotoURL") ?? "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png")
    @State var githubFriendProfilePhotoURL: String = String(UserDefaults.standard.string(forKey: "githubFriendProfilePhotoURL") ?? "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png")
    @State var githubUserProfilePhotoURL: String = "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
    @State var contents: String = ""
    @State var refreshTime: String = "GitHub에서 커밋 정보를 읽어오는 중"
    @State var timeDifference: String = "오늘"
    @State var timeDifferenceInfo: Bool = false
    @State var mainInfoText1: String = ""
    @State var mainInfoText2: String = "GitHub에서 커밋 정보를 읽어오는 중"
    @State var commitCountArr : [Double] = [0.1, 0.1]
    @State var commitUserCountArr : [Double] = [0.1, 0.1]
    @State var commitCountMaxValue: Int = 0
    @State var commitCountMinValue: Int = 0
    @State var commitUserCountMaxValue: Int = 0
    @State var commitUserCountMinValue: Int = 0
    @State var progressValue: Float = 0.0
    @State var todayCommit: Int = 0
    @State var todayFriendCommit: Int = 0
    @State var todayUserCommit: Int = 0
    @State var withGithubDay: Int = 0
    @State var withGithubFriendDay: Int = 0
    @State var withGithubUserDay: Int = 0
    @State var followers: Int = Int(UserDefaults.standard.integer(forKey: "followers") ?? 0)
    @State var following: Int = Int(UserDefaults.standard.integer(forKey: "following") ?? 0)
    @State var Friendfollowers: Int = Int(UserDefaults.standard.integer(forKey: "Friendfollowers") ?? 0)
    @State var Friendfollowing: Int = Int(UserDefaults.standard.integer(forKey: "Friendfollowing") ?? 0)
    @State var Userfollowers: Int = 0
    @State var Userfollowing: Int = 0
    @State var githubStartDate: String = String(UserDefaults.standard.string(forKey: "githubStartDate") ?? "2007-10-19----------")
    @State var githubFriendStartDate: String = String(UserDefaults.standard.string(forKey: "githubFriendStartDate") ?? "2007-10-19----------")
    @State var githubNameEdit = false
    @State var githubGoalEdit = false
    @State var githubFriendNameEdit = false
    @State var showingPopover = false
    @State var showSaveButton1 = false
    @State var showSaveButton2 = false
    @State var showSaveButton3 = false
    @State var showSaveButton4 = false
    @State var showSaveButton5 = false
    @State var showingAlert = false
    @State var alertTitle: String = ""
    @State var alertBody: String = ""
    @State var internetConnected = false
    @State var selectPushAlertTimeHour: String = String(UserDefaults.standard.string(forKey: "selectPushAlertTimeHour") ?? "23")
    @State var selectPushAlertTimeMinute: String = String(UserDefaults.standard.string(forKey: "selectPushAlertTimeMinute") ?? "00")
    @State var flipCard = false
    @State var commitAlert: Bool = Bool(UserDefaults.standard.bool(forKey: "commitAlert") ?? false)
    @State var showSafari = false
    @State var urlString = "https://green-grass.tech/support"
    @State var userToken: String = String(UserDefaults.standard.string(forKey: "userToken") ?? "")
    @State var lastGetApiTime = String(UserDefaults.standard.string(forKey: "lastGetApiTime") ?? "0000-00-00")
    @State var rankCount: Int = 10
    @State var rankText : [String] = ["Unranked", "Iron", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Grand Master", "Challenger", "Loading"]
    @State var rankTextColor : [Color] = [Color.gray, Color(red: 91 / 255, green: 84 / 255, blue: 84 / 255), Color(red: 89 / 255, green: 55 / 255, blue: 41 / 255), Color(red: 157 / 255, green: 157 / 255, blue: 159 / 255), Color(red: 255 / 255, green: 220 / 255, blue: 74 / 255), Color(red: 70 / 255, green: 106 / 255, blue: 102 / 255), Color(red: 151 / 255, green: 160 / 255, blue: 236 / 255), Color(red: 174 / 255, green: 133 / 255, blue: 208 / 255), Color(red: 255 / 255, green: 77 / 255, blue: 77 / 255), Color.gray, Color.gray]
    @State var rankBackgroundColor : [Color] = [Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground]
    @State var loading: Bool = true
    @State var position = 0
    @Environment(\.scenePhase) var scenePhase
    @State var randomNumber = Int.random(in: 1...2)
    @State var pushAlertShow: Bool = Bool(UserDefaults.standard.bool(forKey: "pushAlertShow") ?? false)
    
    // PUSH 알림을 설정해주는 함수
    func setNotification(){
        let manager = LocalNotificationManager()
        manager.addNotification(title: randomNumber == 1 ? "오늘 1일 1커밋 하셨나요?" : "오늘 1일 1커밋, 까먹지 마세요!", body: "알림 수신거부 : 초록잔디 > 설정 탭 > 1일 1커밋 알림")
        manager.schedule(isTest: false)
        alertTitle = "1일 1커밋 알림이 설정됨"
        alertBody = "\n1일 1커밋 알림이 설정되었어요! 매일마다 설정하신 시간에 알림을 보내드릴게요!\n\n설정하신 시간에 알림이 오지 않는다면 iPhone/iPad 설정 앱 > 초록잔디 > 알림 > 알림 허용을 해주세요.\n\n그 후 다시 1일 1커밋 알림을 껐다 켜주세요.\n\n그래도 안된다면 설정 탭의 문의하기를 통해 문의주시기 바랍니다."
        showingAlert = true
    }
    
    var body: some View {
        ZStack{
            Color.Background
                .ignoresSafeArea()
            VStack(spacing: 0){
                HStack(spacing: 0){
                    Image("Logo")
                        .resizable()
                        .frame(width: 30, height: 26)
                        .padding(.trailing, 6)
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
                    Spacer()
                    if selection != 4{
                        Button(action: {
                            hideKeyboard()
                            if(internetTest() == true){
                                getGithubContributions(isAll: false)
                            }
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(Color.gray)
                                .font(Font.title.weight(.semibold))
                        })
                    } else{
                        Button(action: {
                            hideKeyboard()
                            if(internetTest() == true){
                                getGithubContributions(isAll: false)
                            }
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .disabled(true)
                                .foregroundColor(Color.Background)
                                .font(Font.title.weight(.semibold))
                        })
                    }
                }
                .padding(.bottom, 10)
                .padding(.top, 6)
                .padding(.horizontal, 20)
                .background(Color.Background)
                TabView(selection: $selection){
                    
                    HomeView(selection: $selection, userName: $userName, userFriendName: $userFriendName, userUserName: $userUserName, userUserNameSearch: $userUserNameSearch, userGoal: $userGoal, userGoalInput: $userGoalInput, contributionDateStart: $contributionDateStart, contributionDateStop: $contributionDateStop, contributionUserDateStart: $contributionUserDateStart, contributionUserDateStop: $contributionUserDateStop, contributionCount: $contributionCount, contributionCountDay: $contributionCountDay, contributionUserCountDay: $contributionUserCountDay, contributionFriendCount: $contributionFriendCount, contributionUserCount: $contributionUserCount, githubProfilePhotoURL: $githubProfilePhotoURL, githubFriendProfilePhotoURL: $githubFriendProfilePhotoURL, githubUserProfilePhotoURL: $githubUserProfilePhotoURL, contents: $contents, refreshTime: $refreshTime, timeDifference: $timeDifference, timeDifferenceInfo: $timeDifferenceInfo, mainInfoText1: $mainInfoText1, mainInfoText2: $mainInfoText2, commitCountArr: $commitCountArr, commitUserCountArr: $commitUserCountArr, commitCountMaxValue: $commitCountMaxValue, commitCountMinValue: $commitCountMinValue, commitUserCountMaxValue: $commitUserCountMaxValue, commitUserCountMinValue: $commitUserCountMinValue, progressValue: $progressValue, todayCommit: $todayCommit, todayFriendCommit: $todayFriendCommit, todayUserCommit: $todayUserCommit, withGithubDay: $withGithubDay, withGithubFriendDay: $withGithubFriendDay, withGithubUserDay: $withGithubUserDay, followers: $followers, following: $following, Friendfollowers: $Friendfollowers, Friendfollowing: $Friendfollowing, Userfollowers: $Userfollowers, Userfollowing: $Userfollowing, githubStartDate: $githubStartDate, githubFriendStartDate: $githubFriendStartDate, githubNameEdit: $githubNameEdit, githubGoalEdit: $githubGoalEdit, githubFriendNameEdit: $githubFriendNameEdit, showingPopover: $showingPopover, showSaveButton1: $showSaveButton1, showSaveButton2: $showSaveButton2, showSaveButton3: $showSaveButton3, showSaveButton4: $showSaveButton4, showSaveButton5: $showSaveButton5, showingAlert: $showingAlert, alertTitle: $alertTitle, alertBody: $alertBody, internetConnected: $internetConnected, selectPushAlertTimeHour: $selectPushAlertTimeHour, selectPushAlertTimeMinute: $selectPushAlertTimeMinute, flipCard: $flipCard, commitAlert: $commitAlert, showSafari: $showSafari, urlString: $urlString, userToken: $userToken, lastGetApiTime: $lastGetApiTime, rankCount: $rankCount, rankText: $rankText, rankTextColor: $rankTextColor, rankBackgroundColor: $rankBackgroundColor, loading: $loading, position: $position, randomNumber: $randomNumber, pushAlertShow: $pushAlertShow)
                        .tabItem {
                            Image(systemName: "house")
                            Text("홈")
                        }.tag(0)
                    
                    FriendView(selection: $selection, userName: $userName, userFriendName: $userFriendName, userUserName: $userUserName, userUserNameSearch: $userUserNameSearch, userGoal: $userGoal, userGoalInput: $userGoalInput, contributionDateStart: $contributionDateStart, contributionDateStop: $contributionDateStop, contributionUserDateStart: $contributionUserDateStart, contributionUserDateStop: $contributionUserDateStop, contributionCount: $contributionCount, contributionCountDay: $contributionCountDay, contributionUserCountDay: $contributionUserCountDay, contributionFriendCount: $contributionFriendCount, contributionUserCount: $contributionUserCount, githubProfilePhotoURL: $githubProfilePhotoURL, githubFriendProfilePhotoURL: $githubFriendProfilePhotoURL, githubUserProfilePhotoURL: $githubUserProfilePhotoURL, contents: $contents, refreshTime: $refreshTime, timeDifference: $timeDifference, timeDifferenceInfo: $timeDifferenceInfo, mainInfoText1: $mainInfoText1, mainInfoText2: $mainInfoText2, commitCountArr: $commitCountArr, commitUserCountArr: $commitUserCountArr, commitCountMaxValue: $commitCountMaxValue, commitCountMinValue: $commitCountMinValue, commitUserCountMaxValue: $commitUserCountMaxValue, commitUserCountMinValue: $commitUserCountMinValue, progressValue: $progressValue, todayCommit: $todayCommit, todayFriendCommit: $todayFriendCommit, todayUserCommit: $todayUserCommit, withGithubDay: $withGithubDay, withGithubFriendDay: $withGithubFriendDay, withGithubUserDay: $withGithubUserDay, followers: $followers, following: $following, Friendfollowers: $Friendfollowers, Friendfollowing: $Friendfollowing, Userfollowers: $Userfollowers, Userfollowing: $Userfollowing, githubStartDate: $githubStartDate, githubFriendStartDate: $githubFriendStartDate, githubNameEdit: $githubNameEdit, githubGoalEdit: $githubGoalEdit, githubFriendNameEdit: $githubFriendNameEdit, showingPopover: $showingPopover, showSaveButton1: $showSaveButton1, showSaveButton2: $showSaveButton2, showSaveButton3: $showSaveButton3, showSaveButton4: $showSaveButton4, showSaveButton5: $showSaveButton5, showingAlert: $showingAlert, alertTitle: $alertTitle, alertBody: $alertBody, internetConnected: $internetConnected, selectPushAlertTimeHour: $selectPushAlertTimeHour, selectPushAlertTimeMinute: $selectPushAlertTimeMinute, flipCard: $flipCard, commitAlert: $commitAlert, showSafari: $showSafari, urlString: $urlString, userToken: $userToken, lastGetApiTime: $lastGetApiTime, rankCount: $rankCount, rankText: $rankText, rankTextColor: $rankTextColor, rankBackgroundColor: $rankBackgroundColor, loading: $loading, position: $position, randomNumber: $randomNumber, pushAlertShow: $pushAlertShow)
                        .tabItem {
                            Image(systemName: "person.2")
                            Text("친구")
                        }.tag(1)
                    
                    GradeView(selection: $selection, userName: $userName, userFriendName: $userFriendName, userUserName: $userUserName, userUserNameSearch: $userUserNameSearch, userGoal: $userGoal, userGoalInput: $userGoalInput, contributionDateStart: $contributionDateStart, contributionDateStop: $contributionDateStop, contributionUserDateStart: $contributionUserDateStart, contributionUserDateStop: $contributionUserDateStop, contributionCount: $contributionCount, contributionCountDay: $contributionCountDay, contributionUserCountDay: $contributionUserCountDay, contributionFriendCount: $contributionFriendCount, contributionUserCount: $contributionUserCount, githubProfilePhotoURL: $githubProfilePhotoURL, githubFriendProfilePhotoURL: $githubFriendProfilePhotoURL, githubUserProfilePhotoURL: $githubUserProfilePhotoURL, contents: $contents, refreshTime: $refreshTime, timeDifference: $timeDifference, timeDifferenceInfo: $timeDifferenceInfo, mainInfoText1: $mainInfoText1, mainInfoText2: $mainInfoText2, commitCountArr: $commitCountArr, commitUserCountArr: $commitUserCountArr, commitCountMaxValue: $commitCountMaxValue, commitCountMinValue: $commitCountMinValue, commitUserCountMaxValue: $commitUserCountMaxValue, commitUserCountMinValue: $commitUserCountMinValue, progressValue: $progressValue, todayCommit: $todayCommit, todayFriendCommit: $todayFriendCommit, todayUserCommit: $todayUserCommit, withGithubDay: $withGithubDay, withGithubFriendDay: $withGithubFriendDay, withGithubUserDay: $withGithubUserDay, followers: $followers, following: $following, Friendfollowers: $Friendfollowers, Friendfollowing: $Friendfollowing, Userfollowers: $Userfollowers, Userfollowing: $Userfollowing, githubStartDate: $githubStartDate, githubFriendStartDate: $githubFriendStartDate, githubNameEdit: $githubNameEdit, githubGoalEdit: $githubGoalEdit, githubFriendNameEdit: $githubFriendNameEdit, showingPopover: $showingPopover, showSaveButton1: $showSaveButton1, showSaveButton2: $showSaveButton2, showSaveButton3: $showSaveButton3, showSaveButton4: $showSaveButton4, showSaveButton5: $showSaveButton5, showingAlert: $showingAlert, alertTitle: $alertTitle, alertBody: $alertBody, internetConnected: $internetConnected, selectPushAlertTimeHour: $selectPushAlertTimeHour, selectPushAlertTimeMinute: $selectPushAlertTimeMinute, flipCard: $flipCard, commitAlert: $commitAlert, showSafari: $showSafari, urlString: $urlString, userToken: $userToken, lastGetApiTime: $lastGetApiTime, rankCount: $rankCount, rankText: $rankText, rankTextColor: $rankTextColor, rankBackgroundColor: $rankBackgroundColor, loading: $loading, position: $position, randomNumber: $randomNumber, pushAlertShow: $pushAlertShow)
                        .tabItem {
                            Image(systemName: "crown")
                            Text("등급")
                        }.tag(2)
                    
                    ProfileView(selection: $selection, userName: $userName, userFriendName: $userFriendName, userUserName: $userUserName, userUserNameSearch: $userUserNameSearch, userGoal: $userGoal, userGoalInput: $userGoalInput, contributionDateStart: $contributionDateStart, contributionDateStop: $contributionDateStop, contributionUserDateStart: $contributionUserDateStart, contributionUserDateStop: $contributionUserDateStop, contributionCount: $contributionCount, contributionCountDay: $contributionCountDay, contributionUserCountDay: $contributionUserCountDay, contributionFriendCount: $contributionFriendCount, contributionUserCount: $contributionUserCount, githubProfilePhotoURL: $githubProfilePhotoURL, githubFriendProfilePhotoURL: $githubFriendProfilePhotoURL, githubUserProfilePhotoURL: $githubUserProfilePhotoURL, contents: $contents, refreshTime: $refreshTime, timeDifference: $timeDifference, timeDifferenceInfo: $timeDifferenceInfo, mainInfoText1: $mainInfoText1, mainInfoText2: $mainInfoText2, commitCountArr: $commitCountArr, commitUserCountArr: $commitUserCountArr, commitCountMaxValue: $commitCountMaxValue, commitCountMinValue: $commitCountMinValue, commitUserCountMaxValue: $commitUserCountMaxValue, commitUserCountMinValue: $commitUserCountMinValue, progressValue: $progressValue, todayCommit: $todayCommit, todayFriendCommit: $todayFriendCommit, todayUserCommit: $todayUserCommit, withGithubDay: $withGithubDay, withGithubFriendDay: $withGithubFriendDay, withGithubUserDay: $withGithubUserDay, followers: $followers, following: $following, Friendfollowers: $Friendfollowers, Friendfollowing: $Friendfollowing, Userfollowers: $Userfollowers, Userfollowing: $Userfollowing, githubStartDate: $githubStartDate, githubFriendStartDate: $githubFriendStartDate, githubNameEdit: $githubNameEdit, githubGoalEdit: $githubGoalEdit, githubFriendNameEdit: $githubFriendNameEdit, showingPopover: $showingPopover, showSaveButton1: $showSaveButton1, showSaveButton2: $showSaveButton2, showSaveButton3: $showSaveButton3, showSaveButton4: $showSaveButton4, showSaveButton5: $showSaveButton5, showingAlert: $showingAlert, alertTitle: $alertTitle, alertBody: $alertBody, internetConnected: $internetConnected, selectPushAlertTimeHour: $selectPushAlertTimeHour, selectPushAlertTimeMinute: $selectPushAlertTimeMinute, flipCard: $flipCard, commitAlert: $commitAlert, showSafari: $showSafari, urlString: $urlString, userToken: $userToken, lastGetApiTime: $lastGetApiTime, rankCount: $rankCount, rankText: $rankText, rankTextColor: $rankTextColor, rankBackgroundColor: $rankBackgroundColor, loading: $loading, position: $position, randomNumber: $randomNumber, pushAlertShow: $pushAlertShow)
                        .tabItem {
                            Image(systemName: "person.crop.square")
                            Text("프로필")
                        }.tag(3)
                    
                    SettingView(selection: $selection, userName: $userName, userFriendName: $userFriendName, userUserName: $userUserName, userUserNameSearch: $userUserNameSearch, userGoal: $userGoal, userGoalInput: $userGoalInput, contributionDateStart: $contributionDateStart, contributionDateStop: $contributionDateStop, contributionUserDateStart: $contributionUserDateStart, contributionUserDateStop: $contributionUserDateStop, contributionCount: $contributionCount, contributionCountDay: $contributionCountDay, contributionUserCountDay: $contributionUserCountDay, contributionFriendCount: $contributionFriendCount, contributionUserCount: $contributionUserCount, githubProfilePhotoURL: $githubProfilePhotoURL, githubFriendProfilePhotoURL: $githubFriendProfilePhotoURL, githubUserProfilePhotoURL: $githubUserProfilePhotoURL, contents: $contents, refreshTime: $refreshTime, timeDifference: $timeDifference, timeDifferenceInfo: $timeDifferenceInfo, mainInfoText1: $mainInfoText1, mainInfoText2: $mainInfoText2, commitCountArr: $commitCountArr, commitUserCountArr: $commitUserCountArr, commitCountMaxValue: $commitCountMaxValue, commitCountMinValue: $commitCountMinValue, commitUserCountMaxValue: $commitUserCountMaxValue, commitUserCountMinValue: $commitUserCountMinValue, progressValue: $progressValue, todayCommit: $todayCommit, todayFriendCommit: $todayFriendCommit, todayUserCommit: $todayUserCommit, withGithubDay: $withGithubDay, withGithubFriendDay: $withGithubFriendDay, withGithubUserDay: $withGithubUserDay, followers: $followers, following: $following, Friendfollowers: $Friendfollowers, Friendfollowing: $Friendfollowing, Userfollowers: $Userfollowers, Userfollowing: $Userfollowing, githubStartDate: $githubStartDate, githubFriendStartDate: $githubFriendStartDate, githubNameEdit: $githubNameEdit, githubGoalEdit: $githubGoalEdit, githubFriendNameEdit: $githubFriendNameEdit, showingPopover: $showingPopover, showSaveButton1: $showSaveButton1, showSaveButton2: $showSaveButton2, showSaveButton3: $showSaveButton3, showSaveButton4: $showSaveButton4, showSaveButton5: $showSaveButton5, showingAlert: $showingAlert, alertTitle: $alertTitle, alertBody: $alertBody, internetConnected: $internetConnected, selectPushAlertTimeHour: $selectPushAlertTimeHour, selectPushAlertTimeMinute: $selectPushAlertTimeMinute, flipCard: $flipCard, commitAlert: $commitAlert, showSafari: $showSafari, urlString: $urlString, userToken: $userToken, lastGetApiTime: $lastGetApiTime, rankCount: $rankCount, rankText: $rankText, rankTextColor: $rankTextColor, rankBackgroundColor: $rankBackgroundColor, loading: $loading, position: $position, randomNumber: $randomNumber, pushAlertShow: $pushAlertShow)
                        .tabItem {
                            Image(systemName: "gearshape")
                            Text("설정")
                        }.tag(4)
                }
                .onChange(of: selection, perform: { _ in
                    if(internetTest() == true){
                        if(selection == 0 || selection == 1 || selection == 3){
                            getGithubContributions(isAll: false)
                            position = 0
                        }
                        if(selection == 2){
                            getGithubContributions(isAll: false)
                            let seconds = 0.1
                            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                print("OK")
                                position = rankCount
                            }
                        }
                    }
                })
                .onChange(of: commitAlert, perform: { _ in
                    if commitAlert == false{
                        LocalNotificationManager().removeNotifications()
                    } else{
                        setNotification()
                    }
                    UserDefaults.standard.set(commitAlert, forKey: "commitAlert")
                })
                .onChange(of: scenePhase) { (phase) in
                    if(internetTest() == true){
                        switch phase {
                        case .active: getGithubContributions(isAll: false)
                        case .background: print("ScenePhase: background")
                        case .inactive: print("ScenePhase: inactive")
                        @unknown default: print("ScenePhase: unexpected state")
                        }
                    }
                }
                .accentColor(Color(red: 82 / 255, green: 164 / 255, blue: 80 / 255))
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertBody), dismissButton: .default(Text("확인").foregroundColor(Color(red: 82 / 255, green: 164 / 255, blue: 80 / 255))))
            }
            .sheet(isPresented: $showSafari) {
                SafariView(url:URL(string: urlString)!)
                    .ignoresSafeArea()
            }
        }
    }
    
    // 인터넷 연결을 확인하는 함수
    // 하지만 현재는 다른 요상한 방법을 사용 중이라 무조건 true를 리턴하도록 해두었음
    // 추후 제대로된 인터넷 연결을 확인하는 함수를 만들 것
    func internetTest() -> Bool{
        return true
    }
    
    // 세자리마다 콤마를 붙혀서 리턴해주는 함수
    func addComma(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))!
        return result
    }
    
    // 공유 버튼을 위한 함수
    // 하지만 iPad에서는 작동하지 않는 오류가 생겨 현제 사용하지 않고 있음
    func shareButton() {
        guard let urlShare = URL(string: "https://blog.kimain.me") else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    // GitHub로부터 정보를 받아오는 함수
    // isAll이 true면 유저 정보를 포함하여 받아옴
    // isAll이 flase면 유저 정보를 포함하지 않고 받아옴
    // 현재 매우 비효율적이고 코드가 더러우므로 곧 리-코딩할 예정
    func getGithubContributions(isAll: Bool){
        loading = true
        if String(UserDefaults.standard.string(forKey: "firstOpen") ?? "") == ""{
            alertTitle = "처음 앱을 켜셨군요! 반갑습니다!"
            alertBody = "\n앱을 사용하기 전에 먼저 내 GitHub 아이디를 등록해야 해요.\n\n이 알림 밑에 있는 설정 화면에서 내 GitHub 아이디를 등록해주세요!"
            showingAlert = true
            selection = 4
            UserDefaults.standard.set("ok", forKey: "firstOpen")
        } else if(userName == "Not Registered"){
            selection = 4
            alertTitle = "내 GitHub 아이디가 등록되지 않았거나 존재하지 않는 아이디임"
            alertBody = "\n내 GitHub 아이디가 등록되지 않았거나 존재하지 않는 아이디입니다.\n\n앱을 사용하기 전에 먼저 내 GitHub 아이디를 등록해야 해요.\n\n이 알림 밑에 있는 설정 화면에서 내 GitHub 아이디를 등록해주세요!"
            showingAlert = true
        }
        refreshTime = "GitHub에서 커밋 정보를 읽어오는 중"
        userName = String(UserDefaults.standard.string(forKey: "userName") ?? "Not Registered")
        userFriendName = String(UserDefaults.standard.string(forKey: "userFriendName") ?? "Not Registered")
        userGoal = String(UserDefaults.standard.string(forKey: "userGoal") ?? "10")
        var formatter_time = DateFormatter()
        formatter_time.dateFormat = "yyyy-MM-dd"
        if isAll == true || formatter_time.string(from: Date()) != lastGetApiTime{
            getGithubInfos()
            getFriendGithubInfos()
        }
        getGithubFriendContributions()
        contents = ""
        commitCountArr = []
        let URL = "https://github.com/users/" + userName.replacingOccurrences(of: " ", with: "") + "/contributions"
        let alamo = AF.request(URL, method: .get).validate(statusCode: 200..<300)
        alamo.responseString(){ response in
            switch response.result{
            case .success(let value):
                let non_filtered_arr = value.components(separatedBy: "\n")
                var filtered_arr : [String] = []
                var non_filtered_commitCountArr : [Int] = []
                for i in 0..<non_filtered_arr.count {
                    if(non_filtered_arr[i].contains("data-from")){
                        let contributionDateStart_non_filtered_arr = non_filtered_arr[i].components(separatedBy: "=")
                        var temp_cutting_text = contributionDateStart_non_filtered_arr[1]
                        temp_cutting_text = String(temp_cutting_text.dropLast(1))
                        temp_cutting_text = String(temp_cutting_text.dropFirst(1))
                        contributionDateStart = temp_cutting_text
                    }
                    else if(non_filtered_arr[i].contains("data-to")){
                        let contributionDateStart_non_filtered_arr = non_filtered_arr[i].components(separatedBy: "=")
                        var temp_cutting_text = contributionDateStart_non_filtered_arr[1]
                        temp_cutting_text = String(temp_cutting_text.dropLast(1))
                        temp_cutting_text = String(temp_cutting_text.dropFirst(1))
                        contributionDateStop = temp_cutting_text
                    }
                    else if(non_filtered_arr[i].contains("data-date")){
                        filtered_arr.append(non_filtered_arr[i])
                    }
                }
                print(contributionDateStart.dropLast(19))
                print(contributionDateStop.dropLast(19))
                var commitCount = 0
                for i in 0..<filtered_arr.count {
                    non_filtered_commitCountArr.append(Int(filtered_arr[i].components(separatedBy: "=")[8].dropLast(11).dropFirst(1))!)
                    contents = contents + filtered_arr[i].components(separatedBy: "=")[9].dropLast(12).dropFirst(1) + " : "
                    contents = contents + filtered_arr[i].components(separatedBy: "=")[8].dropLast(11).dropFirst(1) + "\n"
                    commitCount = commitCount + Int(filtered_arr[i].components(separatedBy: "=")[8].dropLast(11).dropFirst(1))!
                }
                commitCountMaxValue = non_filtered_commitCountArr.max()!
                commitCountMinValue = non_filtered_commitCountArr.min()!
                for i in 0..<non_filtered_commitCountArr.count {
                    commitCountArr.append(Double(non_filtered_commitCountArr[i]) / Double(non_filtered_commitCountArr.max()!))
                }
                contributionCount = String(filtered_arr.count)
                print(filtered_arr[0].components(separatedBy: "=")[8].dropLast(11).dropFirst(1))
                print(filtered_arr[0].components(separatedBy: "=")[9].dropLast(12).dropFirst(1))
                print(commitCountArr)
                print(commitCountArr.count)
                mainInfoText1 = contributionDateStart.dropLast(13) + " ~ " + contributionDateStop.dropLast(13) + " (UTC)"
                mainInfoText2 = addComma(value: Int(contributionCount)!) + "일 동안의 " + addComma(value: commitCount) + "개의 커밋을 찾음"
                contributionCountDay = contributionCount
                contributionCount = String(commitCount)
                progressValue = Float(Float(non_filtered_commitCountArr[non_filtered_commitCountArr.count - 1]) / Float(userGoal)!)
                todayCommit = non_filtered_commitCountArr[non_filtered_commitCountArr.count - 1]
                let calendar = Calendar.current
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                var daysCount:Int = 0
                func calculateDays() {
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let startDate = dateFormatter.date(from: String(githubStartDate.dropLast(10)))
                    daysCount = days(from: startDate!)
                    let hundred = calendar.date(byAdding: .day, value: 100, to: startDate!)
                    print(">>>!!!@@@ " + String(daysCount))
                }
                func days(from date: Date) -> Int {
                    return calendar.dateComponents([.day], from: date, to: currentDate).day! + 1
                }
                calculateDays()
                print(">>> " + String(daysCount))
                withGithubDay = daysCount
                var temp_formatter_time = DateFormatter()
                temp_formatter_time.dateFormat = "yyyy-MM-dd"
                let today = temp_formatter_time.string(from: Date())
                if contributionDateStop.dropLast(13) != today{
                    timeDifference = "어제"
                    timeDifferenceInfo = true
                } else{
                    timeDifference = "오늘"
                    timeDifferenceInfo = false
                }
                // Case문으로 변경할 예정
                if Int(contributionCount)! <= 10{
                    rankCount = 0
                } else if Int(contributionCount)! <= 99{
                    rankCount = 1
                } else if Int(contributionCount)! <= 299{
                    rankCount = 2
                } else if Int(contributionCount)! <= 499{
                    rankCount = 3
                } else if Int(contributionCount)! <= 999{
                    rankCount = 4
                } else if Int(contributionCount)! <= 2999{
                    rankCount = 5
                } else if Int(contributionCount)! <= 4999{
                    rankCount = 6
                } else if Int(contributionCount)! <= 9999{
                    rankCount = 7
                } else if Int(contributionCount)! <= 29999{
                    rankCount = 8
                } else{
                    rankCount = 9
                }
                rankBackgroundColor = [Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground, Color.ContentBoxBackground]
                rankBackgroundColor[rankCount] = Color(red: 157 / 255, green: 229 / 255, blue: 163 / 255)
                var formatter_time = DateFormatter()
                formatter_time.dateFormat = "yyyy-MM-dd HH:mm:ss"
                refreshTime = formatter_time.string(from: Date()) + "에 커밋 정보가 업데이트됨"
                loading = false
                if isAll == true{
                    alertTitle = "프로필 정보 새로고침됨"
                    alertBody = "프로필 정보(프사, 팔로워, 팔로잉)가 새로고침되어 프로필 정보가 업데이트되었습니다."
                    showingAlert = true
                }
            case .failure(let error):
                print("❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥\(error)")
                if(error.responseCode == nil){
                    print("❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥❤️‍🔥\(error.responseCode)")
                    refreshTime = "인터넷 연결이 원활하지 않음"
                    mainInfoText1 = ""
                    mainInfoText2 = "인터넷 연결이 원활하지 않음"
                    loading = false
                    alertTitle = "서버와의 연결이 원활하지 않음"
                    alertBody = "서버와의 연결이 원활하지 않습니다. 인터넷 연결을 확인해주세요."
                    showingAlert = true
                }
                else{
                    print("error: \(String(describing: error.errorDescription))")
                    print("1111111111111111111111111111111")
                    print(userName)
                    print(userFriendName)
                    print(userGoal)
                    userName = String(UserDefaults.standard.string(forKey: "userName") ?? "Not Registered")
                    userFriendName = String(UserDefaults.standard.string(forKey: "userFriendName") ?? "Not Registered")
                    userGoal = String(UserDefaults.standard.string(forKey: "userGoal") ?? "10")
                    print(userName)
                    print(userFriendName)
                    print(userGoal)
                    print("1111111111111111111111111111111")
                    userName = "Not Registered"
                    followers = 0
                    following = 0
                    todayCommit = 0
                    contributionCount = "0"
                    withGithubDay = 0
                    contributionDateStart = "0000-00-00-------------"
                    contributionDateStop = "0000-00-00-------------"
                    commitCountMaxValue = 0
                    commitCountMinValue = 0
                    contributionCountDay = "0"
                    githubProfilePhotoURL = "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
                    mainInfoText1 = ""
                    mainInfoText2 = "설정 탭에서 GitHub 아이디를 등록해주세요!"
                    commitCountArr = [0.1, 0.1]
                    progressValue = 0.0
                    var formatter_time = DateFormatter()
                    formatter_time.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    refreshTime = formatter_time.string(from: Date()) + "에 커밋 정보가 업데이트됨"
                    loading = false
                    selection = 4
                    alertTitle = "내 GitHub 아이디가 등록되지 않았거나 존재하지 않는 아이디임"
                    alertBody = "\n내 GitHub 아이디가 등록되지 않았거나 존재하지 않는 아이디입니다.\n\n앱을 사용하기 전에 먼저 내 GitHub 아이디를 등록해야 해요.\n\n이 알림 밑에 있는 설정 화면에서 내 GitHub 아이디를 등록해주세요!"
                    showingAlert = true
                }
            }
        }
    }
    
    // GitHub로부터 친구의 커밋 정보를 받아오는 함수
    // getGithubContributions에서 이 함수를 자동으로 호출함
    // 현재 매우 비효율적이고 코드가 더러우므로 곧 리-코딩할 예정
    func getGithubFriendContributions(){
        contents = ""
        commitCountArr = []
        let URL = "https://github.com/users/" + userFriendName + "/contributions"
        let alamo = AF.request(URL, method: .get).validate(statusCode: 200..<300)
        alamo.responseString() { response in
            switch response.result{
            case .success(let value):
                let non_filtered_arr = value.components(separatedBy: "\n")
                var filtered_arr : [String] = []
                var non_filtered_commitCountArr : [Int] = []
                for i in 0..<non_filtered_arr.count {
                    if(non_filtered_arr[i].contains("data-date")){
                        filtered_arr.append(non_filtered_arr[i])
                    }
                }
                print(contributionDateStart.dropLast(19))
                print(contributionDateStop.dropLast(19))
                var commitCount = 0
                for i in 0..<filtered_arr.count {
                    non_filtered_commitCountArr.append(Int(filtered_arr[i].components(separatedBy: "=")[8].dropLast(11).dropFirst(1))!)
                    contents = contents + filtered_arr[i].components(separatedBy: "=")[9].dropLast(12).dropFirst(1) + " : "
                    contents = contents + filtered_arr[i].components(separatedBy: "=")[8].dropLast(11).dropFirst(1) + "\n"
                    commitCount = commitCount + Int(filtered_arr[i].components(separatedBy: "=")[8].dropLast(11).dropFirst(1))!
                }
                contributionFriendCount = String(commitCount)
                print(filtered_arr[0].components(separatedBy: "=")[8].dropLast(11).dropFirst(1))
                print(filtered_arr[0].components(separatedBy: "=")[9].dropLast(12).dropFirst(1))
                print(commitCountArr)
                print(commitCountArr.count)
                todayFriendCommit = non_filtered_commitCountArr[non_filtered_commitCountArr.count - 1]
                let calendar = Calendar.current
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                var daysCount:Int = 0
                func calculateDays() {
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let startDate = dateFormatter.date(from: String(githubFriendStartDate.dropLast(10)))
                    daysCount = days(from: startDate!)
                    let hundred = calendar.date(byAdding: .day, value: 100, to: startDate!)
                    print(">>>!!!@@@ " + String(daysCount))
                }
                func days(from date: Date) -> Int {
                    return calendar.dateComponents([.day], from: date, to: currentDate).day! + 1
                }
                calculateDays()
                print(">>> " + String(daysCount))
                withGithubFriendDay = daysCount
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
                print("2222222222222222222222222222222")
                print(userName)
                print(userFriendName)
                print(userGoal)
                userName = String(UserDefaults.standard.string(forKey: "userName") ?? "Not Registered")
                userFriendName = String(UserDefaults.standard.string(forKey: "userFriendName") ?? "Not Registered")
                userGoal = String(UserDefaults.standard.string(forKey: "userGoal") ?? "10")
                print(userName)
                print(userFriendName)
                print(userGoal)
                print("2222222222222222222222222222222")
                userFriendName = "Not Registered"
                Friendfollowers = 0
                Friendfollowing = 0
                todayFriendCommit = 0
                contributionFriendCount = "0"
                githubFriendProfilePhotoURL = "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
            }
        }
    }
    
    // GitHub로부터 검색한 유저의 커밋 정보를 받아오는 함수
    // 현재 검색 기능이 사라져 사용되지 않는 함수임
    // 현재 매우 비효율적이고 코드가 더러우므로 곧 리-코딩할 예정
    func getGithubUserContributions(){
        userUserName = userUserNameSearch
        getUserGithubInfos()
        contents = ""
        commitUserCountArr = []
        let URL = "https://github.com/users/" + userUserName + "/contributions"
        let alamo = AF.request(URL, method: .get).validate(statusCode: 200..<300)
        alamo.responseString() { response in
            switch response.result{
            case .success(let value):
                let non_filtered_arr = value.components(separatedBy: "\n")
                var filtered_arr : [String] = []
                var non_filtered_commitCountArr : [Int] = []
                for i in 0..<non_filtered_arr.count {
                    if(non_filtered_arr[i].contains("data-from")){
                        let contributionDateStart_non_filtered_arr = non_filtered_arr[i].components(separatedBy: "=")
                        var temp_cutting_text = contributionDateStart_non_filtered_arr[1]
                        temp_cutting_text = String(temp_cutting_text.dropLast(1))
                        temp_cutting_text = String(temp_cutting_text.dropFirst(1))
                        contributionUserDateStart = temp_cutting_text
                    }
                    else if(non_filtered_arr[i].contains("data-to")){
                        let contributionDateStart_non_filtered_arr = non_filtered_arr[i].components(separatedBy: "=")
                        var temp_cutting_text = contributionDateStart_non_filtered_arr[1]
                        temp_cutting_text = String(temp_cutting_text.dropLast(1))
                        temp_cutting_text = String(temp_cutting_text.dropFirst(1))
                        contributionUserDateStop = temp_cutting_text
                    }
                    else if(non_filtered_arr[i].contains("data-date")){
                        filtered_arr.append(non_filtered_arr[i])
                    }
                }
                print(contributionUserDateStart.dropLast(19))
                print(contributionUserDateStop.dropLast(19))
                var commitCount = 0
                for i in 0..<filtered_arr.count {
                    non_filtered_commitCountArr.append(Int(filtered_arr[i].components(separatedBy: "=")[8].dropLast(11).dropFirst(1))!)
                    contents = contents + filtered_arr[i].components(separatedBy: "=")[9].dropLast(12).dropFirst(1) + " : "
                    contents = contents + filtered_arr[i].components(separatedBy: "=")[8].dropLast(11).dropFirst(1) + "\n"
                    commitCount = commitCount + Int(filtered_arr[i].components(separatedBy: "=")[8].dropLast(11).dropFirst(1))!
                }
                commitUserCountMaxValue = non_filtered_commitCountArr.max()!
                commitUserCountMinValue = non_filtered_commitCountArr.min()!
                for i in 0..<non_filtered_commitCountArr.count {
                    commitUserCountArr.append(Double(non_filtered_commitCountArr[i]) / Double(non_filtered_commitCountArr.max()!))
                }
                contributionUserCount = String(filtered_arr.count)
                print(filtered_arr[0].components(separatedBy: "=")[8].dropLast(11).dropFirst(1))
                print(filtered_arr[0].components(separatedBy: "=")[9].dropLast(12).dropFirst(1))
                print(commitUserCountArr)
                print(commitUserCountArr.count)
                contributionUserCountDay = contributionUserCount
                contributionUserCount = String(commitCount)
                todayUserCommit = non_filtered_commitCountArr[non_filtered_commitCountArr.count - 1]
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
                userUserName = "Not Registered"
                Userfollowers = 0
                Userfollowing = 0
                todayUserCommit = 0
                contributionUserCount = "0"
                contributionUserDateStart = "0000-00-00-------------"
                contributionUserDateStop = "0000-00-00-------------"
                commitUserCountMaxValue = 0
                commitUserCountMinValue = 0
                contributionUserCountDay = "0"
                withGithubUserDay = 0
                githubUserProfilePhotoURL = "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
                commitUserCountArr = [0.1, 0.1]
            }
        }
    }
    
    // GitHub로부터 유저 정보를 받아오는 함수
    // getGithubContributions에서 isAll에 따라 이 함수를 자동으로 호출함
    // 현재 매우 비효율적이고 코드가 더러우므로 곧 리-코딩할 예정
    func getGithubInfos(){
        print("❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️")
        let URL = "https://api.github.com/users/" + userName
        print("https://api.github.com/users/" + userName)
        let alamo = AF.request(URL, method: .get).validate(statusCode: 200..<300)
        alamo.responseJSON() { response in
            switch response.result{
            case .success(let JSON):
                do {
                    print("Success with JSON: \(JSON)")
                    let response = JSON as! NSDictionary
                    githubProfilePhotoURL = response.object(forKey: "avatar_url") as! String
                    followers = response.object(forKey: "followers") as! Int
                    following = response.object(forKey: "following") as! Int
                    githubStartDate = response.object(forKey: "created_at") as! String
                    UserDefaults.standard.set(githubProfilePhotoURL, forKey: "githubProfilePhotoURL")
                    UserDefaults.standard.set(followers, forKey: "followers")
                    UserDefaults.standard.set(following, forKey: "following")
                    UserDefaults.standard.set(githubStartDate, forKey: "githubStartDate")
                    var formatter_time = DateFormatter()
                    formatter_time.dateFormat = "yyyy-MM-dd"
                    lastGetApiTime = formatter_time.string(from: Date())
                    UserDefaults.standard.set(lastGetApiTime, forKey: "lastGetApiTime")
                } catch {
                    print("Err")
                }
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
                print("3333333333333333333333333333333")
                print(userName)
                print(userFriendName)
                print(userGoal)
                userName = String(UserDefaults.standard.string(forKey: "userName") ?? "Not Registered")
                userFriendName = String(UserDefaults.standard.string(forKey: "userFriendName") ?? "Not Registered")
                userGoal = String(UserDefaults.standard.string(forKey: "userGoal") ?? "10")
                print(userName)
                print(userFriendName)
                print(userGoal)
                print("3333333333333333333333333333333")
                userName = "Not Registered"
            }
        }
    }
    
    // GitHub로부터 친구의 유저 정보를 받아오는 함수
    // getGithubContributions에서 isAll에 따라 이 함수를 자동으로 호출함
    // 현재 매우 비효율적이고 코드가 더러우므로 곧 리-코딩할 예정
    func getFriendGithubInfos(){
        let URL = "https://api.github.com/users/" + userFriendName
        let alamo = AF.request(URL, method: .get).validate(statusCode: 200..<300)
        alamo.responseJSON() { response in
            switch response.result{
            case .success(let JSON):
                do {
                    print("Success with JSON: \(JSON)")
                    let response = JSON as! NSDictionary
                    githubFriendProfilePhotoURL = response.object(forKey: "avatar_url") as! String
                    Friendfollowers = response.object(forKey: "followers") as! Int
                    Friendfollowing = response.object(forKey: "following") as! Int
                    UserDefaults.standard.set(githubFriendProfilePhotoURL, forKey: "githubFriendProfilePhotoURL")
                    UserDefaults.standard.set(Friendfollowers, forKey: "Friendfollowers")
                    UserDefaults.standard.set(Friendfollowing, forKey: "Friendfollowing")
                    let calendar = Calendar.current
                    let currentDate = Date()
                    let dateFormatter = DateFormatter()
                    var daysCount:Int = 0
                    func calculateDays() {
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let startDate = dateFormatter.date(from: String(String(response.object(forKey: "created_at") as! String).dropLast(10)))
                        daysCount = days(from: startDate!)
                        let hundred = calendar.date(byAdding: .day, value: 100, to: startDate!)
                        print(">>>!!!@@@ " + String(daysCount))
                    }
                    func days(from date: Date) -> Int {
                        return calendar.dateComponents([.day], from: date, to: currentDate).day! + 1
                    }
                    calculateDays()
                    print(">>> " + String(daysCount))
                    withGithubFriendDay = daysCount
                } catch {
                    print("Err")
                }
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
                print("4444444444444444444444444444444")
                print(userName)
                print(userFriendName)
                print(userGoal)
                userName = String(UserDefaults.standard.string(forKey: "userName") ?? "Not Registered")
                userFriendName = String(UserDefaults.standard.string(forKey: "userFriendName") ?? "Not Registered")
                userGoal = String(UserDefaults.standard.string(forKey: "userGoal") ?? "10")
                print(userName)
                print(userFriendName)
                print(userGoal)
                print("4444444444444444444444444444444")
                userFriendName = "Not Registered"
            }
        }
    }
    
    // GitHub로부터 검색한 유저의 유저 정보를 받아오는 함수
    // 현재 검색 기능이 사라져 사용되지 않는 함수임
    // 현재 매우 비효율적이고 코드가 더러우므로 곧 리-코딩할 예정
    func getUserGithubInfos(){
        let URL = "https://api.github.com/users/" + userUserName
        let alamo = AF.request(URL, method: .get).validate(statusCode: 200..<300)
        alamo.responseJSON() { response in
            switch response.result{
            case .success(let JSON):
                do {
                    print("Success with JSON: \(JSON)")
                    let response = JSON as! NSDictionary
                    githubUserProfilePhotoURL = response.object(forKey: "avatar_url") as! String
                    Userfollowers = response.object(forKey: "followers") as! Int
                    Userfollowing = response.object(forKey: "following") as! Int
                    let calendar = Calendar.current
                    let currentDate = Date()
                    let dateFormatter = DateFormatter()
                    var daysCount:Int = 0
                    func calculateDays() {
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let startDate = dateFormatter.date(from: String(String(response.object(forKey: "created_at") as! String).dropLast(10)))
                        daysCount = days(from: startDate!)
                        let hundred = calendar.date(byAdding: .day, value: 100, to: startDate!)
                        print(">>>!!!@@@ " + String(daysCount))
                    }
                    func days(from date: Date) -> Int {
                        return calendar.dateComponents([.day], from: date, to: currentDate).day! + 1
                    }
                    calculateDays()
                    print(">>> " + String(daysCount))
                    withGithubUserDay = daysCount
                } catch {
                    print("Err")
                }
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
                userUserName = "Not Registered"
            }
        }
    }
}

// 사파리 팝업(인앱 브라우저)
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

// 키보드를 숨겨주는 익스텐션
// hideKeyboard를 호출하면 숨겨짐
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
