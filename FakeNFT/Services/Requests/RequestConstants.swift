enum RequestConstants {
    #warning("insert your baseUrl <id>.mockapi.io")
    static let baseURL = URLType.mock
}
enum URLType {
    static let mock = "https://64858e8ba795d24810b71189.mockapi.io"
    static let test = "https://d5dn3j2ouj72b0ejucbl.apigw.yandexcloud.net"
}
/*
 Для тестинга работоспособности необходимо использовать Mock URL:
 В тестовом URL отсутствует возможность подгрузить Мои NFT через Postman(не проходит оплата ордера), приходят наполовину нерабочие NFT с одинаковыми аватарами, валюта и рейтинг координально отличаются от макета.
 */
