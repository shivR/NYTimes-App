//
//  ArticleService.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

final class ArticleService: BaseService {
    enum Routes {
        case mostviewed
    }

    private var route: Routes

    private enum Constants {
        static let mostviewed = "/svc/mostpopular/v2/mostviewed/all-sections/7.json"
    }

    private enum Endpoint {
        case mostviewed

        var path: String {
            switch self {
            case .mostviewed:
                return Constants.mostviewed
            }
        }
    }

    var endpoint: String {
        switch route {
        case .mostviewed:
            return Endpoint.mostviewed.path
        }
    }

    var httpMethod: String {
        switch route {
        case .mostviewed:
            return HttpMethod.GET.rawValue
        }
    }

    var requestParameters: [String: String]? {
        switch route {
        case .mostviewed:
            return nil
        }
    }

    init(route: Routes) {
        self.route = route
    }
}
