//
//  TermsConditionsViewController.swift
//  uChoice
//
//  Created by iOS Developer on 26/06/2020.
//  Copyright © 2020 Mobile Goru. All rights reserved.
//

import UIKit

class TermsConditionsViewController: UIViewController {
    
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var txtVu: UITextView!
    
    var comefromSettings = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtVu.text = privacytext
        
        txtVu.layer.cornerRadius = 24
       
    }
    
    
    
    @IBAction func actionAccept(_ sender: Any) {
        if comefromSettings{
            self.navigationController?.popViewController(animated: true)
        }else{
    let storyboard = UIStoryboard(name: "Registeration", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SendVerificationController") as? SendVerificationController
        self.navigationController?.pushViewController(vc!, animated: true)
        }
       
    }
    
    @IBAction func actionDecline(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionOne(_ sender: Any) {
    }
    
    @IBAction func actionTwo(_ sender: Any) {
    }
    
    
}
var privacytext = """
This is the Privacy Policy of Hyperconnect, Inc., which shall be the data controller, and ur'Choice and its various & next versions including ur'Choice web version, “ur'Choice Web” (collectively hereinafter, “ur'Choice”, “us”, “we”, or “our”). In this Privacy Policy, we refer to our products and services as the “Service.” Please read on to learn more about our data handling practices. Your use of the Service signifies that you agree with the terms of this Privacy Policy. If you wish to proceed to the Service, please click on I agree tabs which shall allow us to collect your certain personal information or data. We ask for and collect the following personal information about you when you install the Service on your device and register with ur'Choice. This information is necessary for the adequate performance of the contract between you and us and to allow us to comply with our legal obligations. Without such information, we may not be able to provide you with all the requested services. ● Your mobile phone number or your email address; ● gender, name, geographical location of your residence; ● identity verification information (such as images of your government issued ID, passport, national ID card, or driving license, as permitted by applicable laws) or other authentication information;
● usage of and interaction with the Service and our websites, including matches, numbers of matches made by members, match durations, text messages, usage by geographies, device and connection information, IP address, device capability, bandwidth, statistics on page views, network type and traffic to and from our websites;
● your payment information, including your credit card number, card expiration date, CVV code, and billing address. In that event, we will transmit your information securely directly to a third party vendor or merchant who will collect such information in order to process and fulfill your purchase. ur'Choice does not process or store your payment information. However, we may store other information about your purchases made on the Service, which may include the merchant’s name, the date, time and amount of the transaction and other behavioral information;
● error-reporting information if the Service crashes or hangs up so that we can investigate the error and improve the stability of the Service for future releases. In general these reports do not contain personally identifiable information, or only incidentally. As part of these error reports, we receive information about the type and version of your device, the device identifier, the time the error occurred, the feature being used and the state of the application when the error occurred. We do not use this information for any purpose other than investigating and fixing the error. We will not rent or sell your information to third parties (or the group of companies of which Hyperconnect Inc., and ur'Choice is a part) without your consent, except as noted in this Policy. Parties with whom we may share your information: We may share user contents such as photos, screenshots, comments, or other materials that you make publicly available through the Service (hereinafter referred to as “User Content)” and your information (including but not limited to, information from cookies, log files, device identifiers, location data, and usage data) with businesses that are legally part of the same group of companies that ur'Choice is part of, or that become part of that group (\"Affiliates\"). Affiliates may use this information to help provide, understand, and improve the Service (including by providing analytics) and Affiliates\' own services (including by providing you with better and more relevant experiences). But these Affiliates will honor the choices you make about who can see your contents.
● We also may share your information as well as information from tools like cookies, log files, and device identifiers and location data, with third-party organizations that help us provide the Service to you (\"Service Providers\"). Our Service Providers will be given access to your information as is reasonably necessary to provide the Service under reasonable confidentiality terms.
● We may also share aggregate or anonymous information with third parties, including advertisers and investors. For example, we may tell our advertisers the number of users our application receives. This information does not contain any personal or personally identifiable information, and is used to develop content and services that we hope you will find of interest.
● We may remove parts of data that can identify you and share anonymized data with other parties. We may also combine your information with other information in a way that it is no longer associated with you and share that aggregated information. Parties with whom you may choose to share your User Content:
● Any information or content that you voluntarily disclose for posting to the Service, such as User Content, becomes available to the public. With this feature, ur'Choice can be protected from exhibitionism. Once you have shared User Content or made it public, that User Content may be re-shared by others.
● Although you remove information and User Content, copies may remain viewable in cached and archived pages of the Service, or other users or third parties such as Facebook may have copied or saved that information. We use, store, and process information, including personal information, about you to provide, understand, improve, and develop the Service, create and maintain a trusted and safer environment and comply with our legal obligations.  Provide, understand, improve, and develop the Service
● To connect you with others as enabled by the Service;
● To share your profile with others on the Service;
● To allow your use of certain features of the Service that may be offered from time to time;
● To show you the names of persons you communicate with and to show your name to persons you communicate with on the Service;
● To deliver to you any administrative notices, alerts and communications relevant to your use of the Service; ● To provide you with relevant content that you requested, using information that you allow us to collect from you or that you provide to a social media provider with which your ur'Choice account is connected, such as information regarding your and your ur'Choice contacts\' respective locations;
● To contact you via email, SMS or otherwise for the purpose of informing you about new products, services or promotions offered by ur'Choice (you can opt-out of such emails or SMSs by sending an email to help@uChoicelive.com);  Create and maintain a trusted and safer environment
● Detecting and protecting against error, fraud or other illegal activity;
● When we have a good faith belief that the law, any legal process, law enforcement, national security or issue of public importance requires disclosure;
● Verify or authenticate information or identifications provided by you (such as to verify your accommodation address or compare your identification photo to another photo you provide);
● To protect and defend our rights or property (including to enforce our Terms of Use and other agreements); or
● In connection with a corporate transaction involving ur'Choice, such as the purchase or sale of a business unit, an acquisition, merger, sale of assets, or other similar event.  Provide, Personalize, Measure, and Improve our Advertising and Marketing.
● Send you promotional messages, marketing, advertising, and other information that may be of interest to you based on your preferences (including information about ur'Choice campaigns and services) and social media advertising through social media platforms such as Facebook or Google);
● Research purpose to improve our Service;
● Personalize, measure, and improve our advertising;
● Administer referral programs, rewards, surveys, contests, or other promotional activities or events sponsored or managed by Hyperconnect Inc., or its third party partners.
● Conduct profiling on your characteristics and preferences (based on the information you provide to us, your interactions with the Service) to send you promotional messages, marketing, advertising and other information that we think may be of interest to you.
● We will process your personal information for the purposes listed in this section given our legitimate interest in undertaking marketing activities to offer you products or services that may be of your interest. You can opt-out of such emails or SMSs by sending an email to help@uChoicelive.com  You may exercise any of the rights described in this section before ur'Choice and Hyperconnect Inc., the data controller, by sending an email to help@uChoicelive.com. Please note that we may ask you to verify your identity before taking further action on your request.  Managing Your Information.  You may access and update some of your information through your account settings. If you have chosen to connect your service account to a third-party application, like Facebook or Google, you can change your settings and remove permission for the app by changing your account settings. You are responsible for keeping your personal information up-to-date.  Rectification of Inaccurate or Incomplete Information.  You have the right to ask us to correct inaccurate or incomplete personal information concerning you.  Data Access and Portability.  In some jurisdictions, applicable law may entitle you to request copies of your personal information held by us. You may also be entitled to request copies of personal information that you have provided to us in a structured, commonly used, and machine-readable format and/or request us to transmit this information to another service provider (where technically feasible).  Data Retention and Erasure.  We generally retain your personal information for as long as is necessary for the performance of the contract between you and us and to comply with our legal obligations. If you no longer want us to use your information, you can request that we erase your personal information and close your account. Please note that if you request the erasure of your personal information:
● We may retain some of your personal information as necessary for our legitimate business interests, such as fraud detection and prevention and enhancing safety.
● We may retain and use your personal information to the extent necessary to comply with our legal obligations such as, tax, legal reporting and auditing obligations.
● Information you have shared with others (e.g., reviews, forum postings) may continue to be publicly visible on the ur'Choice, even after your cancellation of your account. However, attribution of such information to you will be removed. Additionally, some copies of your information (e.g., log records) may remain in our database, but are disassociated from personal identifiers.
● Because we maintain the Service to protect from accidental or malicious loss and destruction, residual copies of your personal information may not be removed from our backup systems for a limited period of time.  Withdrawing Consent and Restriction of Processing.  Where you have provided your consent to the processing of your personal information by us, you may withdraw your consent at any time. Please note that the withdrawal of your consent does not affect the lawfulness of any processing activities based on such consent before its withdrawal. Additionally, in some jurisdictions, applicable law may give you the right to limit the ways in which we use your personal information, in particular where (i) you contest the accuracy of your personal information; (ii) the processing is unlawful and you oppose the erasure of your personal information; or (iii) we no longer need your personal information for the purposes of the processing, but you require the information for the establishment, exercise or defence of legal claims.  Objection to Processing.  In some jurisdictions, applicable law may entitle you to require us not to process your personal information for certain specific purposes (including profiling) where such processing is based on legitimate interest. If you object to such processing, we will no longer process your personal information for these purposes unless we can demonstrate compelling legitimate grounds for such processing or such processing is required for the establishment, exercise or defence of legal claims. Where your personal information is processed for direct marketing purposes, you may, at any time ask ur'Choice or Hyperconnect Inc., to cease processing your data for these direct marketing purposes by sending an e-mail to [help@uChoicelive.com].  Lodging Complaints.  You have the right to lodge complaints about the data processing activities carried out by ur'Choice before the competent data protection authorities.  Security  Protecting user privacy and personal information is a top priority for Hyperconnect, Inc. and ur'Choice. We make substantial efforts to ensure the privacy of all personally identifiable information you provide to us. Access to all personally identifiable information is restricted to those Hyperconnect, Inc. and ur'Choice employees, contractors, agents and third-party service providers who need to know that information in order to provide, operate, develop, maintain, support or improve the Service. Hyperconnect Inc. and ur'Choice uses password protection, access logs, and system monitoring to safeguard the confidentiality and security of all member information. In addition, due to the inherent nature of the Internet and related technology, we do not guarantee the protection of information under our control against loss, misuse or alteration.  Age The Service is not directed to children under the age of sixteen (16) and we do not knowingly collect personally identifiable information from children under the age of sixteen as part of the Service. If we become aware that we have inadvertently received personally identifiable information from a user under the age of sixteen as part of the Service, we will delete such information from our records. If we change our practices in the future, we will obtain prior, verifiable parental consent before collecting any personally identifiable information from children under the age of sixteen as part of the Service.  Notification of Changes  We reserve the right at our discretion to make changes to this Privacy Policy. You may review updates to our Privacy Policy at any time via links on our website. You agree to accept electronic communications and/or postings of a revised Privacy Policy on the Hyperconnect inc and ur'Choice web site, and you agree that such electronic communications or postings constitute notice to you of the Privacy Policy. We reserve the right to modify this policy from time to time, so please review it frequently. If we make material changes to this policy, we will notify you by publishing a revised Privacy Policy or by means of a notice on our website, or as required by law. You agree to review the Privacy Policy periodically so that you are aware of any modifications. You agree that your continued use of the Service after we publish a revised Privacy Policy or provide a notice on our website constitutes your acceptance of the revised Privacy Policy.  Contact Information  If you have any questions about this Privacy Policy. Any personally identifiable information provided in connection with inquiries related to this Privacy Policy will be used solely for the purpose of responding to the inquiry and consistent with our Privacy Policy.
"""


