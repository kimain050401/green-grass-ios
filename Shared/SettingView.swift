//
//  SettingView.swift
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

struct SettingView: View {
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
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        VStack{
                            HStack{
                                Text("내 GitHub 아이디")
                                    .bold()
                                Spacer()
                            }
                            HStack{
                                TextField("", text: $userName)
                                    .multilineTextAlignment(.leading)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .keyboardType(.alphabet)
                                    .onTapGesture{
                                        showSaveButton1 = true
                                        if userName == "Not Registered"{
                                            userName = ""
                                        }
                                    }
                                Button(action: {
                                    if showSaveButton1 == false{
                                        userName = ""
                                        UserDefaults.standard.set("Not Registered", forKey: "userName")
                                        showSaveButton1 = true
                                    } else{
                                        UserDefaults.standard.set(userName, forKey: "userName")
                                        showSaveButton1 = false
                                        hideKeyboard()
                                        if(ContentView().internetTest() == true){
                                            ContentView().getGithubContributions(isAll: true)
                                        }
                                        self.alertTitle = "프로필 정보 새로고침됨"
                                        self.alertBody = "프로필 정보(프사, 팔로워, 팔로잉)가 새로고침되어 프로필 정보가 업데이트되었습니다."
                                        self.showingAlert = true
                                    }
                                }, label: {
                                    if showSaveButton1 == false{
                                        Image(systemName: "xmark")
                                            .foregroundColor(Color.DarkmodeText)
                                    } else{
                                        Text("저장")
                                            .bold()
                                            .foregroundColor(Color(red: 82 / 255, green: 164 / 255, blue: 80 / 255))
                                    }
                                })
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.DarkmodeText, lineWidth: 1)
                            )
                        }
                        .padding()
                        .background(Color.ContentBoxBackground)
                        .cornerRadius(15)
                        .padding(.bottom)
                        VStack{
                            HStack{
                                Text("친구 GitHub 아이디")
                                    .bold()
                                Spacer()
                            }
                            HStack{
                                TextField("", text: $userFriendName)
                                    .multilineTextAlignment(.leading)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .keyboardType(.alphabet)
                                    .onTapGesture{
                                        showSaveButton2 = true
                                        if userFriendName == "Not Registered"{
                                            userFriendName = ""
                                        }
                                    }
                                Button(action: {
                                    if showSaveButton2 == false{
                                        userFriendName = ""
                                        UserDefaults.standard.set("Not Registered", forKey: "userFriendName")
                                        showSaveButton2 = true
                                    } else{
                                        UserDefaults.standard.set(userFriendName, forKey: "userFriendName")
                                        showSaveButton2 = false
                                        hideKeyboard()
                                        if(ContentView().internetTest() == true){
                                            ContentView().getGithubContributions(isAll: true)
                                        }
                                        self.alertTitle = "프로필 정보 새로고침됨"
                                        self.alertBody = "프로필 정보(프사, 팔로워, 팔로잉)가 새로고침되어 프로필 정보가 업데이트되었습니다."
                                        self.showingAlert = true
                                    }
                                }, label: {
                                    if showSaveButton2 == false{
                                        Image(systemName: "xmark")
                                            .foregroundColor(Color.DarkmodeText)
                                    } else{
                                        Text("저장")
                                            .bold()
                                            .foregroundColor(Color(red: 82 / 255, green: 164 / 255, blue: 80 / 255))
                                    }
                                })
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.DarkmodeText, lineWidth: 1)
                            )
                        }
                        .padding()
                        .background(Color.ContentBoxBackground)
                        .cornerRadius(15)
                        .padding(.bottom)
                        VStack{
                            HStack{
                                Text("내 GitHub 커밋 목표")
                                    .bold()
                                Spacer()
                            }
                            HStack{
                                TextField("", text: $userGoalInput)
                                    .multilineTextAlignment(.leading)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .keyboardType(.numberPad)
                                    .onTapGesture{
                                        showSaveButton3 = true
                                        if userGoalInput == "Not Registered"{
                                            userGoalInput = "0"
                                            userGoal = "0"
                                        }
                                    }
                                Button(action: {
                                    if showSaveButton3 == false{
                                        userGoalInput = "0"
                                        userGoal = "0"
                                        UserDefaults.standard.set("0", forKey: "userGoal")
                                        showSaveButton3 = true
                                    } else{
                                        var isNumberTest = userGoal.allSatisfy({ $0.isNumber })
                                        if(userGoalInput == "" || isNumberTest == false || userGoalInput.count > 18){
                                            userGoalInput = "0"
                                            userGoal = "0"
                                            alertTitle = "설정 불가능"
                                            alertBody = "입력하신 수가 설정 가능한 범위를 넘었습니다. 설정 가능한 범위는 ~999,999,999,999,999,999입니다."
                                            showingAlert = true
                                        }
                                        userGoal = userGoalInput
                                        UserDefaults.standard.set(userGoal, forKey: "userGoal")
                                        showSaveButton3 = false
                                        hideKeyboard()
                                        if(ContentView().internetTest() == true){
                                            ContentView().getGithubContributions(isAll: false)
                                        }
                                    }
                                }, label: {
                                    if showSaveButton3 == false{
                                        Image(systemName: "xmark")
                                            .foregroundColor(Color.DarkmodeText)
                                    } else{
                                        Text("저장")
                                            .bold()
                                            .foregroundColor(Color(red: 82 / 255, green: 164 / 255, blue: 80 / 255))
                                    }
                                })
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.DarkmodeText, lineWidth: 1)
                            )
                        }
                        .padding()
                        .background(Color.ContentBoxBackground)
                        .cornerRadius(15)
                        .padding(.bottom)
                        VStack{
                            HStack{
                                Text("1일 1커밋 알림")
                                    .bold()
                                Spacer()
                                Toggle("1일 1커밋 알림", isOn: $commitAlert)
                                    .foregroundColor(Color.DarkmodeText)
                                    .font(Font.body.weight(.bold))
                                    .labelsHidden()
                            }
                            if commitAlert{
                                HStack{
                                    Spacer()
                                    if showSaveButton5{
                                        Button(action: {
                                            if(Int(selectPushAlertTimeHour)! < 0 || Int(selectPushAlertTimeHour)! > 24){
                                                alertTitle = "설정 불가능"
                                                alertBody = "입력하신 수가 설정 가능한 범위를 넘었습니다. 설정 가능한 범위는 0~23시입니다."
                                                showingAlert = true
                                                selectPushAlertTimeHour = "23"
                                            }
                                            else if(Int(selectPushAlertTimeMinute)! < 0 || Int(selectPushAlertTimeMinute)! > 59){
                                                alertTitle = "설정 불가능"
                                                alertBody = "입력하신 수가 설정 가능한 범위를 넘었습니다. 설정 가능한 범위는 0~59분입니다."
                                                showingAlert = true
                                                selectPushAlertTimeMinute = "00"
                                            } else{
                                                UserDefaults.standard.set(selectPushAlertTimeHour, forKey: "selectPushAlertTimeHour")
                                                UserDefaults.standard.set(selectPushAlertTimeMinute, forKey: "selectPushAlertTimeMinute")
                                                LocalNotificationManager().removeNotifications()
                                                ContentView().setNotification()
                                            }
                                            hideKeyboard()
                                            showSaveButton5 = false
                                        }, label: {
                                            Text("저장")
                                        })
                                    }
                                    Text("매일")
                                    TextField("", text: $selectPushAlertTimeHour)
                                        .textFieldStyle(.roundedBorder)
                                        .frame(width: 50)
                                        .multilineTextAlignment(.center)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .keyboardType(.numberPad)
                                        .onTapGesture{
                                            showSaveButton5 = true
                                        }
                                    Text(":")
                                    TextField("", text: $selectPushAlertTimeMinute)
                                        .textFieldStyle(.roundedBorder)
                                        .frame(width: 50)
                                        .multilineTextAlignment(.center)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .keyboardType(.numberPad)
                                        .onTapGesture{
                                            showSaveButton5 = true
                                        }
                                    Text("에 알림")
                                }
                                .padding(.top, 4)
                            }
                        }
                        .padding()
                        .background(Color.ContentBoxBackground)
                        .cornerRadius(15)
                        .padding(.bottom)
                        HStack{
                            Text("프로필 정보 새로고침")
                                .font(Font.body.weight(.bold))
                            Spacer()
                            if loading{
                                ProgressView()
                            } else{
                                Button(action: {
                                    hideKeyboard()
                                    if(ContentView().internetTest() == true){
                                        ContentView().getGithubContributions(isAll: true)
                                    }
                                    self.alertTitle = "프로필 정보 새로고침됨"
                                    self.alertBody = "프로필 정보(프사, 팔로워, 팔로잉)가 새로고침되어 프로필 정보가 업데이트되었습니다."
                                    self.showingAlert = true
                                }, label: {
                                    Image(systemName: "arrow.clockwise")
                                        .font(Font.body.weight(.bold))
                                        .foregroundColor(Color(red: 82 / 255, green: 164 / 255, blue: 80 / 255))
                                })
                            }
                        }
                        .padding()
                        .background(Color.ContentBoxBackground)
                        .cornerRadius(15)
                        .padding(.bottom)
                        VStack{
                            HStack{
                                Text("기타")
                                    .font(Font.body.weight(.bold))
                                Spacer()
                                Button(action: {
                                    urlString = "https://green-grass.tech/support"
                                    showSafari = true
                                }, label: {
                                    Text("문의하기")
                                        .font(Font.body.weight(.regular))
                                        .foregroundColor(Color(red: 82 / 255, green: 164 / 255, blue: 80 / 255))
                                })
                                Text("|")
                                    .foregroundColor(Color.gray)
                                Link("오픈소스", destination: URL(string: "https://green-grass.tech/open_source")!)
                                Text("|")
                                    .foregroundColor(Color.gray)
                                Link("개발자 정보", destination: URL(string: "https://green-grass.tech/dev_info")!)
                            }
                        }
                        .padding()
                        .background(Color.ContentBoxBackground)
                        .cornerRadius(15)
                        .padding(.bottom)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
        }

    }
}
//
//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
