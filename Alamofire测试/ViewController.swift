//
//  ViewController.swift
//  Alamofire测试
//
//  Created by 翟旭博 on 2023/6/9.
//

import UIKit
import Alamofire
//https://news-at.zhihu.com/api/4/news/latest
class ViewController: UIViewController {
    struct DailyNews: Codable {
        let date: String
        let stories: [Story]
        let topStories: [TopStory]

        enum CodingKeys: String, CodingKey {
            case date, stories
            case topStories = "top_stories"
        }
    }

    struct Story: Codable {
        let imageHue: String
        let title: String
        let url: String
        let hint: String
        let gaPrefix: String
        let images: [String]
        let type: Int
        let id: Int

        enum CodingKeys: String, CodingKey {
            case imageHue = "image_hue"
            case title, url, hint
            case gaPrefix = "ga_prefix"
            case images, type, id
        }
    }

    struct TopStory: Codable {
        let imageHue: String
        let hint: String
        let url: String
        let image: String
        let title: String
        let gaPrefix: String
        let type: Int
        let id: Int

        enum CodingKeys: String, CodingKey {
           case imageHue = "image_hue"
           case hint, url, image, title
           case gaPrefix = "ga_prefix"
           case type, id
       }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("https://news-at.zhihu.com/api/4/news/latest").responseJSON { response in
            switch response.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                        let decoder = JSONDecoder()
                        //decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let latestNews = try decoder.decode(DailyNews.self, from: jsonData)
                        print(latestNews.stories[0].title)
                        // 解析成功，可以使用 latestNews 对象进行后续操作
                    } catch {
                        print(error)
                        // 解析错误，处理异常情况
                    }
                case .failure(let error):
                    // 请求失败
                    print(error)
                }
        }
    }


}

